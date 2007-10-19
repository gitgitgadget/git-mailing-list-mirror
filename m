From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 14:31:39 +0200
Message-ID: <4718A3AB.7090301@viscovery.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com> <20071019113822.GB16726@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@thunk.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 14:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IirRO-000110-Lu
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762995AbXJSM63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 08:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762146AbXJSM63
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 08:58:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20056 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762824AbXJSM62 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 08:58:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IirQZ-0005ed-59; Fri, 19 Oct 2007 14:58:11 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0A223546; Fri, 19 Oct 2007 14:31:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071019113822.GB16726@thunk.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61699>

Theodore Tso schrieb:
> ==> git://repo.or.cz/git/spearce.git
>  * branch gitk -> spearce/gitk		(new)
>  * branch maint -> spearce/maint	1aa3d01..e7187e4
>  * branch master -> spearce/master	de61e42..7840ce6
>  * branch next -> spearce/next		895be02..2fe5433
>  + branch pu -> spearce/pu		89fa332...1e4c517
>  * branch todo -> spearce/todo		(new)

> As far as the padding, it would be a pain to figure out how to make
> the right hand column be padded so that it starts 3 spaces after the
> longest "  * branch foo -> bar" line, but that would look the best.

But this way it wouldn't be difficult at all:

==> git://repo.or.cz/git/spearce.git
  * (new)              gitk -> spearce/gitk
  * 1aa3d01..e7187e4   maint -> spearce/maint
  * de61e42..7840ce6   master -> spearce/master
  * 895be02..2fe5433   next -> spearce/next
  + 89fa332...1e4c517  pu -> spearce/pu
  * (new)              todo -> spearce/todo

(I don't know where to put the label 'branch'.)

BTW, I like the ID ranges, too, and have used the information
occasionally.

-- Hannes
