From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git fetch,git merge and git rebase
Date: Fri, 11 Feb 2011 14:32:47 +0200
Message-ID: <AANLkTinsBz0Yi5XXYUcaJMTvkjuhtNjotx0VWRFcKX3d@mail.gmail.com>
References: <1297315789338-6010561.post@n2.nabble.com>
	<4D5464E7.2010407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Akash <bcakashguru@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 13:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnsBD-0006XM-3t
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 13:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab1BKMcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 07:32:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1BKMct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 07:32:49 -0500
Received: by fxm20 with SMTP id 20so2634302fxm.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 04:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HsniTXs9eyP2AMmQCGNTfHDfvczE2pWIqbc1Tpsx7MI=;
        b=aeeG+syzngjEA+mTfEcTUv5rXYJ3oK48XEM8sdFD+2TCV3iPz2NpaCMkGLSuXF9Lpp
         wbPJysDiFIpEcn8ZsrVqJPzUnp2id3QagN1/8432RJAUOTZSvhsnu34Fc+nbf9mEneYh
         nje2Qclvg6NDVswg+UshGIOSZtoNC17Ik3Sq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uLzXRXsePEJ/wRtw+aKj1AxYMoLtrOwuc0HoKrXZTfSxo+tUq+qK9hdhhZ5cCM1/zh
         qdBE6E3+/Loe8ePWzINcvEKblVihcWFmNmCFNsmArqMg5UAAKIN+x6aE1yf+j4bnm8vO
         LBZ+5jyODT21h0hbMMZtCdqAbHpVg/3dqmkTY=
Received: by 10.223.83.6 with SMTP id d6mr466948fal.95.1297427568086; Fri, 11
 Feb 2011 04:32:48 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Fri, 11 Feb 2011 04:32:47 -0800 (PST)
In-Reply-To: <4D5464E7.2010407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166556>

On Fri, Feb 11, 2011 at 12:21 AM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 2/9/2011 11:29 PM, Akash wrote:
>>
>> Hi,
>>
>> I am new to git .Can someone explain in simple terms what git fetch,=
git
>> merge and git rebase do?..I tried googling but was very confused aft=
er
>> going
>> thro it.
>>
>> Also, can someone prescribe a link which explains git in detail righ=
t from
>> scratch.
>>
>>
> another definition of git-rebase:
>
> git-rebase: =C2=A0the MOST DANGEROUS command in git. =C2=A0you can ea=
sily DESTROY your
> repo if you don't know what you're doing! =C2=A0Until you get the han=
g of it,
> always make a copy of the before-image of the branch your rebasing
> (mybranch) by doing a "git checkout mybranch" and then "git branch
> copy-of-mybranch". =C2=A0Then if you destroy mybranch you can recover=
 it from
> copy-of-mybranch.

What about 'git rebase --hard', or 'git branch -D'? In all cases you
can recover by using the reflog.

--=20
=46elipe Contreras
