From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is
 created
Date: Wed, 27 Apr 2016 08:50:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604270846430.2896@virtualbox>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox> <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com> <87a8krpehl.fsf@gmail.com> <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
 <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com> <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com> <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 08:50:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avJIo-0000nc-0t
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 08:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbcD0GuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 02:50:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:63382 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbcD0GuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 02:50:17 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MMkDH-1b3rjq1xoV-008XYo; Wed, 27 Apr 2016 08:50:01
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:rwPrJwVnpatjVaH3V65wrO2QPjS9HkgdwBH5HHSQfuBW8NovgQ7
 I1XhrohuKhY+r0uuQ/fg1+pxpn0JrT37AcWf9uT0tAlk0EVqOnjMNHjhozl/rtlWNxYBssC
 BLeQDVtuUKMXNEZpjjjsgrg5ouf0K3Vm4iIJUJVp6DPF2OS+t0YKube8vL8XUrssfN7ma9f
 bNtH8XwSoPzz4DCY3L14A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vMua4i22qak=:eEFRJo9dfs0Qttf0Hsw5Uz
 92IUCd3M8ruD1DZp+SAOAmXbLJn+1B6VMFo/sUZbJlxTgBb15fy02sx0cWPVJCDu5RCqJo8sY
 MUfBjrA21sB/Q26i0KYWvdl3RlCD0UScKUDcFbAeKBJKxJQ0NxoXNLK42TQS1MVxRP/EmHk2f
 hFDyYrZe3AiZJIPzZpshzboLnXRSMfHeEzYr+38K1uB7znp7+K8vF4hAuj88f97faq3rt3bx7
 NoG8k/KoIvnBGUROQwi7s56g3EM2hNzSUTHJnL9O11zhZlruB6S6jPgEA9X2m+OQ//Pqy4cfM
 zw0cz4DYHzQ5KfDW598y5f4X8o+RtkFOPr3MeN5czEBxWkFNR8l4QSZzc5vXID2Zkc56WHnQL
 mzT8VDNuIB2QVtsFlEHGgpVzXm921qwy4Zwp5mUhgp2vEPBASaqN9JSN0NgEz48MZzSxgPhZa
 2Fsy2li9gPKxkPzefAvGeuo7pkpjlEDi7bK3CeCTfWTNpRupV3GB9UG7xia8o7tuuHUh0holL
 AN8PTj4iSup/YIvkmMCniol4mr85iA7CBvQsDZxteDLAZAZFMqNExMHQx9jXDpYjlH7BZ8NBg
 n+2ab21Hbk3pgy7JnOteN3LxJ+oNCm7W/3Q/Vfrqaj+mbuPLQZD1YKM0lCvSNYg167Xu+DqHI
 siXXUBkpbKVC82aw6WZLov9uouZ4dRCQD/cqz0D7pti3PelnXr/FwefRj1Cyzt+LD+XGNFW4P
 y/1VLPM09LtJDqDL9LQyUDxhZz6/rAeRG6KeFkWIycaOEtDR3NRj/VQtN8v/W6PSp6BH4JXy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292711>

Hi Junio,

On Tue, 26 Apr 2016, Junio C Hamano wrote:

> @@ -1157,6 +1157,15 @@ static struct commit_list *collect_parents(struct commit *head_commit,
>  	return remoteheads;
>  }
>  
> +static void no_commit_impossible(const char *message)
> +{
> +	if (!option_commit) {
> +		warning("%s\n%s", _(message),
> +			_("--no-commit is impossible"));
> +		warning(_("In future versions of Git, this will become an error."));
> +	}
> +}

I think this would be a step forward in usability, and I agree that this
is a great opportunity for the users who wish for this feature to get
involved and drive this forward, based on your excellent initial version.

I am not sure about this double negation "no_commit_impossible" (I only
understood what you meant because I had read the commit message first,
something I won't do when stumbling over this code later).

Maybe something like `disallow_no_commit`?

Ciao,
Dscho
