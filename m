From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Update the usage bundle string.
Date: Thu, 17 Sep 2009 13:16:25 -0300
Message-ID: <a4c8a6d00909170916u6ba05e36u3b65cc6d9bd726fd@mail.gmail.com>
References: <1253136011-12011-1-git-send-email-tfransosi@gmail.com>
	 <4AB1D364.1080701@viscovery.net> <vpqbpl9woac.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoJfN-0002bS-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 18:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339AbZIQQQX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758318AbZIQQQX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 12:16:23 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:22744 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758311AbZIQQQW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 12:16:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so666548and.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A3qutfxMIwes1nqnMoMMwIDQaXUOG730JdtWxo08YsE=;
        b=gJypQvO2Oc/QnaxxfHKUciYgTwqGfAmhfKXtkS4lW61zd++/TNyoxfWGTi1UfVOY0w
         ZIO6iTGFyNIGZi+fgY54L7rBI89A27ke+8eGCVUO9vwpL/hlwmD04vB2CrlsZS9DXwj1
         n+nj1Si5LoUGOli97HTXA6h2iEu1O5aUyhOsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E7aE2aKCkvUR/4B4TKADrelridNVbeoRVXb9Fr5R7WslwFgS7W660+N6ALAiEJFW6T
         YLz0fcRcgX1w4otkWe3sUJNjMyHnPlvnfUw9qogZkt6xlFAM2RLB2C1N9uYzzQrLQ61g
         XATv8899ch/82wEd5ylZ0N2dAChXFC/LIRrdY=
Received: by 10.101.63.20 with SMTP id q20mr251532ank.171.1253204185878; Thu, 
	17 Sep 2009 09:16:25 -0700 (PDT)
In-Reply-To: <vpqbpl9woac.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128763>

On Thu, Sep 17, 2009 at 1:04 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Thiago Farina schrieb:
>>
>>> +static const char builtin_bundle_usage[] =3D "\
>>> + =A0git bundle create <file> <git-rev-list args>\n\
>>> + =A0git bundle verify <file>\n\
>>> + =A0git bundle list-heads <file> [refname...]\n\
>>> + =A0git bundle unbundle <file> [refname...]";
>>
>> You indent the usage text. Do other commands do that, too? If you re=
send,
>> it may be worth using this style:
>>
>> static const char builtin_bundle_usage[] =3D
>> =A0 =A0 =A0 "git bundle create <file> <git-rev-list args>\n"
>> =A0 =A0 =A0 "git bundle verify <file>\n"
>
> I like aligned usage strings, like:
>
> $ git stash -h
> Usage: git stash list [<options>]
> =A0 or: git stash show [<stash>]
> =A0 or: git stash drop [-q|--quiet] [<stash>]
> =A0 or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
> =A0 or: git stash branch <branchname> [<stash>]
> =A0 or: git stash [save [-k|--keep-index] [-q|--quiet] [<message>]]
> =A0 or: git stash clear
>
> or
>
> $ git branch -h |& head -n 4
> usage: git branch [options] [-r | -a] [--merged | --no-merged]
> =A0 or: git branch [options] [-l] [-f] <branchname> [<start-point>]
> =A0 or: git branch [options] [-r] (-d | -D) <branchname>
> =A0 or: git branch [options] (-m | -M) [<oldbranch>] <newbranch>
>
I like and prefer this style too. I can use it in my patch, like:
$ git bundle -h
usage: git bundle create <file> <git-rev-list args>
  or: git bundle verify <file>
  or: git bundle list-heads <file> [refname...]
  or: git bundle unbundle <file> [refname...]

instead of:
usage: git bundle create <file> <git-rev-list args>
          git bundle verify <file>
          git bundle list-heads <file> [refname...]
          git bundle unbundle <file> [refname...]

> but Git isn't very consistant here:
>
> $ git bisect -h |& head =A0-n 6
> Usage: git bisect [help|start|bad|good|skip|next|reset|visualize|repl=
ay|log|run]
>
> git bisect help
> =A0 =A0 =A0 =A0print this long help message.
> git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
> =A0 =A0 =A0 =A0reset bisect state and start bisection.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
