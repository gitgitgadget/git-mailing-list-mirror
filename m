From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Git doesn't detect change, if file modification time is
 restored to original one
Date: Thu, 23 Jul 2015 17:53:42 +0300
Message-ID: <20150723175342.77f635820fb9f1b69a73d39a@domain007.com>
References: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
	<55B09E95.4000700@gmail.com>
	<CABEDGg_R49K61wiV9SsTnLS9SztHDjEQhOHjwzYn2JJwrrb-KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 16:53:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIHsd-0005rv-8f
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 16:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbbGWOxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2015 10:53:48 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:40186 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbbGWOxq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 10:53:46 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t6NErg9Q006181;
	Thu, 23 Jul 2015 17:53:43 +0300
In-Reply-To: <CABEDGg_R49K61wiV9SsTnLS9SztHDjEQhOHjwzYn2JJwrrb-KA@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274499>

On Thu, 23 Jul 2015 11:14:11 +0200
Konr=C3=A1d L=C5=91rinczi <klorinczi@gmail.com> wrote:

[...]
> I accept these solutions as workarounds, but the real solution would
> be: Dev suggestions:
> 1) Add a --force-reread option to git status, so user can force
> reread tree. git status --force-reread
>=20
> 2) Add status.force-reread (true or false) option to .git/config so
> user can set this variable permanently for a repo.
> status.force-reread =3D false (should be default)
>=20
> Could be possible to implement 1) and 2) features to next git release=
?

Could you explain what's your real use case with preserving mtimes
while changing the files?  I mean, implementing "mtime-stability"
in your tools appears to be a good excersize in programming but what
real-world problem does it solve?

I'm asking because if you are not going to implement the changes to
Git you suggested yourself, then someone else should be *convinced* to
do so.  So far, your trouble appears to be too artifical to bother.
