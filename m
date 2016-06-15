From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Mon, 22 Jul 2013 15:32:18 -0700
Message-ID: <7vsiz69qfh.fsf@alter.siamese.dyndns.org>
References: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Yamada Saburo <devil.tamachan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1OeY-0006tO-08
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab3GVWcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:32:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427Ab3GVWcV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:32:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B04627148;
	Mon, 22 Jul 2013 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=RVsLPaXoVdtjtuwjEZnf7v1MGME=; b=owQEENLhIkQBgfGE2Nu+
	+iwh9ZjdhzYC7gJQKEULS9pXb5wEbDiQ5wAlnGUMn7K7pNm7iHlKB4HaByvs8C8/
	uQ1di9aWc2g/GF1R5W2XrEwtSXDdgkPsr6VtcLdPXwfh341QuDFLYW1CEH4EjZNo
	L9GCLmfHh5rtxtW5svDpGNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rCrvIE8mYtS8g9VB0u4rx5a7Ew6HJ5TdkUig9WFAC2TBEN
	pIsAaVuDgJ8i9pA8/f2xg+LrQwa+IgKPof9bEX0QR6coXKSxR/4pq2KwfvjgPHov
	wcZZy3/2U2oDCVkUxeeLGk6unCsB0xPR9eeJlZ3sj0ttla9fRWbhdWjSbboBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 227BA27147;
	Mon, 22 Jul 2013 22:32:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46B9E27146;
	Mon, 22 Jul 2013 22:32:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92434832-F31E-11E2-B31C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231006>

Yamada Saburo <devil.tamachan@gmail.com> writes:

> -#: git-gui.sh:2893
> +#: git-gui.sh:2983 git-gui.sh:3115
> +msgid "Usage"
> +msgstr "$B;HMQ>u67(B"

Is this correct?  I am not familiar with the context this string
appears, but shouldn't it be "$B;H$$J}(B"?

> -#: lib/choose_repository.tcl:479
> +#: lib/choose_repository.tcl:480
>  msgid "Source Location:"
>  msgstr "$B%=!<%9$N0LCV(B"
>
> -#: lib/choose_repository.tcl:490
> +#: lib/choose_repository.tcl:489
>  msgid "Target Directory:"
> -msgstr "$B@h%G%#%l%/%H%j(B:"
> +msgstr "$BJ]B8%G%#%l%/%H%j(B:"

I think this is better translation than the original (the Target is
about where the new clone appears), but a few lines above we see
"Source Location", which may want to be reworded.  Perhaps

    $B%/%m!<%s85%j%]%8%H%j(B
    $B%/%m!<%s@h%j%]%8%H%j(B

???

> -#: lib/commit.tcl:272
> +#: lib/commit.tcl:269
> +msgid ""
> +"You are about to commit on a detached head. This is a potentially dangerous "
> +"thing to do because if you switch to another branch you will lose your "
> +"changes and it can be difficult to retrieve them later from the reflog. You "
> +"should probably cancel this commit and create a new branch to continue.\n"
> +" \n"
> +" Do you really want to proceed with your Commit?"
> +msgstr ""
> +"$B$"$J$?$O(Bdetached "
> +"head$B>uBV$G%3%_%C%H$7$h$&$H$7$F$$$^$9!#$3$l$O4m81$JA`:n$G$9!#$b$7B39T$9$l$P!"B>%V%i%s%A$X@Z$jBX$($?:]$KJQ99$r<:$C$?$j!"(Breflog$B$GJQ99$rI|85$9$k$3$H$,:$Fq$K$J$j$^$9!#$"$J$?$O<!$NA`:n$r$9$k$Y$-$G$9!#(B1.
> "

The line wrapping of this look somewhat fishy.  It technically is
correct, but ending the line with an explicit \n and closing dq,
i.e.

	"$B$"$J$?$O(Bdetached head$B>uBV(B...$B$Y$-$G$9!#(B\n"

would be more natural and less error prone.

Also, the original says "potentially dangerous", but "potentially"
is lost in translation.  I am not sure if the difference matters
very much, but since I noticed it....

> +"$B$3$N%3%_%C%H$r%-%c%s%;%k$9$k!#(B2. $B?7$7$$%V%i%s%A$r:n$j!"%3%_%C%H$7D>$9!#(B\n"

Also, the original doesn't say "1. cancel this commit. 2. Create a
new branch to recommit", and it is better without 1./2., which may
be mistaken as if the user can do one of two things.

> +"\n"
> +"$BK\Ev$K$3$N4m81$J%3%_%C%H$r<B9T$7$^$9$+!)(B"

The last sentence in the original only says "your Commit", without
saying "Dangerous".

In short, the translated text is far more alarming than the original
phrasing.

> -#: lib/option.tcl:132
> +#: lib/option.tcl:134
>  msgid "Global (All Repositories)"
> -msgstr "$BBg0h!JA4$F$N%j%]%8%H%j!K(B"
> +msgstr "$BI8=`@_Dj!JA4$F$N%j%]%8%H%j!K(B"

The translation reads "Standard", not "Global".  $B!VA4BN@_Dj!W(B, perhaps?

> -#: lib/option.tcl:142
> +#: lib/option.tcl:144
>  msgid "Merge Verbosity"
> -msgstr "$B%^!<%8$N>iD9EY(B"
> +msgstr "$B%^!<%8$N%(%i!<=PNO%l%Y%k(B (0-5, $BI8=`(B2$B!":G9b(B5)(merge.verbosity)"

The original does not have 0-5, 2, nor 5.  Translation shouldn't add
one.

If it will help the users to add these, please first add them to the
original so that users of all languages would benefit and then
translate the result.

> -#: lib/option.tcl:143
> +#: lib/option.tcl:145
>  msgid "Show Diffstat After Merge"
> -msgstr "$B%^!<%88e$K(B diffstat $B$rI=<((B"
> +msgstr "$B%^!<%88e$KJQ99NL$N%0%i%U$rI=<((B (git diff --stat)"

Ditto.

> -#: lib/option.tcl:150
> +#: lib/option.tcl:153
>  msgid "Minimum Letters To Blame Copy On"
> -msgstr "$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B"
> +msgstr "$BB>%U%!%$%k$+$i0\F0(B/$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B ($BI8=`CM(B40)"

Ditto.

Pat, this patch is not quite ready.

Thanks.
