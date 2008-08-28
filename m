From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:47:17 -0700
Message-ID: <48B6E4A5.7030605@zytor.com>
References: <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <20080828172853.GE21072@spearce.org> <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm> <20080828174334.GF21072@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:51:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYldD-0007cv-Hl
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbYH1Rrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756307AbYH1Rrq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:47:46 -0400
Received: from terminus.zytor.com ([198.137.202.10]:43725 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370AbYH1Rrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:47:37 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7SHlN9F006792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 10:47:23 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7SHlNvu026422;
	Thu, 28 Aug 2008 10:47:23 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7SHlHCH029828;
	Thu, 28 Aug 2008 10:47:17 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080828174334.GF21072@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8109/Thu Aug 28 07:33:58 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94105>

Shawn O. Pearce wrote:
>   GET /intl/en_ALL/images/logo.gif HTTP/1.0

> Anyway, I didn't send any browser data, so the server had to assume
> the dumbest f'ing browser on the planet, and I got back binary data.

Slight nitpick: you did (HTTP/1.0).  If you really want to show the 
bottom-of-the barrel behaviour, drop that off which gets you HTTP 0.x 
behaviour -- not exactly commonly encountered today :)  HTTP 0.x had no 
provisions for a request header, so you should not need to send a blank 
line after the GET.

	-hpa
