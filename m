From: "Adam Kropelin" <akropel1@rochester.rr.com>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 18:52:42 -0400
Message-ID: <014a01c542d6$ff3e6180$03c8a8c0@kroptech.com>
References: <Pine.LNX.4.21.0504161844040.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Tony Luck" <tony.luck@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:49:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMx2r-0005tA-IU
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVDPXxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDPXxb
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:53:31 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:24805 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261208AbVDPXxa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:53:30 -0400
Received: from ms-smtp-03.nyroc.rr.com (ms-smtp-03.nyroc.rr.com [24.24.2.57])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j3GMr7wM005446
	for <git@vger.kernel.org>; Sat, 16 Apr 2005 15:53:08 -0700
Received: from mail.kroptech.com (cpe-24-93-20-125.rochester.res.rr.com [24.93.20.125])
	by ms-smtp-03.nyroc.rr.com (8.12.10/8.12.10) with ESMTP id j3GMqgP4012629;
	Sat, 16 Apr 2005 18:52:42 -0400 (EDT)
Received: from pia (pia.kroptech.com [192.168.200.3])
	by mail.kroptech.com (Postfix) with SMTP id 503C811376E;
	Sat, 16 Apr 2005 19:01:25 -0400 (EDT)
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
> On Sat, 16 Apr 2005, Adam Kropelin wrote:
>> How about building a file list and doing a batch download via 'wget
>> -i /tmp/foo'? A quick test (on my ancient wget-1.7) indicates that
>> it reuses connectionss when successive URLs point to the same server.
>
> You need to look at some of the files before you know what other
> files to get. You could do it in waves, but that would be excessively
> complicated to code and not the most efficient anyway.

Ah, yes. Makes sense. How about libcurl or another http client library, 
then? Minimizing dependencies on external libraries is good, but writing a 
really robust http client is a tricky business. (Not that you aren't up to 
it; I just wonder if it's the best way to spend your time.)

--Adam

