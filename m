From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Fri, 31 Aug 2012 17:30:53 +0200
Message-ID: <CAN0XMOK1_JqMuAkW-XzGfkn8pkTUqt879-+E0cGBn79GzEXWkQ@mail.gmail.com>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
	<1346347393-8425-2-git-send-email-cmn@elego.de>
	<CAN0XMOKar3jdDMfY=rRkcmNy0i0zKMuhBQ=Z4bi=eus_xAFWyA@mail.gmail.com>
	<87mx1b3x3m.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:31:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7TBW-00044Z-D0
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 17:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab2HaPa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 11:30:56 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63056 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab2HaPaz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 11:30:55 -0400
Received: by weyx8 with SMTP id x8so1712684wey.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SXPI6I5HNtcD8XH88DD1+83Vd+Kcc/DqdRRFxyN4QUo=;
        b=F5lYB9GW9trLcAWv0QjaPdq0gKpUtz5vu9uJsEckuMkXxasYEeP4qQZAcUqvIuCLQS
         wB6WJeUGQ0V9S02AGsQ03DR7fQrCB9zqAAhtnY/LY/xmaaWct21/I+CaYLCHgpg0I1qg
         G8/TCP+bld5ZuwTpal7kyiMn5VIMwcBSMsbAFAosp+enAN6ubQJIOhyGxaIP5iS0eTS7
         hm9tuobkaTjgpFlDHrGAu5XPhFaW5r6jrMt02Lu20a2UlVGnLzciKHJzyy7Gasey0J6v
         TXWKdYllvVkkqrT5cDrg4q5ZYO7CA6l91mi/pG2a+RefNRq85ucl+c9UdwDa24oz1Hzk
         MFZg==
Received: by 10.180.109.166 with SMTP id ht6mr5446033wib.11.1346427053933;
 Fri, 31 Aug 2012 08:30:53 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 31 Aug 2012 08:30:53 -0700 (PDT)
In-Reply-To: <87mx1b3x3m.fsf@centaur.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204588>

On Fri, Aug 31, 2012 at 5:22 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> On Thu, Aug 30, 2012 at 7:23 PM, Carlos Mart=C3=ADn Nieto <cmn@elego=
=2Ede> wrote:
>>> behaviour. To work around this, introduce --set-upstream-to which
>>> accepts a compulsory argument indicating what the new upstream bran=
ch
>>> should be and one optinal argument indicating which branch to chang=
e,
>>> defaulting to HEAD.
>>>
>>
>> Could you please also add this new option to the
>> "contrib/completion/git-completion.bash"
>> script?
>
> If I knew how those things work... Is this enough?
>

Yes, Thanks.

>    cmn
>
> --8<--
> Subject: [PATCH] completion: add --set-upstream-to and --unset-upstre=
am
>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index ffedce7..4f46357 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -880,6 +880,7 @@ _git_branch ()
>                         --color --no-color --verbose --abbrev=3D --no=
-abbrev
>                         --track --no-track --contains --merged --no-m=
erged
>                         --set-upstream --edit-description --list
> +                       --unset-upstream --set-upstream-to=3D
>                         "
>                 ;;
>         *)
> --
> 1.7.12.3.g0dd8ef6
