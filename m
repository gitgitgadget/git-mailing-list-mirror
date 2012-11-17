From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Sat, 17 Nov 2012 19:01:23 +0100
Message-ID: <CAMP44s30wYnkQdq8yup3z-t=FEf1R+k8OC-o7-uY=19z9VHDPg@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
	<CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
	<CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
	<20121116204017.GX12052@goldbirke>
	<7vr4ntkzy4.fsf@alter.siamese.dyndns.org>
	<CAMP44s0y3UPVT+ndELaKNsWXAPG3kv-Xq_Wf6ONDF3Z99A5zMQ@mail.gmail.com>
	<CAFj1UpFbuHVhPOQVB9-sPjW2aBN=H+OUyYnz00qASZ5ssbwmGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 19:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZmiB-0004lT-1E
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 19:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab2KQSBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 13:01:25 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61084 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2KQSBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 13:01:24 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3754932obb.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=75wz4TwGLy74VQkScEido2VZlsxClaoELoTEVdrxojk=;
        b=EidknxwUFVlj09nKAOEDPeulvt0MGUTZK4hcWognKogGinH+rPJ7DBiEQdHDGyqH+x
         pXHpi+8g9EjjPQRL7azsb8Ffibi51qsMsalWOwVmmQ25XNb8DYO5JcTkHvt/hXdH5ZZH
         kSWlXXAAZGen1UhB8dpl69u5uCaku0VK/OH51EpPId9ESqccS7Qz6GYhq766ycFb7She
         EQ2rzoUDK+ZPh2PEYNGR6W4kRTvpd+t1KYqDGh6/00dFU9jaLDfFkSKbRctZmVwnRTw4
         YtLEe/2oYqhMmp7kbJ1III2gitpJBCpyCc/sgXC2jQyBijJ8NjKfgBfP+xq0WIcEyT9j
         OBjQ==
Received: by 10.182.52.105 with SMTP id s9mr6861523obo.25.1353175283840; Sat,
 17 Nov 2012 10:01:23 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 10:01:23 -0800 (PST)
In-Reply-To: <CAFj1UpFbuHVhPOQVB9-sPjW2aBN=H+OUyYnz00qASZ5ssbwmGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209966>

On Sat, Nov 17, 2012 at 6:15 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 4:56 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Nov 16, 2012 at 10:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> The point is not about the quality of zsh's emulation
>>> of (k)sh when it is run under that mode, but is about not having to
>>> have that logic in bash-only part in the first place.
>>
>> As I said, that logic can be moved away _if_ my wrapper is merged. But
>> then again, that would cause regressions to existing users.
>
> Please forgive me as I don't know the background of the efforts for
> zsh git-completion or
> the syntax for zsh completion, but I thought I'd mention another
> approach I tried for tcsh
> which may work for zsh.
>
> I gather that using a wrapper for zsh causes concerns about
> backwards-compatibility.

I don't see any concerns.

> if [[ -n ${ZSH_VERSION-} ]]; then
>   # replace below by zsh completion commands calling `bash
> ${HOME}/.git-completion.bash`

>   complete git   'p/*/`bash ${HOME}/.git-completion.bash ${COMMAND_LINE}`/'
>   complete gitk 'p/*/`bash ${HOME}/.git-completion.bash ${COMMAND_LINE}`/'

That doesn't work in zsh. It might be possible to do something
similar, but it would probably require many more lines.

And we can achieve the same by essentially moving the relevant code of
my wrapper:

--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -23,10 +23,6 @@
 #    3) Consider changing your PS1 to also show the current branch,
 #       see git-prompt.sh for details.

-if [[ -n ${ZSH_VERSION-} ]]; then
-       autoload -U +X bashcompinit && bashcompinit
-fi
-
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
@@ -2404,6 +2400,32 @@ __gitk_main ()
        __git_complete_revlist
 }

+if [[ -n ${ZSH_VERSION-} ]]; then
+       emulate -L zsh
+
+       __gitcompadd ()
+       {
+               compadd -Q -S "$4" -P "${(M)cur#*[=:]}" -p "$2" --
${=1} && _ret=0
+       }
+
+       _git ()
+       {
+               local _ret=1
+               () {
+                 emulate -L ksh
+                       local cur cword prev
+                       cur=${words[CURRENT-1]}
+                       prev=${words[CURRENT-2]}
+                       let cword=CURRENT-1
+                       __${service}_main
+               }
+               let _ret && _default -S '' && _ret=0
+               return _ret
+       }
+       compdef _git git gitk
+       return
+fi
+
 __git_func_wrap ()
 {
        if [[ -n ${ZSH_VERSION-} ]]; then

-- 
Felipe Contreras
