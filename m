From: Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH] compat/regex: get rid of old-style definition
Date: Wed, 25 Aug 2010 18:24:55 +0000 (UTC)
Message-ID: <loom.20100825T200539-742@post.gmane.org>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain> <1282242601-2630-1-git-send-email-avarab@gmail.com> <7vtymq74mp.fsf@alter.siamese.dyndns.org> <AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com> <7vlj8271mm.fsf@alter.siamese.dyndns.org> <7v39uadxx3.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 20:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKjl-0004s9-6h
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0HYSaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:30:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:33229 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab0HYSaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:30:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OoKjc-0004lH-7m
	for git@vger.kernel.org; Wed, 25 Aug 2010 20:30:04 +0200
Received: from ns.dcon.de ([77.244.111.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 20:30:04 +0200
Received: from blees by ns.dcon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 20:30:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.244.111.149 (Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154457>

Hi,

this doesn't compile if internal_function is #defined non-empty (e.g. on
mingw/msysgit). The old-style definitions work.

Ciao,
Karsten

In file included from compat/regex/regex.c:78:
compat/regex/regexec.c:357: error: conflicting types for 're_search_2_stub'
compat/regex/regexec.c:44: note: previous declaration of 're_search_2_stub' was
here
compat/regex/regexec.c:401: error: conflicting types for 're_search_stub'
compat/regex/regexec.c:49: note: previous declaration of 're_search_stub' was
here
compat/regex/regexec.c:488: error: conflicting types for 're_copy_regs'
compat/regex/regexec.c:53: note: previous declaration of 're_copy_regs' was
here
compat/regex/regexec.c:618: error: conflicting types for 're_search_internal'
compat/regex/regexec.c:39: note: previous declaration of 're_search_internal'
was here
compat/regex/regexec.c:942: error: conflicting types for
'prune_impossible_nodes'
compat/regex/regexec.c:55: note: previous declaration of
'prune_impossible_nodes' was here
make: *** [compat/regex/regex.o] Error 1
