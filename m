From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Suggestion: git submodule remove
Date: Sat, 11 Apr 2015 14:15:41 +0200
Message-ID: <5529106D.7050301@web.de>
References: <CABEDGg8Gos8UTi2U_xgMpx2dJtbtSNCCd2gRr_KR1qESB6gYYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 14:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YguKO-00071v-J2
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 14:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbbDKMPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 08:15:49 -0400
Received: from mout.web.de ([212.227.17.11]:50181 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbbDKMPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 08:15:48 -0400
Received: from [192.168.178.41] ([79.211.112.217]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LiUKG-1ZF9kT1vi8-00cgmA; Sat, 11 Apr 2015 14:15:45
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CABEDGg8Gos8UTi2U_xgMpx2dJtbtSNCCd2gRr_KR1qESB6gYYA@mail.gmail.com>
X-Provags-ID: V03:K0:duZpYaBRThX8d9a5akRmwV6i0et/S9pjXvOoi2B/UuhJoV/j5s9
 zJ+rg4kSrlDybOQ5pbtIMSIaVKfYw1ibNujHPsIrGdhaNBCOWVORZS8ObeSvLs/RNbJA8ah
 QFQyzBsRoRIihdGLMfR9iCdzDy0CvU0lqKbsieK/tZqaOdK3zSswkzFPkImVGk9b5jbGihs
 Ql7ClGyfNS01ENLtmWBuQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267022>

Am 10.04.2015 um 13:33 schrieb Konr=C3=A1d L=C5=91rinczi:
> I really miss the
>    git submodule remove
> command.
>
> This should be handle all the tasks what are needed to remove a submo=
dule.
>      - Delete the relevant line from the .gitmodules file.
>      - Delete the relevant section from .git/config.
>      - Run git rm --cached path_to_submodule (no trailing slash).
>      - Delete the now untracked submodule files.
>
> These tasks should be handled automatically.
> Currently you can only remove a submodule manually, no way to do it
> automatically with one command.
> "Removing submodules" and "unsubmodule a submodule" are still a pain
> to do in GIT, even in v2.3.5.

"git rm <submodule-path>" will remove a submodule from .gitmodules,
the index and the work tree (but not from .git/config, that's what
"git submodule deinit" is for).
