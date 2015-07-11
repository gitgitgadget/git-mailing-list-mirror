From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch.sh: clarify an error message
Date: Sat, 11 Jul 2015 10:16:40 +0200
Organization: gmx
Message-ID: <e753df13e78f23744fce015ca58be47a@www.dscho.org>
References: <1436053144.3463091.315316457.1BAF8BA7@webmail.messagingengine.com>
 <20150705130706.GA5435@peff.net>
 <aca69b93d8ab5f3c610d6201ed4334e1@www.dscho.org>
 <1436580240.2553376.320852705.0F1D7187@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Chris Jones <chris@christopherjones.us>
X-From: git-owner@vger.kernel.org Sat Jul 11 10:17:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDpxz-0002ev-Oh
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 10:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbbGKIQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 04:16:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:54867 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809AbbGKIQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 04:16:54 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MAQXq-1Z7pfl0tQ2-00BeUz; Sat, 11 Jul 2015 10:16:43
 +0200
In-Reply-To: <1436580240.2553376.320852705.0F1D7187@webmail.messagingengine.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:FgMEQRA7VI5wB6IpiIXAfqy0ifEu3SB8+/scstnE/SJ6ZyDpGK+
 u7mdnG/NXrAs1c6QnndeFNA47pMEcrIyNyVBfEQQ6RtQAOdWa9d63ElD2W3zhK8257wmp9B
 oOlnGPzC2dqisjOi+BlTRhUj1U+ZVZayNl+1mRaNv+QatIKC2S91YQE0+L2Zm922uazTBpW
 JYe3t2z02ZAnSeYXlRUkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JXB/Nvap1Oc=:GFFc99iOyuSyuZ1+4VMkW8
 LhQNeJuUCDEnQ2Mui3LdOmDsY6dhJZvdXyh8eL7AvfrfCBilL4pvn3rOkWJe0GpXQXH+W4gEi
 8mOR/oGQCdW0RboYFpZpDe0MrbWbBw1rCcpmBmir6VsbANSjZo/4qIGShLYviQO7HjFpF3+jT
 17f/2iFfSN+dstVtXLF+AVcpw9X2/boUJb6WdLMtpIfgRp5tiY20wF8Tl1fQPOczmlsUHoStE
 +M1OSRngweSYnl4+m9QzEh9/apvnlNydq9s4uTtRtmHNdbjqezGs6ISFPHX2/RyIb7kqd8O4n
 ddB9BzTLIcp0rAqE6Tv6zHU5DtfgKhhpmwcTvDgc0765+d8Dl3fDUINnrobTEQf7ULWZDQyj0
 xpUeHqN8R8SDSs0HpHkwCF2LhKBe2zNU2g0MXjA53rRijpMJui8TCU2KSlA38V76dMqIIXbbC
 YiqzQEl2gpwplkQdL8eE1fmqNduSlB9gMiUd4/CnpuAK7ncwJWTbjs6Ef4G5JOSXIX+rSdFXs
 H8VxF53tAXmkYOFhRXBPSDfwKdaMLksiI/kgEYfle56I/W1jLj1J/2Ut8PZNNr6oUpCd2fV9T
 k6kuXuxItmv1XjPna1q9ae1QLVwAPVXdrHm7Db77CtXs1D8ga+Mvwe3pwusMRBDsfUuB94XuY
 s7dj01bNtDlC37zCsi3KVV3rBoamsWOCoKe9I4BIQG2it6QOWWaR0KyMrLiw6XXXcbkE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273868>

Hi Chris,

On 2015-07-11 04:04, Chris Jones wrote:
> How does "You did not provide a valid range of commits.  
> At least one tip in your range must be a ref." sound?

Maybe a bit shorter, as well as less accusing (which "You did not...!" may sound):

    filter-branch requires a valid commit range.

Ciao,
Dscho
