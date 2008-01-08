From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3.8
Date: Tue, 08 Jan 2008 00:54:16 -0800
Message-ID: <7vodbwvgsn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 09:55:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCAEe-000489-7k
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 09:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbYAHIyc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 03:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbYAHIyc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 03:54:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbYAHIya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 03:54:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 671B82095;
	Tue,  8 Jan 2008 03:54:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 15FAA2094;
	Tue,  8 Jan 2008 03:54:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69849>

The latest maintenance release GIT 1.5.3.8 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.8.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.8.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.8.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.3.8-1.$arch.rpm	(RPM)

Hopefully this will be the last maintenance of 1.5.3 series, as
we are nearing -rc3 on the 1.5.4 front.

----------------------------------------------------------------

Changes since v1.5.3.7 are as follows:

David Symonds (1):
      Change from using email.com to example.com as example
      domain, as per RFC 2606.

Eric Wong (2):
      git-svn: support for funky branch and project names over HTTP(S)
      git-svn: clarify the "Ignoring error from SVN" piece

Jeff King (3):
      t9600: test cvsimport from CVS working tree
      clone: correctly report http_fetch errors
      git-send-email: avoid duplicate message-ids

Jim Meyering (1):
      config.c:store_write_pair(): don't read the byte before a
      malloc'd buffer.

Junio C Hamano (3):
      git grep shows the same hit repeatedly for unmerged paths
      git-am -i: report rewritten title
      GIT 1.5.3.8

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      Add missing inside_work_tree setting in setup_git_directory_gentl=
y
      Do check_repository_format() early
      Do check_repository_format() early (re-fix)
