From: Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: git show -m with a parent number
Date: Sun, 27 Mar 2016 20:46:02 +0000 (UTC)
Message-ID: <nd9gq6$412$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 22:46:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akHa5-0007KJ-1L
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 22:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbcC0UqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 16:46:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:58544 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbcC0UqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 16:46:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1akHZZ-00079J-Sr
	for git@vger.kernel.org; Sun, 27 Mar 2016 22:46:10 +0200
Received: from fokus169218.fokus.fraunhofer.de ([194.95.169.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 22:46:09 +0200
Received: from anatoly.borodin by fokus169218.fokus.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 22:46:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fokus169218.fokus.fraunhofer.de
Cancel-Lock: sha1:lYH+jz5W6ZsWdlYeClUoiT3GQjs=
User-Agent: tin/2.3.1-20141224 ("Tallant") (UNIX) (Linux/4.2.0-34-generic (x86_64))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290022>

Hi All,


is there a good reason for `git show -m` to not accept the number of a
parent of a merge commit? I can run `git show --first-parent COMMIT`,
but need to write `git diff COMMIT^2 COMMIT` every time I want to diff
with the second parent!

`git cherry-pick -m 2 COMMIT` works, so why can't `git log` work like
that?


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
