From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2] Test cccmd in t9001-send-email.sh and fix some bugs
Date: Fri, 19 Jun 2009 12:06:04 +0200
Message-ID: <200906191206.05286.markus.heidelberg@web.de>
References: <200906181211.39440.markus.heidelberg@web.de> <1245328292-25280-1-git-send-email-bonzini@gnu.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jaysoffian@gmail.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHazD-00020W-GL
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 12:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561AbZFSKFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 06:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757008AbZFSKFn
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 06:05:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52310 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbZFSKFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 06:05:43 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 569F51061D2EF;
	Fri, 19 Jun 2009 12:05:45 +0200 (CEST)
Received: from [89.59.104.150] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MHayf-00032I-00; Fri, 19 Jun 2009 12:05:45 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1245328292-25280-1-git-send-email-bonzini@gnu.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/W0v+oACt/b7bYakPkkwlnY2uuCfZKiUriWkOS
	JE9KXeT5QE/HYvxaJzDu0sgfpeUrQ4TbVJF9ENQwsyxlAUT/gp
	tvEnd351Ug3rjtl5mwxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121893>

Paolo Bonzini, 18.06.2009:
> For another patch series I'm working on I needed some tests
> for the cc-cmd feature of git-send-email.

I think this is text for a cover-letter.

> This patch adds 3 tests for the feature and for the possibility
> to specify --suppress-cc multiple times, and fixes two bugs.
> The first bug is that the --suppress-cc option for `cccmd' was
> misspelled as `ccmd' in the code.  The second bug, which is
> actually found only with my other series, is that the argument
> to the cccmd is never quoted, so the cccmd would fail with
> patch file names containing a space.
> 
> A third bug I fix (in the docs) is that the bodycc argument was
> actually spelled ccbody in the documentation and bash completion.

And these three unrelated bug fixes should rather go into three separate
patches.

> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> Cc: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>  Documentation/git-send-email.txt       |    4 +-
>  contrib/completion/git-completion.bash |    2 +-
>  git-send-email.perl                    |    4 +-
>  t/t9001-send-email.sh                  |   80 ++++++++++++++++++++++++++++++--
>  4 files changed, 80 insertions(+), 10 deletions(-)
> 
> 	Thanks Markus for noticing my erroneous change and
> 	the inconsistency in the docs.

This normally goes directly under ---
I didn't notice it before the second look.
