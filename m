From: David Gilman <davidgilman1@gmail.com>
Subject: Re: Reproducible crash in git merge
Date: Sun, 27 Mar 2011 15:24:58 -0500
Message-ID: <AANLkTinW6pndDmpi=mewxXT=vLSePoJ2meMozCSht6Ze@mail.gmail.com>
References: <AANLkTimxHn_fwMKh9cbp9i5LkShUi=HK44nv2KJ7ENaQ@mail.gmail.com> <m3pqpcv5ph.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 22:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3wWh-00049d-3u
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 22:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab1C0UZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2011 16:25:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab1C0UZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2011 16:25:19 -0400
Received: by iwn34 with SMTP id 34so2956737iwn.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=4XGOa3tQi8bAWUd6K7FuMeWNVaWcNdYrtV+oWreupGY=;
        b=tg8uAvtvoAY/4YutQxrfpQa3T3urMye779NvkMxPfHYtyVHonb+Zi6rZPZj6ic3k4i
         O/xPN52INvvsIlk1CiqAbx7vveOEYknHBIcAnJfyO8jW0rUGkrgyR87nFUW6jSQUKgZQ
         MqXs3BXYN6B5NkyYebJ6nbFHOuChsK3W3jjeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=G6IKuP2s+zZpjZvgL6V2MUbwf/hNFnYR5FZMrGaKuJWfsyHUJk9b/5f2yf3unH1OKr
         kWWGasZpgLwvdTQnAxeJv7gVQ/5o3eEUpbLTm9vw7G2Lv7bpF41DqI3Bopz29+EdKkPY
         pL4M1by8pZNP3SaJUsJQ7842H0fpCe0uJT+pI=
Received: by 10.231.165.212 with SMTP id j20mr56671iby.139.1301257518152; Sun,
 27 Mar 2011 13:25:18 -0700 (PDT)
Received: by 10.231.180.220 with HTTP; Sun, 27 Mar 2011 13:24:58 -0700 (PDT)
In-Reply-To: <m3pqpcv5ph.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170088>

OK, well I apologize for the bug report.  I was able to reproduce it 2
or 3 times but I can no longer do so.  git fsck is showing no errors.

On Sun, Mar 27, 2011 at 12:23 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> David Gilman <davidgilman1@gmail.com> writes:
>
>> I can get git merge to crash during a git pull. =A0I'm using git
>> 1.7.3.2. =A0The repo (afaict) is fine and had worked previously.
>
> "git fsck --all" doesn't show any _errors_, doesn't it?
>
>> Unfortunately I can't share the repo itself because of its contents.
>
> Does anyone remember the script that can be used to anonymize content=
s
> of repository that cannot be made public for debugging purposes?
>
> Unfortunately I didn't save this email (on git mailing list), nor do
> I remember enough from email to find it on one of git mailing list
> archives...
>
> It would be good if it made it into 'contrib/' area, isn't it?
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>



--=20
David Gilman
