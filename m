From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC Project | Improvise git bisect
Date: Mon, 21 Mar 2016 08:18:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603210814410.4690@virtualbox>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com> <vpqoaaahbvi.fsf@anie.imag.fr> <CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com> <CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
 <CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com> <alpine.DEB.2.20.1603201628590.4690@virtualbox> <CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 08:19:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahu7H-0007fG-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 08:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcCUHTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 03:19:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:50637 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbcCUHTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 03:19:01 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MHXd2-1aecJp0Vhc-003KWz; Mon, 21 Mar 2016 08:18:33
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:f4KB13fKGYL8eQGHgQ6305P/H/mqT+cGzslnIx8gKRCZ/U2T4s3
 0P1n9qe0Z1zxTZHOKFiubuhvuxjVX/Tdn+M47ZIdjW/THm1RmWntLjKo2nonk1Zx9VdmsPp
 QEU+jMCiIbhVMzSxRpbNO90/vljm9TGZjyYDzkUc379wtuZJXcKbk+fHSFHgJzyKf50WziY
 cFzruQTwk7lkz9pX2+veA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T0eyjIp7Hsc=:1nwa0JpwI/10IurOaGtSnz
 Ca+yw6rhv9tdN2oxXUsRzdAauXbHIIE7PPaDa2y50G0fk8JPFCQQLYgqxwergpY+Udf8yT/xp
 x9vbmPdDj/+jkdoy4o7z4VZVBRTEndb6AB1YB0ZcZUavWB40XtpCID115UeXHTg1gIeoCQ4WC
 9fmTTd7M64xlNoNPHU3L1k5fzVHRyDnwk6fhFBI7o87dCoVe0pnJkn28pDboBvJC+dsZzx/65
 +yakXRE7lgI6Nu46cTZMTIwHIIsnoKfLUY6cvjzwIwnUY9+dDXfDcNhSctN1ZHXNwfGONJuxp
 DSC48sJNitzEXysmnbAuioT1GUvBm1PbXNNxvVydBs9EneFxxZtjlHqnr3tkrNkej5z9lX7yR
 kK06eq9I39JCjVvdgU6884SvkrvZzNMQ/vFJBsVBqPnk15vAl5rB90hNvNNIl+qtzCcUGOiOP
 ufC4eURG4w+BgHdj2nmogQmc7LnW299vY7u1VgeJS1eR7VnZcyhXvUBtZjYjrFAFIXXteKehn
 Ej2XPHn7aRefzE2XIlPJUHGSXVROKxZt5ZW53ZLlkk8PbXJHoFMO3Dnz3FGguzWntO+c4l8pI
 Mx6y5LN+39WOeMuhB6OWNtJ+FsSvvUh71UodO1KkiRjy4NTJZ8Oh0qQC7fWirxNWShQp86YHO
 1nK3aPjl0LYEg+GBlx29GtqLr2GUgEKcxpL+SAEtxWwuOMmpidchvs+aKaD9UuLttgcZd7nLU
 joVO8wi+n+Eu2On0bsu6h8jueGBujLOGiuiCpdqH8wnp5mXSy1Nv9jbWXNJ+ti547TuKEyDf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289406>

Hi Pranit,

On Sun, 20 Mar 2016, Pranit Bauva wrote:

> I could first move individual functions to bisect--helper.c.

My suggestion would be to give it a try already with some functionality
you deem small enough to move to the bisect--helper within a day or so. It
is always good to test the waters like that, and to include this early
work in the proposal, also to assess (and to let the reviewers assess) how
feasible the project is.

Ciao,
Johannes
