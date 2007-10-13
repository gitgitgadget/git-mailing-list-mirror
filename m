From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Port builtin-add.c to use the new option parser.
Date: Sat, 13 Oct 2007 21:22:13 +0200
Message-ID: <20071013192213.GB2875@steel.home>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <1192282153-26684-3-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0710131544030.25221@racer.site> <20071013150306.GH7110@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?=
X-From: git-owner@vger.kernel.org Sat Oct 13 21:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgmZE-00029a-W6
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 21:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbXJMTWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 15:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757459AbXJMTWV
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 15:22:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32568 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbXJMTWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 15:22:20 -0400
Received: from tigra.home (Fc8ce.f.strato-dslnet.de [195.4.200.206])
	by post.webmailer.de (fruni mo9) (RZmta 13.4)
	with ESMTP id m02e4fj9DHjbrX ; Sat, 13 Oct 2007 21:22:13 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A106D277AE;
	Sat, 13 Oct 2007 21:22:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 81F1256D22; Sat, 13 Oct 2007 21:22:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071013150306.GH7110@artemis.corp>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0sy8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60754>

Pierre Habouzit, Sat, Oct 13, 2007 17:03:06 +0200:
> On Sat, Oct 13, 2007 at 02:47:20PM +0000, Johannes Schindelin wrote:
> > Thinking about this more, I am reverting my stance on the ARRAY_SIZE() 
> > issue.  I think if you introduce a "OPTION_NONE = 0" in the enum, then 
> > this single last comma should be enough.
> 
>   adding a trailing comma does not add a NULL after that, it's ignored,
> you're confused.

Yep

>   Note that I don't really like using ARRAY_SIZE either, I kept it that
> way, but my taste would rather be to have an "empty" option, and
> explicitely mark the end of the array.

You can have both. Just stop at NULL-entry or when the 'size' elements
passed, whatever happens first.
