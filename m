From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Fri, 22 Apr 2016 08:42:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604220836060.2826@virtualbox>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com> <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com> <cover.1459946531.git.d.f.fischer@web.de> <alpine.DEB.2.20.1604211737170.2826@virtualbox>
 <34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dominik Fischer <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 22 08:42:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atUnZ-0003PD-JK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 08:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbcDVGmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 02:42:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:54162 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbcDVGmg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 02:42:36 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LhOO8-1bX0Tw3y3U-00mZOc; Fri, 22 Apr 2016 08:42:33
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cnokmDiVcDGGITqN0bVfvLApJkvuNSzevPRYPqxuWkobbpFFgvL
 9hjFvoT+3ulUQ1lceI3swCVMpI7dpRymI9rymjwCwOkRgbv1Z0dNWbTyw0bSJ2gL/kCIRV/
 wv8ttMu0dsZCY717QMvcw/pP+Fft8Z0mxDMMOeU0CJF+DnPTiA56WSvv5n7BwmWsPTIoZDE
 L1ty/3Adh2S0oZoKzBd+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n8SQm6Huhew=:ujjnfE/TcJMrra+VWd1KcN
 SE8foWstn8r/4fsdqwqXdyMM5lILvKVX4QENlVHRRjBqAxjnTjdPs7Nat5SF5EhHK5loWR6UC
 9ezFQVK2yMpi/0ILno0O1L90y3n//Ls3DLtqyD/wj+9+hEz3bcCi9GXxnTV4wVk4vYBzDtcKS
 +R3VPGb0ODWm4JrEf3A8gJ01kc/WM7E2f/rqAWZhvIq4Cyanxip4SN7meiKNq0RioxKl9EqY3
 RlqBTCtZbXnoF01UE6/OVaeN6lupoVshWLvtFiVAYqwksP3ppd8JJ6ZpoXyTiFK9p65FlDe/O
 eiFDy7ow2+06fK99cAxxEhIZFKPVoKi8Q7W9HE+/Pn9mbdkjyE4WhnSl+GUnvIRywJ1HHH/3R
 GQD1vCko2yDpTGgJsFU+B50RId94vqLRpyUbH0KdziI1jVrP4wl40+TyepoHmM1kj992d8Wak
 z/WpSjtDtX9CWXck4yz8tmtAuRp3TBG6FC80rlXGMkqrjTix6bvCwIa5BUYWvME73mDjhLUKv
 0b9d1uLZjNtq0K4rh+1jnt4xJH+E44pOz0m+oadBJle0RrPHQsZOKSM3gGQuZ1TE+lb66Lodd
 C9R8WeRCWEuRAmTXxM6D8PqXSy4v3KJcIJXeC15ZijQ7ffe2dj0/cwTi2nRyPBstmI1M6rXbn
 /XV3353uf05rt6huTAgiC7Wv9OLq4+Setq/nhMvwM2RooDrHrXFPZvl8otWGiGRSx4/Bz9PCx
 iNHfJY7L6IA8IbwTtX2yxhuur7B+E2TZmmDYSx0cCoz3QCqT/Xf6EAgBEtI3XoeesRyV5LpJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292174>

Hi Dominik,

On Thu, 21 Apr 2016, Dominik Fischer wrote:

> Indeed this needs more explanations for everyone who did not read the posts
> before.

Such as is the case for me. And most future readers of the commit messages
;-)

> I strove to create an add.patch configuration option that did the same as
> always passing the parameter --patch to git-add.

Ah. So a much more intriguing mail subject would be "add: optionally imply
--patch by default"?

> Junio C Hamano then made me aware that when set, this option would
> influence and possibly destroy other commands that internally use
> git-add. So I implemented the recursion counter, which is now the first
> of the two commits. With this, git-add is able to only consider the
> configuration option when run directly by the user, not affecting any
> commands building upon it.

Hmm. But what if `git add` was not run by the user, but rather by a
script? I am wary that the recursion counter may not really be able to
answer the question "Was this `git add` called by the user *directly*?".

> I would be interested whether this is a suited method to restrict the
> effect of a configuration option to cases where a command is explicitly
> invoked by the user.

As I said, I do not think this method can do that reliably.

Traditionally, we recommend aliases in such a case. They are just as
opt-in and also config settings:

	git config [--global] alias.ap 'add -p'

Then, `git ap m*.cpp` would work just like you would expect.

Ciao,
Johannes
