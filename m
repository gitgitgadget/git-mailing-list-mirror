From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 15 Feb 2011 19:15:31 +0100
Message-ID: <AANLkTim3g15GRZUhrq4=Bs28JHr3M53U_QavtyUxsh7L@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 19:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpPR5-0007Nr-7y
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 19:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab1BOSPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 13:15:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab1BOSPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 13:15:33 -0500
Received: by vws16 with SMTP id 16so305427vws.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xaxnwaXgva09yUXXsQYOYoxpRXGrBphlgSSRhsZaIUw=;
        b=Y9BULg8tbhG53HyXhqC7VvB0mL7eejJjcCmLNHRnNoMwSOTToC/ZmqnUEVwo98kGQD
         9h4+qnGBeSnyIkcqdzVqW7NpOhEgWhaWt2eCjMegn3LVU5OuR5a1gbwRhLwbQxZIpoF6
         4CPCQiN23FumUWrTmIVIQZal6LDhb60ontqS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oDJk+FLLqutV6F4iyNAnWaCh2Q6XZkX1T04zRtX2wqFdbU4djk2JTS+Mu+xPH04UC+
         dtl6XhV/yGWUnSrjiBmNygXl/m5cyrImlp275iSolnIn7hqiKiE2A1FT1ZZFDQGgbiU1
         tXr6e7xSQnQtsVI8w7f/PHTn/Ey4SUkwv/2zs=
Received: by 10.220.198.203 with SMTP id ep11mr1353618vcb.36.1297793732089;
 Tue, 15 Feb 2011 10:15:32 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Tue, 15 Feb 2011 10:15:31 -0800 (PST)
In-Reply-To: <20110214231920.GA24814@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166863>

On Tue, Feb 15, 2011 at 12:19 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Hi again,
>
> Piotr Krukowiecki wrote:
>> =A0--refresh::
>> =A0 =A0 =A0 Don't add the file(s), but only refresh their stat()
>> - =A0 =A0 information in the index.
>> + =A0 =A0 information in the staging area.
>
> git add/update-index --refresh are precisely meant for _not_ changing
> the content of the next commit, so this particular change seems
> confusing.

If there is no staging - no commit, then you're right. But then you don=
't
have to mention index at all:

 =A0--refresh::
 =A0 =A0 =A0 Don't add the file(s), but only refresh their stat()
   =A0 =A0 information.

I completely agree with Pete Harlan - for normal user git internals are
not relevant - index is just part of git. How or where the stat informa=
tion is
refreshed does not matter.

In the same way you don't write that it's done by function refresh_inde=
x().


> Hoping that is clearer. =A0Thanks for caring.
> Jonathan

Thanks for explanation.


--=20
Piotrek
