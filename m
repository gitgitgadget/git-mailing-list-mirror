From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 17:01:32 +0200
Message-ID: <537233CC.3050904@web.de>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr> <53711AA5.4040001@web.de> <53712309a8d5e_2ea6e1f2f888@nysa.notmuch> <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershau?= =?ISO-8859-1?Q?sen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 17:01:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkED9-0008Ip-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 17:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbaEMPBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 11:01:39 -0400
Received: from mout.web.de ([212.227.15.14]:61208 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760310AbaEMPBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 11:01:37 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M0QgT-1X5cRN0GVB-00uZB3; Tue, 13 May 2014 17:01:32
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
X-Provags-ID: V03:K0:Ft3C5Zwt9L4OyAnQZswceI9Jm5NKeJQrMK9GPvuA+dgZtAMhYAp
 sTYyF/3Q6Nx3COkfUlTuVlgK4agofeue7ijMqZz5xg6rS/k9reWP5NKmh4h6GjjIPhj0QtR
 M2oLZN2zTbqqF2wlWgi3mdk3DcCQA9qLYkm/RUE3n6pWqnHjFKIIWWyt/kawwbGQ7GA1Ryj
 Tl0gTV2Xz7RhMYTJeslaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248790>

(Please use reply-all and don't snip the important stuff)
On 2014-05-13 09.54, Charles Brossollet wrote:
> Le 12 mai 2014 =E0 21:37, Felipe Contreras <felipe.contreras@gmail.co=
m> a =E9crit :
>=20
>> Torsten B=F6gershausen wrote:
>>>> I'm using git 1.9.3 on Mac OS X 10.9.2, with hg 3.0 installed with=
 brew.
>>>>
>>>> It used to work before, on this same repository, since then git an=
d hg were both upgraded.
>>> In short: The remote helper of Git 1.9.3 is not compatible with hg =
3.0
>>> You can eiher downgrade hg, or rebuild Git and cherry-pick this com=
mit:

>>
>> No need to rebuild Git.
>>
>> You can also use the latest version:
>> https://github.com/felipec/git-remote-hg
>=20
> Thanks Felipe and Torsten, just using the HEAD version of git-remote-=
hg solved the problem.
>=20
> Best regards,
> Charles--

I did some testing with Git 2.0-rc3 + 58aee0864adeeb5363f.
The remote-helper tests for hg-git worked OK
with both hg version 2.9 and 3.0 under both Mac OS and Linux.

Should we consider 58aee086 to be included in Git 2.0 ?
