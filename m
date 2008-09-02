From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Mon, 01 Sep 2008 23:09:29 -0700
Message-ID: <48BCD899.3010805@zytor.com>
References: <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <7vwsi0a2op.fsf@gitster.siamese.dyndns.org> <48B784FD.3080005@zytor.com> <7vej488gcu.fsf@gitster.siamese.dyndns.org> <20080829173954.GG7403@spearce.org> <905315640809010905w20f4ceeo43e7b0a14abd48a3@mail.gmail.com> <20080902060608.GG13248@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tarmigan <tarmigan+git@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 08:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaP69-0006f1-C0
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 08:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYIBGJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 02:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbYIBGJf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 02:09:35 -0400
Received: from terminus.zytor.com ([198.137.202.10]:58453 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbYIBGJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 02:09:35 -0400
Received: from [172.27.2.85] (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m8269Tkg014959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Sep 2008 23:09:30 -0700
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080902060608.GG13248@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8137/Mon Sep  1 19:07:16 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94649>

Shawn O. Pearce wrote:
> 
> Correct.  Today _none_ of the transport protocols allow the server
> to force the client to use some sort of reference repository for an
> initial clone.  There are likely two reasons for this:
> 
>  *) Its a lot simpler to program to just get everything from
>     one location.
> 
>  *) If you really are forking an open source project then in
>     some cases you may need to distribute the full source,
> 	not your delta.  You may just as well distribute the full
> 	source and call it a day.
> 

3) it encourages single points of failure.

	-hpa
