From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git push --recurse-submodules=on-demand with submodule push tag
Date: Tue, 08 Jan 2013 18:33:40 +0100
Message-ID: <50EC5874.6080208@web.de>
References: <CAHtLG6TDqqG09WBkuWzGeWUGog6GOrWQZZtbF5xx_m4ishvzyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:34:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsd3q-00044f-04
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755Ab3AHRdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 12:33:42 -0500
Received: from mout.web.de ([212.227.17.12]:55490 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346Ab3AHRdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:33:42 -0500
Received: from [192.168.178.41] ([91.3.170.228]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MFc9x-1TnQVl2x1R-00EfDl; Tue, 08 Jan 2013 18:33:41
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAHtLG6TDqqG09WBkuWzGeWUGog6GOrWQZZtbF5xx_m4ishvzyQ@mail.gmail.com>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:o+U8o7lC+HCN9u3dt+O2f3+BQU7aijU+bq9sjRDdYrO
 xNwKNqrOP6PczNWFc6r8cEuveVUs3e8mWuupWYD+5ehy1ZT33g
 /Nr5Yr/g8A8s061WJ8qxEwMSJGHvlDJEpxu0LH9yujM43e4LRn
 RSIQtkiwpJJ7ARrbBo06txboP5exwNWvEE3oi388UtYLj6Jf48
 HNVdE2+Ltygym0/2jS1zA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212982>

Am 08.01.2013 17:35, schrieb =E4=B9=99=E9=85=B8=E9=8B=B0:
> In superproject, can I call git push --recurse-submodules=3Don-demand
> that pushes submodule with the submodule's tags?

As that seems to call a plain "git push" in the submodule I think
the tags won't be pushed by this command.

> Very often I change version and tag the submodule
> and change version and tag the superproject at the same time.

Won't "git submodule foreach 'git push --tags'" do what you want?
