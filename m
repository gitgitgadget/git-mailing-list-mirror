From: "Adam Kropelin" <akropel1@rochester.rr.com>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:42:32 -0400
Message-ID: <011201c542d5$940bb670$03c8a8c0@kroptech.com>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org> <12c511ca050416152452a4c620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 00:39:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvwI-0000B8-Uq
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDPWml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVDPWml
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:42:41 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42976 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261170AbVDPWmk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:42:40 -0400
Received: from mail.kroptech.com (cpe-24-93-20-125.rochester.res.rr.com [24.93.20.125])
	by ms-smtp-02.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id j3GMgXJj021819;
	Sat, 16 Apr 2005 18:42:33 -0400 (EDT)
Received: from pia (pia.kroptech.com [192.168.200.3])
	by mail.kroptech.com (Postfix) with SMTP id E051E11376E;
	Sat, 16 Apr 2005 18:51:15 -0400 (EDT)
To: "Tony Luck" <tony.luck@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tony Luck wrote:
> Otherwise this looks really nice.  I was going to script something
> similar using "wget" ... but that would have made zillions of seperate
> connections.  Not so kind to the server.

How about building a file list and doing a batch download via 'wget -i 
/tmp/foo'? A quick test (on my ancient wget-1.7) indicates that it reuses 
connectionss when successive URLs point to the same server.

Writing yet another http client does seem a bit pointless, what with wget 
and curl available. The real win lies in creating the smarts to get the 
minimum number of files.

--Adam

