From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.6.1
Date: Wed, 20 Jan 2010 16:51:41 -0800
Message-ID: <7vpr54xote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 01:52:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlHR-0006AY-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 01:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab0AUAvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 19:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472Ab0AUAvx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 19:51:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0AUAvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 19:51:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDBA92D2E;
	Wed, 20 Jan 2010 19:51:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=YMvF
	fbS8JyqguC3zdAALa2HuMIk=; b=X3zd7x9k2hzUCTIP7Cdta9pE9eRilvMOBS2E
	6d50Ynb6UATQSUUHohRfGMsm11gKacMLHykdLFTbUb7QOhdJKXB+GOdkYQ0ApzmV
	T9/hh5Vga71EfP8ZThdT098t/czZWVKg4Y0ix9lH5iuSaeb2i0btctKbpUX/ZUun
	8xK5hHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=BL/
	0R1gVpUenc8/P1XQsUnuCFOIxvS7pihnPmnHnNy45Taze0V5SXaNySns70sBWINE
	wfg0E72n2WFOZcXCog/vWy64eU9FnO/WfZOE+HCn+YDqmSAYeDzHHaAZ9IqPxwSF
	DJOV2Mhvzisry03dUNisZM8OmPMpL/f/OsR2fk/M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66D2892D2A;
	Wed, 20 Jan 2010 19:51:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75E6792D29; Wed, 20 Jan
 2010 19:51:42 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 271A1C8A-0627-11DF-B146-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137605>

The latest maintenance release Git 1.6.6.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.6.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.6.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.6.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.6.1-1.fc11.$arch.rpm	(RPM)

Git v1.6.6.1 Release Notes
==========================

Fixes since v1.6.6
------------------

 * "git blame" did not work well when commit lacked the author name.

 * "git branch -a name" wasn't diagnosed as an error.

 * "git count-objects" did not handle packfiles that are bigger than 4G on
   platforms with 32-bit off_t.

 * "git checkout -m other" while on a branch that does not have any commit
   segfaulted, instead of failing.

 * "git fast-import" choked when fed a tag that do not point at a
   commit.

 * "git grep" finding from work tree files could have fed garbage to
   the underlying regexec(3).

 * "git grep -L" didn't show empty files (they should never match, and
   they should always appear in -L output as unmatching).

 * "git rebase -i" did not abort cleanly if it failed to launch the editor.

 * "git reset --hard" did not work correctly when GIT_WORK_TREE environment
   variable is used to point at the root of the true work tree.

 * http-backend was not listed in the command list in the documentation.

 * Building on FreeBSD (both 7 and 8) needs OLD_ICONV set in the Makefile

 * "git checkout -m some-branch" while on an unborn branch crashed.

Other minor documentation updates are included.
