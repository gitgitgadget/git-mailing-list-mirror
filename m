From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 17/17] rebase-interactive: introduce interactive
 backend for builtin rebase
Date: Tue, 15 Mar 2016 20:45:11 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603152041090.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-18-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603150800420.4690@virtualbox> <CACRoPnRhhMM0e3S23KVnEANwNRDPq0P3hSqn5Zs1ksZxeaAoiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:45:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuuD-0000gF-Em
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965804AbcCOTpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:45:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:57514 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcCOTpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:45:19 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MFcg9-1acs73239B-00EcEY; Tue, 15 Mar 2016 20:45:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACRoPnRhhMM0e3S23KVnEANwNRDPq0P3hSqn5Zs1ksZxeaAoiA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LLHSwJvsqtf42Sfy+zJ8V6Xv7vicB4V9Ov+bM17PYMUcrBejucj
 VzHiggUT6n/2ila5OblyKOTlWH/hitPhB8IoH3yolmQztnP2cXOGUjzCNEWpOQDeuqTuAOY
 1GUQm0npyInsXp9zD3EohIejrxMkSfWuW3qEDRRZyBaiVHzmBVciQJi0ZkkERKjXUfiLRal
 UP6GhttOa4CSyR+od9mcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DKuQU2zV89g=:6SltvMGkG+qJXxoqdJbhrI
 cYnZ8LUcAET97j85HgQuG0alWJpHSpgwOx9mTJpwLly/+qDLkB5uoNto3gqBnFzNozNzBFI6l
 sjWEo2/e4CA2esAn6SoxB5M7UR4INlk61NKwX8yCFlyqEMJNU78YDrkF8BjPKuk2dARB7iQlh
 g1Md1n28emzbMYkW/Q6magVVdGHjtEZRJiQjq3ak5GisBkFKff3ugb3/K7C/W7Qcy4+wUlDMh
 Kz9My/JC1wlE1m7Xl9bGU6lwGqJ1DauEgri71OkNU6QXorpvd0hNuc9hgSChL2l7p0uUQh7MH
 g9k9h7isGkV2zGAv3JZlICSyUHPKl8Xp5zjigxE+w3PZXgi0q1U2fklo8a6mL2x5c+BH04K1y
 LM5hAgxbpnQ8/T6y7YMPYaOHMRNAv1rUX2StjooQmeeDjHGFEqWGC0HYi/OvlP7arpK3nXxr9
 cYCIrbl/o6BOgB+CqiZIiHyzluWyO7AjuuMcTOyOy4m/DebU7Fj4uinmMgtZJdSPABtItiH9V
 /UroTaJBpTbZgpHPCnZtlI5u+FsMydBx1wrcItpHXCG17CwubHP6KgvwNsclmMlxdoQhGsTz/
 QKXT8dMeQcI+Tyyi6UP3XZX9oP9xYRzGh+O0UNtlVOxlxq5KLnIGP4VB+4HDgEBCtqet/RwTG
 CohJkb5v3Atu+kpsEFpNgNS/eiiEp1DB42l8e3bzhF7Ph+uWJJlxYjp2Vxs6Nj6td36ZE2Hpd
 Wqlh6m/1AbXoLOWoCw9RPf3ek8Gr6TcdBfUJfKPu9oQtPvdORLSPp96sUYFTY2QmUBlp0Kiu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288902>

Hi Paul,

On Wed, 16 Mar 2016, Paul Tan wrote:

> Even with interactive rebase out-of-bounds,

It is not really "out-of-bounds". It's more like: hold off integrating it
until I'm done with v1 of the rebase--helper that does interactive
rebase's heavy lifting (which should happen pretty soon).

> I don't think it's a dead end though:
> 
> 1. git-rebase--am.sh, git-rebase--merge.sh and git-rebase.sh can be
> rewritten to C, and call git-rebase--interactive.sh externally, like
> what Duy demonstrated in his patch series. The timings show that am
> and merge rebase still benefit, and that way we will be closer to a
> git-rebase in full C.
> 
> 2. git-commit can be libified, so that we can access its functionality
> directly. (sequencer.c runs it once per commit, rebase-interactive
> uses it for squashes etc.)

Both look sound. With 1) I would also suggest a rebase--helper approach,
though. That way, you do not need to break the test suite at all but can
flip the switch at the end of the patch series.

> Or would that be stepping on your toes?

Nope. 2) is related to what I do, but I modified sequencer.c's
run_git_commit() (which uses run_command()). Your plan would make that
even better (although the edit phase is of course not the
performance-critical part that we want to enhance).

Ciao,
Dscho
