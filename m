From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix various typos and grammaros
Date: Thu, 11 Apr 2013 17:45:08 -0700
Message-ID: <7v4nfch90r.fsf@alter.siamese.dyndns.org>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 02:45:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQS7N-0005cf-MY
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 02:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab3DLApM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 20:45:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab3DLApL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 20:45:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C29DEE277;
	Fri, 12 Apr 2013 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvtV2Q2ZFCcInAlkglHMihfbUxQ=; b=l+78mB
	1g3HQa6kfMd7TfzWDIJoSlnccqLznifbZCGUOxMjmGfRAIhsPhFBpNP1OUIk9Fzo
	rxxV09ZaKd4sSy+mgKD0LXcgt097hM5oahG+HoNNoLd84y5OyU5uliUulu8bzlDb
	ZVYNp2Q+RW82jXRQvP/I3RikNBkfuqggI4LKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JQ18qQK9G9DZHAKNvkZMRbCgZxpsevmU
	uLzvWxxuIBdwnJ37EOLnqgnoM7FWci96QtrHrSIphD7M5NDBph/NgmpZ4r8vbCbC
	ZDp3YssbekEL920bS7Uaquaw0t9AGr8Xbjicr7l/89MOLlESGN1ulESwjvx+V9zQ
	pONk8Nl+6C4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B70BDE273;
	Fri, 12 Apr 2013 00:45:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0197EE271; Fri, 12 Apr 2013
 00:45:09 +0000 (UTC)
In-Reply-To: <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 12 Apr 2013 00:36:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A731CAE-A30A-11E2-BD4B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220942>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

>  Documentation/git-credential.txt                   |  2 +-
>  Documentation/git-remote-ext.txt                   |  2 +-
>  Documentation/git-svn.txt                          |  4 ++--
>  Documentation/git-tools.txt                        |  2 +-
>  Documentation/revisions.txt                        |  2 +-
>  Documentation/technical/api-argv-array.txt         |  2 +-
>  Documentation/technical/api-credentials.txt        |  2 +-
>  Documentation/technical/api-ref-iteration.txt      |  2 +-
>  builtin/apply.c                                    |  6 +++---
>  commit.c                                           |  2 +-
>  commit.h                                           |  2 +-
>  compat/nedmalloc/Readme.txt                        |  2 +-
>  compat/nedmalloc/malloc.c.h                        |  6 +++---
>  compat/obstack.h                                   |  2 +-
>  compat/precompose_utf8.c                           |  2 +-
>  compat/regex/regcomp.c                             |  4 ++--
>  compat/regex/regex.c                               |  2 +-
>  compat/regex/regex_internal.c                      |  6 +++---
>  contrib/mw-to-git/git-remote-mediawiki.perl        |  6 +++---
>  contrib/mw-to-git/t/README                         |  6 +++---
>  contrib/mw-to-git/t/install-wiki/LocalSettings.php |  2 +-
>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       |  2 +-
>  contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 14 +++++++-------
>  contrib/subtree/t/t7900-subtree.sh                 |  2 +-
>  diff.c                                             |  2 +-
>  git-add--interactive.perl                          |  2 +-
>  git-cvsserver.perl                                 |  4 ++--
>  git-gui/lib/blame.tcl                              |  2 +-
>  git-gui/lib/index.tcl                              |  2 +-
>  git-gui/lib/spellcheck.tcl                         |  4 ++--
>  git-quiltimport.sh                                 |  2 +-
>  gitweb/INSTALL                                     |  2 +-
>  gitweb/gitweb.perl                                 |  6 +++---
>  kwset.c                                            |  4 ++--
>  perl/Git.pm                                        |  2 +-
>  perl/Git/I18N.pm                                   |  2 +-
>  perl/private-Error.pm                              |  2 +-
>  po/README                                          |  6 +++---
>  sequencer.c                                        |  2 +-
>  t/t1006-cat-file.sh                                |  2 +-
>  t/t3511-cherry-pick-x.sh                           |  4 ++--
>  t/t3701-add-interactive.sh                         |  2 +-
>  t/t4014-format-patch.sh                            |  6 +++---
>  t/t4124-apply-ws-rule.sh                           |  2 +-
>  t/t6030-bisect-porcelain.sh                        |  2 +-
>  t/t7601-merge-pull-config.sh                       |  2 +-
>  t/t7610-mergetool.sh                               |  2 +-
>  t/t9001-send-email.sh                              |  4 ++--
>  transport-helper.c                                 |  2 +-
>  transport.h                                        |  2 +-
>  xdiff/xdiffi.c                                     |  2 +-
>  xdiff/xhistogram.c                                 |  2 +-


How much of this stuff have interact with real changes that are in
flight, with various doneness cooking in different integration
branches?
