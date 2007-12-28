From: Thien-Thi Nguyen <ttn@gnuvola.org>
Subject: Re: reflog weirdness
Date: Fri, 28 Dec 2007 22:35:33 +0100
Message-ID: <87prwqec4a.fsf@ambire.localdomain>
References: <87ve6iegny.fsf@ambire.localdomain>
	<7vhci2ectr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8Mth-00062D-OL
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 22:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbXL1VhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbXL1VhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 16:37:16 -0500
Received: from ppp-88-39.21-151.libero.it ([151.21.39.88]:52945 "EHLO
	ambire.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752022AbXL1VhP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 16:37:15 -0500
Received: from ttn by ambire.localdomain with local (Exim 4.63)
	(envelope-from <ttn@gnuvola.org>)
	id 1J8Mrd-0004qi-I7; Fri, 28 Dec 2007 22:35:33 +0100
In-Reply-To: <7vhci2ectr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 28 Dec 2007 13:20:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69297>

--=-=-=

() Junio C Hamano <gitster@pobox.com>
() Fri, 28 Dec 2007 13:20:16 -0800

   $ vi .git/logs/HEAD

   and truncate that line after "commit: " to remove the
   part that would normally show the one-line commit log
   message.

thanks for the tip.  i'll do that as soon as i've had a
chance to ponder the repercussions.  in the meantime...

   How does commit 20d9d23 look like (the tracked contents
   are not interesting --- the commit log message is)?

here is the (again, not inlined due to strange bytes) top of
"git show 20d9d23" output:


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=foo
Content-Transfer-Encoding: base64
Content-Description: top of \"git show\" output

Y29tbWl0IDIwZDlkMjMzYzRkNmNmNzUyNTk3MDJlMWI2MDE4N2RhODIwNmI4NWEKQXV0aG9yOiBU
aGllbi1UaGkgTmd1eWVuIDx0dG5AZ251dm9sYS5vcmc+CkRhdGU6ICAgV2VkIERlYyAyNiAwMDox
NTowNSAyMDA3ICswMTAwCgogICAgH4sICgpkaWZmIC0tZ2l0IGEvc291cmNlL2VsaXAuZWwgYi9z
b3VyY2UvZWxpcC5lbAppbmRleCA4ODU4MTUyLi41ODA5MWZiIDEwMDY0NAotLS0gYS9zb3VyY2Uv
ZWxpcC5lbAorKysgYi9zb3VyY2UvZWxpcC5lbAo=
--=-=-=


i see that the body of the log message (three bytes)
corresponds to the first three bytes of the associated
line in .git/logs/HEAD.

thi

--=-=-=--
