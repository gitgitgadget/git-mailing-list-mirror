From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: support block comments in gitconfig
Date: Tue, 5 Apr 2016 13:32:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604051327480.3371@virtualbox>
References: <CANri+ExqdM-TTibWK07B2VFns6fQ09fmbqbCKC1VWET1tgRFNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: timothee.cour2@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 05 13:33:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anPEE-0005RT-GI
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 13:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991AbcDELcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 07:32:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:61666 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757968AbcDELcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 07:32:52 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M70HF-1bjNhd3dDh-00wmY4; Tue, 05 Apr 2016 13:32:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CANri+ExqdM-TTibWK07B2VFns6fQ09fmbqbCKC1VWET1tgRFNA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lGptBiTyR2C11HKaRUJ4B2BgRS3MYIwawDTVF0kl2wIZthQdw09
 LtmN7txBQbB8Zgluv6OTy9LfGdXvb68Fr8bSndJR3Dj6uhZtb4zJik4b0PuPOfuRwScrrJ8
 GwpHuYZIrypNTsbPLrIU5GD1RSfWg5mGVbLHk6klWvVmeXyqrFTmbV8hH1P3rJsY7pvO2sE
 zJsmfaIy+Benjd9d11q9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f3HL0Oq5a64=:EYjKV+RQmBACHQLbewSyMd
 ar5zr8SSlzhiJPsjU5+1olnGsz91DBXTNLIEaghX6TcxAK6AaZ++3Lt11+q3OfdWrNFObZw18
 n3Z0w8tHmmcJrOSfTnjNTc9yL4cFzjP7y3PN3Z2vw2vxwovwKHFznQuC3w1IOfWXJE33FPnzs
 VJuZPYwEhcPlL4kOc0A91Zr9+P+HnDlzVwRZYZa3oKILj2Kgi4b9cBYKuLmnj+DNyQFiqaYyj
 9gnVBw6x9K9NrVI81o8t1f7A8lsxtIxrumh8InjNQQZQGOFC5r9I9Ge8lQtpiSoVLu6TwVGrG
 dCm2lewEXBTqFwWloHiMHefuzoG704PYZPcT5Kzg8shotMBrkCf6TmSMisZMtiRy4f+Gnxd/j
 1zUlkhHLV5JA6gHgp74Wr1HtLvDMbf+tBUQ1Z4cwJ77Bnxm/rwsllF2AFYS2KstPyNeMq/EZT
 l4ddd4dqrlCwbny1jH7slL4KHFnk8C8wAiG/3bODWBWg/UCmZsi7cxZBZtCzPOGVc7OFhAC7Y
 OmjqWLiO2Lezof1/L+cc0YMc9L52iRUQ8hd8XuDjaYKTV9D9WdK8KGNII/lKiOt0XBoikDlTh
 6UY7Xvug1zdKu1C+8JbFpUSIclugJ7ljon6Bc8x9OMtZ3PD7DH8K9Loj/+2s/ebi9pNHEkEIj
 F7jmenAaC3UHzyLGDyPiY+VZUDOAbp9fPmLcRXc32e8wHcL/c3p5VoxqlEYMfknlwF+W5M96N
 jNgxTQVuUdd/+fb/YZSva/twm4B4ZgG7Fyfni6SE56zAB2xkegk23vqxO/5Wuf5EV02tmhpO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290776>

Hi Timothee,

On Mon, 4 Apr 2016, Timothee Cour wrote:

> Could we have block comments in gitconfig?
> It's a nice-to-have supported in most languages.
> eg:
> 
> #{
> commented out block
> #}
> 
> or other intuitive syntax

You could have such block comments. If you implemented that feature.

Having said that, this syntax is distinctly *not* the INI syntax we tried
to imitate. Plus, there are Git implementations *other* than core Git in
the meantime, and they would need to be taught about this
backwards-incompatible syntax, too.

And then we still could not turn on that feature by default because there
are setups out there where different users use different versions of Git.

If you are prepared to push this feature forward, you can make it happen.
In that case, you will need to spend a bit of effort and definitely
exercise patience because you would likely get this feature accepted only
into 2.9.0 (or 2.10.0 or 3.0.0...), i.e. a major version bump.

Ciao,
Johannes
