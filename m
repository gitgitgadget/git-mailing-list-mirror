From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 00:59:01 -0700
Organization: Linux Kernel Organization, Inc.
Message-ID: <48B50945.7020709@kernel.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>,	<20080826162513.GR10544@machine.or.cz>,	<20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <andi@firstfloor.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>
X-From: git-owner@vger.kernel.org Wed Aug 27 10:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYG17-0000Bl-Sk
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 10:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbYH0IDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 04:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYH0IDc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 04:03:32 -0400
Received: from terminus.zytor.com ([198.137.202.10]:42797 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226AbYH0ID3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 04:03:29 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7R7xCZL024858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 00:59:13 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7R7xC2q014034;
	Wed, 27 Aug 2008 00:59:12 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7R7x1aK012288;
	Wed, 27 Aug 2008 00:59:03 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-Virus-Scanned: ClamAV 0.93.3/8096/Tue Aug 26 17:21:28 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93870>

Ulrich Windl wrote:
> 
> In HP-UX many commands (or "subsystems") use /opt/<subsys>/{bin,sbin} to place 
> their binaries. PATH usually does not contain all of them. That's against Linux 
> philosophy I think, and I really don't like huge PATHs, but it may be one solution 
> to reduce the size of linear lists. It won't help against the git<TAB><TAB> issue 
> directly, however.
> 

/opt is part of the Filesystem Hierarchy Standard which defines layouts 
on Linux systems.  It is generally not used for binaries included in 
distributions or otherwise managed via distribution package managers, 
however.

	-hpa
