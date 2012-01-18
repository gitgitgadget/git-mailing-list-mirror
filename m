From: Sam Steingold <sds@gnu.org>
Subject: modifying the commits before push
Date: Wed, 18 Jan 2012 12:49:27 -0500
Organization: disorganization
Message-ID: <87wr8o3nq0.fsf@gnu.org>
Reply-To: sds@gnu.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:55:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnZjU-0001qv-9z
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 18:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab2ARRzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 12:55:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:36210 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402Ab2ARRzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 12:55:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RnZiz-0001WX-9Z
	for git@vger.kernel.org; Wed, 18 Jan 2012 18:55:05 +0100
Received: from cl-pat-tr.clearspring.com ([8.18.54.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 18:55:05 +0100
Received: from sds by cl-pat-tr.clearspring.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 18:55:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: cl-pat-tr.clearspring.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Mail-Copies-To: never
X-Attribution: Sam
X-Disclaimer: You should not expect anyone to agree with me.
Cancel-Lock: sha1:HRj8NnyA4VCX4OFxetXKOD/kQ58=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188752>

Hi,
I am trying to push:
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 4 commits.
#
nothing to commit (working directory clean)
$
but `git push` fails with this:

remote: ERROR: Rejecting update because this commit email is not from ZZZ

What I need to do is
- modify the 4 commits with a different e-mail and do `git push` again
- make sure that all my commits in this repo are done with the correct e-mail

how do I do this?

thanks!

-- 
Sam Steingold (http://sds.podval.org/) on Ubuntu 11.10 (oneiric) X 11.0.11004000
http://pmw.org.il http://jihadwatch.org http://thereligionofpeace.com
http://openvotingconsortium.org http://ffii.org http://camera.org
Let us remember that ours is a nation of lawyers and order.
