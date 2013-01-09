From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking (interim report)
Date: Tue, 08 Jan 2013 16:53:19 -0800
Message-ID: <7vtxqr9ny8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 01:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsjvL-0005bO-1I
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 01:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748Ab3AIAxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 19:53:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754Ab3AIAxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 19:53:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFFF7B0FE;
	Tue,  8 Jan 2013 19:53:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	lJ2hwlIGLDh31sn5jSu7PT7h9Y=; b=r3Evq+YO7riavJ+BNEdf+CL71Xdk6oe48
	OL20f/rsBI9jwcH+9uGLLRFmb+6v5dxS6KFYj5oMZucL5NT9zhvaN515koE8Xk3Q
	OTwzb7lRPCc9MnX9hlEl+9pzWdUQXxfx1/8FaM+kAMo3sNo84padyQB00jORQOFP
	MGTS88G08Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Uig
	nN+uKT8MVQem6Ix5c8WHdH6OzaZBDaRmaJvGJ3mGA61ACjhVnmDfEZfEfqU73xPS
	mgNk9oNUtzj4I5ncLShprLqcHhqmskZiYXjlfQnIfxM2kpmM/6n1QdSmpiKbxBRI
	7oX+SNmQaG185PMFnT2mP4/FAjnUfOMaWonB3MLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C46A4B0FD;
	Tue,  8 Jan 2013 19:53:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BBA8B0F8; Tue,  8 Jan 2013
 19:53:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6C0F7BC-59F6-11E2-B6E1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213019>

I'll do the next issue of "What's cooking" after tomorrow's
integration cycle, but here are the highlights.

The following topics that have already graduated to the 'master'
branch have been merged to the 'maint' branch (see the last "What's
cooking" for details of individual topics):

    ms/subtree-fixlets
    ss/nedmalloc-compilation
    jc/maint-fnmatch-old-style-definition
    jc/test-portability
    jc/maint-fbsd-sh-ifs-workaround
    jc/mkstemp-more-careful-error-reporting
    jc/test-cvs-no-init-in-existing-dir
    jc/maint-test-portability

In addition, the following two patches have been directly applied to
the 'maint' branch:

    t1402: work around shell quoting issue on NetBSD
    remote-hg: Fix biridectionality -> bidirectionality typos

We will have other bugfix topics merged to 'maint' and hopefully can
tag v1.8.1.1 sometime next week.

The following topics that have been cooking on 'next' have been
merged to the 'master' branch:

    kb/maint-bundle-doc
    as/test-name-alias-uniquely
    ta/remove-stale-translated-tut
    tb/test-t9810-no-sed-i
    tb/test-t9020-no-which
    jk/maint-fast-import-doc-dedup-done
    jk/pathspec-literal

Most of these will later be merged to 'maint'.

These topics have been merged to the 'next' branch:

    rs/zip-with-uncompressed-size-in-the-header
    rs/zip-tests
    jn/xml-depends-on-asciidoc-conf
    jc/comment-cygwin-win32api-in-makefile
    as/api-allocation-doc
    jk/unify-exit-code-by-receiving-signal
    rs/leave-base-name-in-name-field-of-tar
    jl/interrupt-clone-remove-separate-git-dir
    jc/merge-blobs
    mo/cvs-server-updates
    as/dir-c-cleanup
    jk/config-uname

Also several new topics are parked in 'pu' and I think they are all
ready for 'next'.

Thanks.
