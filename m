From: Vitali Lovich <vlovich@gmail.com>
Subject: --progress option for git submodule update?
Date: Wed, 09 Sep 2015 15:52:53 -0700
Message-ID: <88E7FC00-9A87-4E20-89D8-4BF5997F7B07@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3083\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 01:08:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZoTh-0001ii-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 01:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbbIIXIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 19:08:14 -0400
Received: from mail-out6.apple.com ([17.151.62.28]:62615 "EHLO
	mail-in6.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753486AbbIIXII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 19:08:08 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2015 19:08:08 EDT
Received: from relay6.apple.com (relay6.apple.com [17.128.113.90])
	by mail-in6.apple.com (Apple Secure Mail Relay) with SMTP id BB.FB.24160.548B0F55; Wed,  9 Sep 2015 15:52:53 -0700 (PDT)
X-AuditID: 11973e15-f79cb6d000005e60-b5-55f0b845be4c
Received: from marigold.apple.com (marigold.apple.com [17.128.115.132])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by relay6.apple.com (Apple SCV relay) with SMTP id 16.9F.11987.548B0F55; Wed,  9 Sep 2015 15:52:53 -0700 (PDT)
Received: from vldesktop.apple.com ([17.214.197.172])
 by marigold.apple.com (Oracle Communications Messaging Server 7.0.5.30.0 64bit
 (built Oct 22 2013)) with ESMTPSA id <0NUF00KGGM84LW30@marigold.apple.com> for
 git@vger.kernel.org; Wed, 09 Sep 2015 15:52:53 -0700 (PDT)
X-Mailer: Apple Mail (2.3083)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsUi2FAYpeu640OoQV+LpUXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDLmvGlhLtjEVnF+6Sm2BsaprF2MnBwSAiYSp9Y0MkLYYhIX7q1n
	62Lk4hAS2MsosX7hI0aYoimr7jBCJCYxScy6fZcNJCEkMIVJouODA4gtLCAhsfLGYXYQm01A
	XeJL60wgm4ODGcieMiUXJMwsoC3x5N0FVohyE4nrRyeAzecVsJFY8n8+mM0ioCpxZP1CJhBb
	REBc4u3xmewQNXoSzRsngI2UEJCVmLYtHuQcCYGrrBJTpx9jmcAoOAth2ywk22Yh6V7AyLyK
	USg3MTNHNzPPTC+xoCAnVS85P3cTIyggp9uJ7mA8s8rqEKMAB6MSD29D2ftQIdbEsuLK3EOM
	0hwsSuK8n8o/hAoJpCeWpGanphakFsUXleakFh9iZOLglGpgZNhmu+4A34ottTcrNXiShG45
	WFV83hr2cl36y2c2tud53zIq7hUz+bPUT/H8yah7ZTr/vtpclmVYzJR0/sajqXzy/9x1m2um
	CAQefZq5has+1m7l1yirk6E+j78VRbLY+rKc3Cd3b8k3vfr0PX8shPsCPbnThFZcsHf+69uQ
	wbXRcmNRS2moEktxRqKhFnNRcSIAnGTTwykCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkluLIzCtJLcpLzFFi42IRbChu0XXd8SHU4N97M4uuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGXMedPCXLCJreL80lNsDYxTWbsYOTkkBEwkpqy6wwhhi0lcuLee
	rYuRi0NIYBKTxKzbd9lAEkICU5gkOj44gNjCAhISK28cZgex2QTUJb60zgSyOTiYgewpU3JB
	wswC2hJP3l1ghSg3kbh+dALYfF4BG4kl/+eD2SwCqhJH1i9kArFFBMQl3h6fyQ5RoyfRvHEC
	2EgJAVmJadviJzDyzUJYMAvJgllIGhYwMq9iFChKzUmsNNNLLCjISdVLzs/dxAgOoMKoHYwN
	y60OMQpwMCrx8DaUvQ8VYk0sK67MPcQowcGsJMKbtv1DqBBvSmJlVWpRfnxRaU5q8SFGaQ4W
	JXHeBpFXoUIC6YklqdmpqQWpRTBZJg5OqQZG1Rrpn6HTJj0x53f//IVhyzTRR/fj/+78PVVA
	g+HV2aLfKu8qw7/u1whutlEKeL/kSuWs5dOdTDSPrYw9dajmxPs76fXRTMu9Zrw6Hpl0bG/v
	ukOLHGcV3WKJsOFa6li07s76yKfLk05E7TkQWvXqYdeGJ0cqumaYH2Ff7/vIepbY/679Zl4b
	7ZRYijMSDbWYi4oTAab1H0UcAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277568>

Hi,

Git submodule doesn=E2=80=99t have a --progress option like regular clo=
ne/fetch does.  This means that it can hang a long time without output =
as it=E2=80=99s transferring data, particularly for large repositories.
This is problematic in automation scenarios where there can be upper-bo=
unds on how long a process may run without any output (to protect again=
st processes hanging for long periods of time without forward progress)=
=2E

I=E2=80=99m sure this has been asked for before but having this option =
would be really nice for automation system (like buildbot) to take adva=
ntage of.  The only alternative is a hacky solution to clone locally fi=
rst with the =E2=80=94progress option
& then somehow set up the submodule to use the local clone as a referen=
ce.

Thanks,
Vitali