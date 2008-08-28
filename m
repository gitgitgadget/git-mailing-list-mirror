From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:44:19 -0700
Message-ID: <48B6E3F3.1070903@zytor.com>
References: <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com> <20080828171052.GC21072@spearce.org> <48B6DE7A.1020207@zytor.com> <20080828172623.GD21072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlbQ-0006qX-1H
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbYH1Rpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYH1Rp2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:45:28 -0400
Received: from terminus.zytor.com ([198.137.202.10]:54323 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbYH1RpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:45:24 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7SHiO1r006417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 10:44:25 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7SHiOco026415;
	Thu, 28 Aug 2008 10:44:24 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7SHiJuq029808;
	Thu, 28 Aug 2008 10:44:19 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080828172623.GD21072@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8109/Thu Aug 28 07:33:58 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94102>

Shawn O. Pearce wrote:
> 
> Should I change the HTTP protocol then to use the same format,
> so they have a better chance at sharing code between them?
> 

I leave that up to you and Junio.  My feel would that it's not worth 
optimizing the HTTP protocol separately.

	-hpa
