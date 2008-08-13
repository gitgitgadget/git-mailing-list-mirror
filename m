From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Add Git-aware CGI for Git-aware smart HTTP transport
Date: Wed, 13 Aug 2008 08:41:43 -0700
Message-ID: <48A300B7.10002@zytor.com>
References: <200808130326.m7D3Pr2V000918@terminus.zytor.com> <20080813032812.GD5855@spearce.org> <48A262B9.8020608@zytor.com> <20080813145341.GA3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:43:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTIVD-0000ES-NK
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYHMPlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYHMPlu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:41:50 -0400
Received: from terminus.zytor.com ([198.137.202.10]:38092 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYHMPlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:41:49 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7DFfkpq012100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2008 08:41:46 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7DFfk8b023365;
	Wed, 13 Aug 2008 08:41:46 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7DFfha6011703;
	Wed, 13 Aug 2008 08:41:45 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080813145341.GA3782@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8026/Wed Aug 13 06:03:11 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92231>

Shawn O. Pearce wrote:
> 
> Hmm.  So what if the "smart" protocol used a redirect to the CGI
> and the dumb protocol didn't use any redirects at all?  I say this
> because I think the dumb protocol won't handle redirects well.
> It will do them, but it would incur a redirect on every request
> it makes.
> 

That's preferrable anyway, in my opinion.

> Setting this up on a server which doesn't have the power of mod_regex
> available would be tricky, as you need to link the CGI into every
> single repository you are serving.  I don't know (or use) many other
> HTTP servers beyond Apache so I'm not sure if they can do this.

Many can, and even more can if we instead of git-http-backend had 
something which looked vaguely like a unique extension, like 
"backend.git-http"

	-hpa
