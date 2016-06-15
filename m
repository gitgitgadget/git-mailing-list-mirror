From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Tue, 23 Jul 2013 07:58:33 +0900
Message-ID: <CAPM==H+_rpNojKjJe3-fJSXp0_8ishws=N7BsU7TJpfr2yG31A@mail.gmail.com>
References: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
	<7vsiz69qfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1P3v-0005T1-J5
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3GVW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:58:35 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:39762 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3GVW6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:58:35 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha12so5232280vcb.35
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Jjw95Fo4CTHh8/ZTw/f7CVtAwBdjmFDLgLUgZVp3tBg=;
        b=OjOyH/fxsPU8OeCyW1ex/LopRDTeMdPPbct3dnICwdqCoqA+Fq+flszURt6svjQMLQ
         GeYd/Ppff9rwAWwgrHS7rxkhQQjMD7YYHIKwuSpNdA+OIs9uHULSz275XSqI0whlFDXZ
         IV/gn6t45CtSrTiS53A+h5aJ2RlUlKOrG1MFkrgzzI+ymSlXW3B/2+JRN3kUTO18lEEz
         Bd4yfpIWglHY0xBebH33qGiSKNxi9GOtwAiWUqEeUMsDJFQc6oweXRuDcYNmvRCuOFYV
         VY2zInfjTJgn7Q8sxpUMcTAi08gNu1SxetzwGXTma6EiqpzKO4Wu8nQWmEwo08umcGHD
         uv5A==
X-Received: by 10.220.42.84 with SMTP id r20mr9987473vce.87.1374533913958;
 Mon, 22 Jul 2013 15:58:33 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Mon, 22 Jul 2013 15:58:33 -0700 (PDT)
In-Reply-To: <7vsiz69qfh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231008>

Is free translation impossible? I want to give priority to ease of use.
Does Mr. Hamano know that it is said that Japanese translation of
Git-gui is very unclear? It is wonderful that my translation is
severely examined so far by me compared with a former translator.

Compiled .msg file so that it can try easily was uploaded.
https://docs.google.com/file/d/0B7h5NcRw8uVCSHMyVnFzQzJaZFU/edit?usp=sharing

2013/7/23 Junio C Hamano <gitster@pobox.com>:
> Yamada Saburo <devil.tamachan@gmail.com> writes:
>
>> -#: git-gui.sh:2893
>> +#: git-gui.sh:2983 git-gui.sh:3115
>> +msgid "Usage"
>> +msgstr "$B;HMQ>u67(B"
>
> Is this correct?  I am not familiar with the context this string
> appears, but shouldn't it be "$B;H$$J}(B"?
>
>> -#: lib/choose_repository.tcl:479
>> +#: lib/choose_repository.tcl:480
>>  msgid "Source Location:"
>>  msgstr "$B%=!<%9$N0LCV(B"
>>
>> -#: lib/choose_repository.tcl:490
>> +#: lib/choose_repository.tcl:489
>>  msgid "Target Directory:"
>> -msgstr "$B@h%G%#%l%/%H%j(B:"
>> +msgstr "$BJ]B8%G%#%l%/%H%j(B:"
>
> I think this is better translation than the original (the Target is
> about where the new clone appears), but a few lines above we see
> "Source Location", which may want to be reworded.  Perhaps
>
>     $B%/%m!<%s85%j%]%8%H%j(B
>     $B%/%m!<%s@h%j%]%8%H%j(B
>
> ???
>
>> -#: lib/commit.tcl:272
>> +#: lib/commit.tcl:269
>> +msgid ""
>> +"You are about to commit on a detached head. This is a potentially dangerous "
>> +"thing to do because if you switch to another branch you will lose your "
>> +"changes and it can be difficult to retrieve them later from the reflog. You "
>> +"should probably cancel this commit and create a new branch to continue.\n"
>> +" \n"
>> +" Do you really want to proceed with your Commit?"
>> +msgstr ""
>> +"$B$"$J$?$O(Bdetached "
>> +"head$B>uBV$G%3%_%C%H$7$h$&$H$7$F$$$^$9!#$3$l$O4m81$JA`:n$G$9!#$b$7B39T$9$l$P!"B>%V%i%s%A$X@Z$jBX$($?:]$KJQ99$r<:$C$?$j!"(Breflog$B$GJQ99$rI|85$9$k$3$H$,:$Fq$K$J$j$^$9!#$"$J$?$O<!$NA`:n$r$9$k$Y$-$G$9!#(B1.
>> "
>
> The line wrapping of this look somewhat fishy.  It technically is
> correct, but ending the line with an explicit \n and closing dq,
> i.e.
>
>         "$B$"$J$?$O(Bdetached head$B>uBV(B...$B$Y$-$G$9!#(B\n"
>
> would be more natural and less error prone.
>
> Also, the original says "potentially dangerous", but "potentially"
> is lost in translation.  I am not sure if the difference matters
> very much, but since I noticed it....
>
>> +"$B$3$N%3%_%C%H$r%-%c%s%;%k$9$k!#(B2. $B?7$7$$%V%i%s%A$r:n$j!"%3%_%C%H$7D>$9!#(B\n"
>
> Also, the original doesn't say "1. cancel this commit. 2. Create a
> new branch to recommit", and it is better without 1./2., which may
> be mistaken as if the user can do one of two things.
>
>> +"\n"
>> +"$BK\Ev$K$3$N4m81$J%3%_%C%H$r<B9T$7$^$9$+!)(B"
>
> The last sentence in the original only says "your Commit", without
> saying "Dangerous".
>
> In short, the translated text is far more alarming than the original
> phrasing.
>
>> -#: lib/option.tcl:132
>> +#: lib/option.tcl:134
>>  msgid "Global (All Repositories)"
>> -msgstr "$BBg0h!JA4$F$N%j%]%8%H%j!K(B"
>> +msgstr "$BI8=`@_Dj!JA4$F$N%j%]%8%H%j!K(B"
>
> The translation reads "Standard", not "Global".  $B!VA4BN@_Dj!W(B, perhaps?
>
>> -#: lib/option.tcl:142
>> +#: lib/option.tcl:144
>>  msgid "Merge Verbosity"
>> -msgstr "$B%^!<%8$N>iD9EY(B"
>> +msgstr "$B%^!<%8$N%(%i!<=PNO%l%Y%k(B (0-5, $BI8=`(B2$B!":G9b(B5)(merge.verbosity)"
>
> The original does not have 0-5, 2, nor 5.  Translation shouldn't add
> one.
>
> If it will help the users to add these, please first add them to the
> original so that users of all languages would benefit and then
> translate the result.
>
>> -#: lib/option.tcl:143
>> +#: lib/option.tcl:145
>>  msgid "Show Diffstat After Merge"
>> -msgstr "$B%^!<%88e$K(B diffstat $B$rI=<((B"
>> +msgstr "$B%^!<%88e$KJQ99NL$N%0%i%U$rI=<((B (git diff --stat)"
>
> Ditto.
>
>> -#: lib/option.tcl:150
>> +#: lib/option.tcl:153
>>  msgid "Minimum Letters To Blame Copy On"
>> -msgstr "$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B"
>> +msgstr "$BB>%U%!%$%k$+$i0\F0(B/$B%3%T!<$r8!CN$9$k:G>/J8;z?t(B ($BI8=`CM(B40)"
>
> Ditto.
>
> Pat, this patch is not quite ready.
>
> Thanks.
