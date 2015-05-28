From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a
 commit
Date: Thu, 28 May 2015 19:06:28 +0200
Organization: gmx
Message-ID: <f5ed9832bba0381314d01fba13e20667@www.dscho.org>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
 <c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
 <1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <vpq1ti23vva.fsf@anie.imag.fr>
 <xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
 <vpq8uc9yfdp.fsf@anie.imag.fr>
 <xmqq382hlpwt.fsf@gitster.dls.corp.google.com>
 <CAGZ79kansAUWsjBsBznqaxRFeN3uF1u2hUZgO8b+OjOw8SKsUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 19:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1GR-0002TH-NH
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbbE1RGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:06:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:62753 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbbE1RGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:06:34 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MMXVC-1Z2ynw00sA-008Mdj; Thu, 28 May 2015 19:06:30
 +0200
In-Reply-To: <CAGZ79kansAUWsjBsBznqaxRFeN3uF1u2hUZgO8b+OjOw8SKsUw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:2NYh4O3o40ZVrrtkpMVUlct9RrX20JXrR903Jq+HwQulB0Jurb1
 Eop554cenMw62OgAC4QxxgGDbqHhzOmT2Aj8bzJmvquHVZKYGtfGkKGBREPBpTokm3cq8HC
 K9ahceZKYhgXmGNAZV4TpsPB9zhAiqYIleRWy7/Ity8MB9nP19i5DeBRZQkWrDDYFqXIi+t
 I+I4lKCkmymvzq5Dai1fA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4oja69crtJA=:R2Gs0LAIIQw3plpjo2I7CD
 ePmEDBmXOB9xfkNPQSWY9JvYZaUcAQbOwn+590sTMALH/xx1XsE1L6pHVfqF06midX6AgT/Bi
 6r9qnJ6kX5vBQmUMLZ6ZVBtN9/mwLU8ucCQcQUy/0OnDhRstO7tafHCYntuLClNc4Gi79Ea7K
 sQgi5NJWSoaVV94kFw7Np1Y92ibHi2/7/l2OO7hV5LDGm6UyouK72noK+YW8l7DSgW11pU/fT
 mE2DN9p8d8B1kFW9VS5PCxaa5u3omIqVbRoMVUOj9tJRx53/QU2kAiybj3GFYoVbAn9yZ9G5C
 /5ST2Q8oZamE6HtQ+cuWJfwRHwLxN+UV6YxUR3TrreSSGJOX9mbsfCv0PHnG8TPDinqSFK5Tc
 ALlz/+cBnR2qxjB8l5CrGjSwHRFTsMrIazT+teXWxrVi6wpN72EIE/wwfZfyC2fG2fDJwooYr
 xhC2jEqJJMYjxkLeWHJS0vSFq+EOvnKckma3Y5+ysLkXxARKZxbDIvTarfD2/uaQ6mzDsAmMN
 XKCDJ26eGC3pNCG03PWAfnZyKv0CKyo5v1ObA1DMavV0N7qpKX2ZLMYb3NolnqiSnUFmeXXwC
 OkkEkJimRrneXd7/PPaxyxodVMTVBi7tg2m7dqy8YPu4qMrbJzxoGSwyS9l4PQskkMy/2pvWY
 LELn/b+VMFHdPNVP96bZkLdFlFBYNYCQaJpIb1jgcclfwrem2FDQyD2Stj9mXbZbA3Hk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270160>

Hi Stefan,

On 2015-05-27 23:47, Stefan Beller wrote:
> On Wed, May 27, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Talking about ideas:
> I sometimes have the wrong branch checked out when doing a small
> fixup commit. So I want to drop that patch from the current branch
> and apply it to another branch. Maybe an instruction like
> cherry-pick-to-branch-(and-do-not-apply-here) would help me there.

Oh, is it wish-anything time? *claps-his-hands*

I would wish for a graphical tool which visualizes the commit graph in a visually pleasing manner, where I can select one or more commits and drop them onto a commit in the graph, and then it goes and magically cherry-picks-and-drops them.

:-)

Ciao,
Dscho
