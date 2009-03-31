From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] graph API: Added logic for colored edges.
Date: Tue, 31 Mar 2009 12:26:58 +0200
Message-ID: <49D1EFF2.303@viscovery.net>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com> <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com> <20090320195806.GC26934@coredump.intra.peff.net> <20090321175726.GA6677@linux.vnet> <20090330141322.GA6221@linux.vnet> <alpine.DEB.1.00.0903311210000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Allan Caffee <allan.caffee@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 12:28:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LobD0-0004kU-Ka
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 12:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZCaK1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 06:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbZCaK1L
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 06:27:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63186 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZCaK1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 06:27:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LobBQ-0008T5-1J; Tue, 31 Mar 2009 12:27:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5B41F6C4; Tue, 31 Mar 2009 12:26:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0903311210000.10279@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115247>

Johannes Schindelin schrieb:
> How about this function instead?
> 
> static void strbuf_add_column(struct strbuf *sb,
> 	const struct column *column, const char *fmt, ...)
> {
>         va_list ap;
> 
>         va_start(ap, fmt);
> 	if (column->color)
> 		strbuf_addstr(sb, column->color);
>         strbuf_vaddf(sb, fmt, ap);
> 	if (column->color)
> 		strbuf_addstr(sb, GIT_COLOR_RESET);
>         va_end(ap);
> }
> 
> Hmm?

Except the strbuf_vaddf() is only in your private repository ;)

-- Hannes
