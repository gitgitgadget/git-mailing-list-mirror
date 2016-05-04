From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Wed, 4 May 2016 16:56:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041654300.9313@virtualbox>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com> <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com> <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
 <CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com> <alpine.DEB.2.20.1605041304050.9313@virtualbox> <CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com> <alpine.DEB.2.20.1605041416030.9313@virtualbox>
 <CAP8UFD0QeZqLaPwFe5wo0n1fdtSppJmYdUDc+Yo1duH1uyWbpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 16:56:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axyEQ-0004LX-CO
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 16:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbcEDO4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 10:56:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:60682 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbcEDO4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 10:56:35 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M1jKo-1bmDUg1Vt4-00tmRO; Wed, 04 May 2016 16:56:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD0QeZqLaPwFe5wo0n1fdtSppJmYdUDc+Yo1duH1uyWbpw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:AoH0vJbQcVNAafZhJQewMm2vObzO1H+iubbNv+3HH5vcMckX90R
 OMO45hIN8PFJ52v3ZK6ilnpQGDWJdFCeOeYx3MSljMYmmBJWEwfRRd/BKDfZjEjSHNWPwN5
 4GG3lGh7GubaHblUlaUuYLAtEQudKJVdME1YcFEGEF4zQFx2jpTV4qsRTrcTFaxjoMt0zaj
 5yxlvum8bBL/Syfcq+63w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kGmqRRlK1RY=:T7lzJXiNYlWqw1eXWO2+O7
 LCLehbwHxzjwixzGMvfo4szbv20w3TEtenvrztHkiUAUds2x3DAgPQP5c4UtzX5FoHcx0alrC
 sbukg3wXRJy4QqT/yb7x9R4Zs4oUJ3l9KbmZ3Pnx2rYo/7f5WhuXizex0oT7eeyULY6uvwONk
 g09TMN9hAzEtB42mZO7UIiNN/UMXLzQEjUjj2QhMwoCI3BdNECa++nbMF8zNtWU54XpabIR/N
 zjwmmNLp7mBT6DGGUfitRtFeE8gcTgih9+sfALBVnGd0jytJzAeDc+DU5+iCwzcUwc2o/MfTq
 VHwiYLZ7HfoJATZRgdmuwIbsMgXCj/iXsnMA5ogOW6y27pDOrCVhGZW5gOhpvQjWrpBJQmBkc
 yV9tVG19nHFfozyBiUwWONoDG/Qb7104EhvUOXUWKSTIP7750DUSTICXIiKXxCTOEJlkBiGCg
 1zqr7jEYIlHgx+FOKF1xF1RebvXmONpjuWj611iy5iBjKnw+xXEskAW+suhv9QWpXAYGkSdt3
 0mbNaSsJb90EuXWbH7pfFXsCdtU9pgrt5lPvpxHuIzOIoy06idF36KlgfU44j5Zjh8wRd2Q3X
 UlYWIErgJ2npk/u2TGueVUoq5AWaIhHf7kUbKdd2S+AtFoAdXPYOCdxBTSLA5/55GPM/nuSTu
 KzpRIqqcWLnR2xHPNxGhff3xDKXA45TS8uWD3adslZKTtFY7vgAbdVa7ve0dWxrgwgTqVhooo
 AjiWRlXq8HK09HkiyWiZki+Ih+eMwta7/TBODow1G7atsCoSULJU52XhtX0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293550>

Hi Christian,

On Wed, 4 May 2016, Christian Couder wrote:

> My intent was to try to show that there is some important value to make
> the subject close to the "low level" thing the patch actually does.

I disagree. The place to describe low-level details that are not
immediately obvious from the patch is the commit message. Way, way down on
the bottom.

The commit message should start with a subject that gives me a good clue
why this is a good change. A low-level detail won't do that very often.

Ciao,
Johannes
