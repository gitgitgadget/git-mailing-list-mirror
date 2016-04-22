From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Fri, 22 Apr 2016 08:45:46 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604220843310.2826@virtualbox>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com> <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com> <cover.1459946531.git.d.f.fischer@web.de> <alpine.DEB.2.20.1604211737170.2826@virtualbox> <34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de>
 <vpqr3dyud3i.fsf@anie.imag.fr> <xmqq4mauucx6.fsf@gitster.mtv.corp.google.com> <d6747d29-601f-d9ba-2f27-812bf064edff@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Dominik Fischer <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 22 08:46:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atUqn-0005sI-2O
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 08:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbcDVGp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 02:45:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:57173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcDVGp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 02:45:56 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LaoMe-1bZBKO0L1M-00kOeH; Fri, 22 Apr 2016 08:45:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <d6747d29-601f-d9ba-2f27-812bf064edff@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zwn1WvfcufplKN6LaigP6IaCt1pO/ilK2wjk/Ym1IT8XffU9kLF
 F62dEBD/ef7EjAFfnpbKLzPthBlgwGfSlalVrTj/1uCs0DP1kP6rUlc9RbqQBdBDJEDYqD9
 bVui0+l8Ny19PaThHSUjHpUALook9Mq5EVIky+JDPa3tJ2WM9K204C0mystIRmDzmVF8QL4
 pqtSZM3U4INdAbnvcimAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p2JNpDmqNmI=:Zzgs9yE0Y4XxAyapYYH9o1
 UUXL+x5OysPn4D7E0yJ9b54ErjERRdMgPphzMQVISPORjlWfrkewtzUvC05UT/9GyeXypQioq
 R7XdOrFFEiibIHvncGsQIacQ3CnPOCd13pM0TiXAJRr5tYqG9BxbJfs3gRHozP5YjQMhDTGuJ
 TWt1ctElem75eEMA5AbYa5CaGmxaTBW87t6qgvUqG2D3JgQxeMfEHnMOovRV7YOkpKzUXx1w/
 VpH3dAiFtsJPKjmTP775avaj1bDwBqx26huAhSaywMFvE3Sg6s5M2NJMvksiaDZNipO2wF+nP
 +XTk1vW6r9AGXWFHnlGrykiqY8V0vY8YRiUqB3+5/iHv1Eac5JoCQGR7OvwpTRkTunSbihYKo
 AFe92OJ2+o2FxxGvbofKU8+sGTHKB3HlT4/X6NtZBM/KSfNJz83Ful3UY7OEgWLWzO2QonKtn
 PVac69fnnCsPBuTjNl+qk+/4Djjdog1Q4RgjSkHAiFZFblLXSdHchzeLdUp0HutvUSVmqWY8a
 37G/WGMOeXLbBpLBpvoXNnisa2/RKuqgqbEO91XlPLNyY/t32mhZyHClFN2/aPClCdS7IhAKR
 RHFtP/BQoe9MtoSUlZG0eJ92PbYShNoWK9KXyB6pccPiButHeDeBRmuopU8xWbg8ZLIu3mI3j
 RR2KH9e1hHvK3giSZxBYzVtCpE4YNE8ygdl67CA27S+njweOfIgUP++wtML7JKq0sE+wlPWvR
 R++6hzvjs8WH/pg7YdyOeC5+jrU4VhVgrWHLd7pibBiMx60gKZ1QezGPjbGtQBTU/y7smiDj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292175>

Hi Dominik,

On Thu, 21 Apr 2016, Dominik Fischer wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> > any transition plan would be far more painful than the possible benefits
> I agree, it cannot be expected that every external script sets
> GIT_RECURSION_DEPTH before issuing any command just because of this little
> option.
> 
> As an exercise for GSoC, I implemented it nonetheless to get more familiar
> with the code base and testing system and receive some feedback. Perhaps the
> counter can even be useful for some actually significant use case in the
> future.

Maybe. We come up with tons of patches all the time, and most do not make
it into the code base, though.

I still think it was a valuable thing to do: you are now much more
familiar with Git's code base. And you now know why the proposed solution
won't work. And I guess the alias is what you'll end up using.

Ciao,
Johannes
