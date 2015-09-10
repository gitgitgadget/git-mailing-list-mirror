From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 23:21:19 +0200
Organization: gmx
Message-ID: <5f1102c0fcdb3530148ae7a6a18bd0a7@dscho.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <74514591d4cd502eee06cde3e099e656@dscho.org>
 <CA+P7+xrH6v7AVaH_su2X3xx7qs_uws-r-DozzYELm_O8g+oN9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 23:21:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za9Hv-0005bj-0l
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 23:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbbIJVVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 17:21:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:54229 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbbIJVVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 17:21:23 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MAQXq-1ZU4kc1qUU-00BdF6; Thu, 10 Sep 2015 23:21:20
 +0200
In-Reply-To: <CA+P7+xrH6v7AVaH_su2X3xx7qs_uws-r-DozzYELm_O8g+oN9A@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:juJmAcaL2O/mY1vWvRWoZvZsXnQ+N/sdUUk06+mibEUEs6KZBKS
 WdkjF2TmTYUf02dEeCD5p70m6tumr9exUeXKHnl5sr+vRvYS2DPAiTK2qYcpMl6Lo6dZ8lx
 gtCPC1mE7QNveKF6LQgbmUda9wDsQQj11afGXBpRMEMItM/IdeWt376UO4Qss5CXSJQM7Ud
 DXGJOKokxTJjhP9VH5Xyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6wheXa3ig7U=:Gq002V1CSTe2ypcJgRk+bD
 Lb36BKaU8eLgK7SA3um7ZelEdFNS36YGp1r93dg9o0ECmbk3C/KxQM+Drs4yIczsYFGlUSKOn
 fPS5XpvJDKc03sp5oBHjP70MtmCKnW7IbEPwyKMG87tlI3V17SU0XLVMo003/ioMPcHaoYDKr
 OuiJ3DEzuy438mwD3GViM4G0TSC8WuixGDpYZLlmyWgsGC+vYqKFk5EuILzBgLi/alY7oC3dy
 VHCHsCa4VBmcldSY5SUQk/akCSSSHptvuam/dujNTTKVghSsad70Ag4f1OgZGnFuiNw3fUWku
 wYmg1NJJpdybXec1fRRtfj+Y6F2cfUB4ST5YBcYp5acIYFCNzf2qgXJ/ezt6Z7ODomx1YG6Tw
 HaD2EkPyeD+vGvoQLBedESEcPGUfVIPGp6YaqZjfpm1Nk8C/sV2AEs5Rtq6IhSXuvcBfDei+3
 AqbOs8nat+EobDQSLP363cZ9QLQnA+77JlcMdrIknMnUO0H7VTI8LaHPkooWJ75mYh1QXha2L
 TgVWZ9NW2f41p7o+DDKjPpg5k53W6NFS9bvrRHgrQEPhglCnNU7s7qnKE0gwfgGQgxFBRrSjA
 zqvbImeqtvV15hXpHMtQgSV72NKYyx0QgOWEnkYYk+YvSTnI2hbUfmImk619Y7yJpUCMnR+q4
 Gtfl+UutHXjerjGHdg49icVyxhRkR6j76S4pFU3lYXgX30Cqri0JX9HdYmDyD0MOC67p9mPxa
 Zt7QJ5JqcDEehW1ejtTMHPfkltAAcBScamnN4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277640>

Hi Jake,

On 2015-09-10 23:00, Jacob Keller wrote:
> On Thu, Sep 10, 2015 at 11:58 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-09-10 18:28, Jacob Keller wrote:
>>
>>> does anyone know of any tricks for storing a cover letter for a patch
>>> series inside of git somehow?
>>
>> It is not stored as a blob, but I use `git branch --edit-description` to write the cover letter for patch series when I expect a couple of iterations.
> 
> Does this (or can it?) get used by send-email or format-patch's
> --cover-letter? This sounds like exactly what I want.

Yes, format-patch picks it up if you say `--cover-letter`.

Ciao,
Johannes

P.S.: Please do cut down the quoted text to the part you are actually responding to. Bottom-posting is not much better than top-posting...
