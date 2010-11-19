From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: How to import bzr repository into git
Date: Fri, 19 Nov 2010 16:34:11 -0500
Message-ID: <4CE6ED53.7060900@gmail.com>
References: <AANLkTinVrwkOvYgGFX3S2530jfWnrAP28gVm4te1B4sC@mail.gmail.com> <AANLkTimPmPOJq64=VePSb2efsx17j8BNxCLt_i=b2ykW@mail.gmail.com> <4CE32062.6010308@gmail.com> <AANLkTimm2unZoUNH=wgnAFjPpeF_C=tJAZ0DkNK4mMv_@mail.gmail.com> <AANLkTikLt+=ffsqY1=-fN49fVZ_Q4HVWnzn5qSftg=T3@mail.gmail.com> <20101118163702.GA16610@burratino> <20101118163851.GB16610@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Dmitri Pissarenko <dmitri.pissarenko@gmail.com>,
	git@vger.kernel.org, bzr-fastimport@packages.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYbY-0002AT-Tx
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab0KSVeS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 16:34:18 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38546 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681Ab0KSVeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:34:15 -0500
Received: by qyk32 with SMTP id 32so137565qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 13:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=f3JoOrYmfYxb9IbxZzAaLRD7r8n+ZpP6/zzGn8ymqY4=;
        b=O/CNsDJnbwEkQaeVvT08M/1TjtwHYUfAEP4+kBBNtNzWnyS0hmEv5V+JLGnujThAuE
         DlremF80F1rzspqYB+PLCm/If+nngAQm/FGDM1EnLKgxQD5Dibj/tRfTVRGiW7Q9NcBh
         39m4dIyMhXzPGf1uH6hMfedxctLHn3gz7UL2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dLWlilVQXuBiVC55r/4HtkmOm4HBB6W8jZXC6CGh+WqaBcVoN0ohu+UpkD/QzaHJ96
         McHToKcbG8cRJ0352MHTlfHTcyg1d57B4oixmL1bRMmcmzKct1NLL0X2JEFRQdbiTql6
         QPYD8TPR6JSqiFiaYRyJlhqiq9iBLshM8WfC4=
Received: by 10.224.10.202 with SMTP id q10mr1304324qaq.373.1290202454809;
        Fri, 19 Nov 2010 13:34:14 -0800 (PST)
Received: from [192.168.2.207] (dsl-147-180.aei.ca [66.36.147.180])
        by mx.google.com with ESMTPS id nb14sm1245451qcb.0.2010.11.19.13.34.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 13:34:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.15) Gecko/20101030 Iceowl/1.0b1 Icedove/3.0.10
In-Reply-To: <20101118163851.GB16610@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161792>

On 11/18/2010 11:38 AM, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> On Thu, Nov 18, 2010 at 15:34, Dmitri Pissarenko
>>> <dmitri.pissarenko@gmail.com> wrote:
>=20
>>>> However, I had to give up this idea due to an "out of memory" erro=
r
>>>> during bzr-export.
>>>
>>> Buy more memory or use more swap?
>>
>> Or report it as a bug/wanted feature?
>>
>> Cc-ing Jelmer Vernooij in the hope that he might be able to point
>> to the right person for that.
>=20
> This time with a valid email address (sorry for the noise).

right! I did see this with this particular workflow:

bzr branch lp:bzr
git init bzr.git
cd bzr.git
bzr fast-export ../bzr | git fast-import


the weird thing is that using fastimport directly with the lp:bzr
address (not "logged in" to launchpad, so in practice via HTTP) instead
of a local copy of the directory took a very long time but worked.

So I guess there's probably a memory leak when using local files.


other than bzr-fastimport, there is also bzr-git, which seems to suppor=
t
some form of pushing (bzr dpush).

There are also mentions, in different discussions, of tailor:

http://wiki.darcs.net/RelatedSoftware/Tailor

And finally, the git wiki mentions BzrToGit

https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#=
BzrToGit

However, I have not thoroughly tested these tools and I have yet to fin=
d
something that works right in all cases. If you give these tools a try,
I'd be glad to hear about your experience with them.

--=20
Gabriel Filion
