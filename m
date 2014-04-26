From: =?ISO-8859-1?Q?Z=E9?= <jose.passes@gmx.com>
Subject: Re: gitignore vs. exclude vs assume-unchanged?
Date: Sat, 26 Apr 2014 13:26:12 +0100
Message-ID: <535BA5E4.5050609@gmx.com>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>	<xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>	<dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>	<20140416234555.GA4309@google.com>	<4dd8389939fbf3dc77b58adcca7b17c1@bellandwhistle.net>	<CAH5451k+GGGdHXkwne2O-h2m2AyWg7K+5reNRG64+eF891pVUA@mail.gmail.com> <xmqqtx9l5jxn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Apr 26 14:26:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We1gn-0004jh-Pd
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 14:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaDZM0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Apr 2014 08:26:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:62316 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaDZM0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 08:26:15 -0400
Received: from [192.168.1.70] ([46.189.198.76]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LaG7C-1XKCux0xW2-00m0Ju for <git@vger.kernel.org>;
 Sat, 26 Apr 2014 14:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqtx9l5jxn.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:9u3y9TdOi6rNA17kkyX/mJxawFUrVzfiuvOhY+Z3wTWZrrLopzQ
 eeqD9iTa1Vx8MRwmGK7s0KkKyS8OcsT8EE5BI4V+K66XXqhkHsLmjvjsoAgdTevCZL4XVAf
 vgylZAjws6VL+nJxtitFM6NIXRLSTyTbEu4hI/M+reqo13hZ5dsRiaRTABr5k0+ZJFUZiyR
 +PkgHc2MPQVcZopUAXTLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247155>

On 04/22/2014 06:54 PM, Junio C Hamano wrote:
> Interesting.  It will break immediately when the project starts
> wanting to distribute its "canonical" ignore list

If that happens, that's a problem caused by the project wanting to=20
misuse .gitignore.

There are good practices and bad practices.  Forcing a common .gitignor=
e=20
upon everyone with access to the source code is not a good practice.

--=20
Z=E9
