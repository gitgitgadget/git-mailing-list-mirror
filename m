From: tboegi@web.de
Subject: [PATCH/RFC v1 0/1] Quickfix ?No duplicate CRLF rewrite warnings on commit
Date: Sun, 15 May 2016 08:08:20 +0200
Message-ID: <1463292500-12521-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: adam@dinwoodie.org,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:03:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1p91-00046i-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbcEOGDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:03:07 -0400
Received: from mout.web.de ([212.227.15.3]:51137 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbcEOGDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:03:05 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LpOOj-1bY7YE1pqv-00f9y0; Sun, 15 May 2016 08:02:59
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:JCRKEb14pGEyImjOYVc7A81NT+9prXeOZp5iWnOnJbO0NZuooo5
 5AA+Mw48LqIVPxZ9FKKzMOK4VPxLDbscrahea06jp7Y7d8mE8KE+pC3DALYQ81yLKcZIj3f
 hvy/q1JIfhqfLYCzL6bnzuxqzbsnusI/fgKzK0smCx3T14Q4GTdPXZ2sjH8ezytIzlwpys2
 uGIFd51eulL3Tj80Hbo3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dU+hIUuRS4I=:G9I/Xz2km6SFAgr5g515Vv
 c44EOIdjZcUVXfwirvYTEX10JsoxhBRfhXc0Z87rye28AS++tnNehS7FAPrfN/ANydPANn8tp
 cO/7Qu+XOD31SFGKh9+LTJ4VC7W+g7g/1rh3S6bNT6Jadxhx5l4MhBI2FO9H17LPzN56K+VvA
 AF0yc+h7NtHmC2nnKfkQXB5wikgEnfO8dzKGhZmw1ascAGnuMDufvelLlL3CXw9egVLTAuwKl
 IHk8oG8hErPWHjSfjj8x0JCHqGXLKyUicM6tUpNk8E6DlYAkdLQT6ppVQapIzbRh7Rh903raU
 3qCDc2AFvdi/itp13Hu3leFNJdVY9Ede5mTs5l0LO4RjGjsGx7Uhhb+wj1a1Et/CUy3/QV/Iw
 b7K1fi9I2Ol8rgCJl9Gv2UJIhTBZ84Mg7JIegD6VQsCzqGWraq9UBdZIk1Cq/pfXlcF752qnP
 81mh009nyAlhv2IRAuW8gciJ6Gdxy3yFsigpVEhp85jvJ9HexNMcchDoduRofVaUTsRZv81a6
 4deHS2nzvh8i1ERJbjUt/7TZVqrLvpxtkPziuB5cJZ27EwzijsPHIlEtMQcsPmbtrpyvGi4Iw
 oSjDqO1siAE5RS40GjWw2A/YrSzVbS1oBDnMVttTuC1DvHha3CXa1nsMeyucwcdzQSlYMJXXk
 eIjjINbg9QVpObVg6rUPsqloyi1iGPegEtinSBAoUsXQ6CUj+HGRi9RLUZm+fyxHabEGyUJCk
 xTPVTrp+R07XlyTbWw3MQETkGGGO6hfwouRRpLimWLePB5MNUHqA95nxOdmtQ4t3pQmGSG4Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294635>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

It may be that this patch only covers over a sympton, rather
than fixing the root cause.

Torsten B=C3=B6gershausen (1):
  No duplicate CRLF rewrite warnings on commit

 diff.c           |  2 ++
 diffcore-break.c |  6 ++++--
 diffcore.h       |  1 +
 t/t0020-crlf.sh  | 14 ++++++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
