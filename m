From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] mingw: introduce the 'core.hideDotFiles'
 setting
Date: Wed, 11 May 2016 10:40:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605111035200.4092@virtualbox>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de> <cover.1462603453.git.johannes.schindelin@gmx.de> <32f14c212946c7c1da8007c8eff536fe82872f5b.1462603453.git.johannes.schindelin@gmx.de> <xmqqeg9bw3gi.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605101047510.4092@virtualbox> <xmqqlh3hrfu3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:42:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Pik-0006db-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbcEKImN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:42:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:58954 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbcEKImL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:42:11 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LtZfc-1bjH6q33vY-010xa7; Wed, 11 May 2016 10:41:52
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqlh3hrfu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:E6XeAmxjyp4ruuVTR2aCZEnUpQhau5beT6yjz170bbLInyHPM9N
 9aTTYnWICKlcqWr8pgSwFB8bei0dnHOU9k5xq4fWFbjlTg+A532KyrmM0c190ndFzmldewU
 DaxhKmWlRBsZRvfGHl3Pbmgs1VinwjQqxtn4eDJEvQWh3vKQyk4YGKTSauZi9rjz7G6Hrbz
 2BsvVJdTTD3I0cc8J5r5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4zZKjKD0MLI=:pRD+jLDKu8qH7O6D71ZmFM
 3naceKjMAzipIyfi4E1iwE5vigm0i/3OR4XI7iLv1RYNSMuDR1G/uhTGexTsewL8dHHZzeo3G
 Y/h7zSyUsowy91LnJEjqDN69QbGTXTo9j9eN4EvASpuZkdlRQMkqB+VExe6uGy/8DjC3twlB2
 NvE/e+5rn9SaQcl/vtaTpf9+v1ttOE47WH8aJ+Icl9F8cd8RVUCfG4RijVWFFWBAM/B8IKvxl
 281DukJky5ud+x3nbyUYQt881kO9T2LCSBQYMTfJ8apboK6g84r9wHxOce7MqoKSS5T3uqWI/
 83fxYRVJCkS6KAt6mwL2KFloxPkilTgWupgTcVjTVll2gYD+cEuzsq8EVc5BZPzbABj9e7wAh
 dlMYmND0zMrL65kg2y2V8lZHUTT4v43QaLq42/9IbEwmRepFcuj+69pGsB6OEcR02YoRbE+1Y
 UO2se6J1NUqqO7TGY7Q5r0wrLAmrYR2lEV5pXGZzfmXZuapQTBv26YR70ERN9HAvirLUhmurq
 8PajGj05KEz/wCx1K1XeQ2MMFZbst4ieCm4pZOBZDwY1sIZDHHSOc8kS8grW6lsV15+UDW4Qm
 C6lTlXGZazfJo6LEiUbB7Ue2M8mV7ai9wXJpWJo7rUoUoAH2j0Boj5vEVTp9suxC67l5Ieo7E
 Rxv7HcM5SlWdaRepbiXtmCRBxKleyCep20B2Ly9aVwMi+/58hy02z7WC0k7G0ChNUL9RONDpg
 cslrR/lfYYBTX2XRzHecwkUFbIcRASsculaxyVLNFvpBYqV1+bV5H/cp3O+f5xvaXQYXC8Nq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294239>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 9 May 2016, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > +core.hideDotFiles::
> >> > +	(Windows-only) If true, mark newly-created directories and
> >> > files whose +	name starts with a dot as hidden.  If
> >> > 'dotGitOnly', only the `.git/` +	directory is hidden, but no other
> >> > files starting with a dot.  The +	default mode is to mark
> >> > only the `.git/` directory as hidden.
> >> 
> >> I think "The default mode is 'dotGitOnly'" is sufficient, given that
> >> it is described just one sentence before, which is still likely to
> >> be in readers' mind.  But I'll let it pass without tweaking.
> >
> > Yeah, when rewriting this after Ramsay pointed out the erroneous
> > documentation, I wanted to fail on the crystal-clear side.
> 
> Saying the same thing twice in rapid succession does not make it
> any clearer, though.  If you are rerolling anyway, then I think it
> would be better to shorten it to clarify.

Okay, will send out the next iteration in a moment (this is good exercise
for my cross-validating interactive rebase, and it is really not all that
much hassle for me to send out subsequent iterations).

Ciao,
Dscho
