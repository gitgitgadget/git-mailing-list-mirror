From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Re: [PATCH v2 3/3] Update po/ja.po
Date: Tue, 23 Jul 2013 23:40:25 +0900
Message-ID: <CAPM==HLi29bGXhOWdOg_pRc2Ks7ooXS-q8b05Lr8VnDknzKAoQ@mail.gmail.com>
References: <CAPM==HJ4pTrb5cp0gNNef3PDdk5Sae-aw0ADzsb7zOY4VjDMVA@mail.gmail.com>
	<7vsiz69qfh.fsf@alter.siamese.dyndns.org>
	<CAPM==H+_rpNojKjJe3-fJSXp0_8ishws=N7BsU7TJpfr2yG31A@mail.gmail.com>
	<7v7ggi9ned.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 16:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1dlP-0008Pu-Gp
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630Ab3GWOk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:40:28 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:53956 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434Ab3GWOk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:40:26 -0400
Received: by mail-vb0-f53.google.com with SMTP id p12so5487653vbe.40
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Rhp1gXC+/WILyicIAgj7ZEnXzjp36jkA3naeRjl16tE=;
        b=cvsFxyr4/Fu2l1h25MwEpHCSWQTjEd4HN25AHPZUV5++UAqcsXsnR2l7++gqeSkHup
         7Nfvdz2m8xtKWLITpCytVuxLHoHoJ5yMl9SbtyfN1eJOEsSkHA5kI0OrtKEIBKHloQ/u
         tFf1qnsownBsXgQB4vK7mv20EUAZQ9DsWai6ogvTvvgO1O9se7ri9kFEjYRUNQRAiqG5
         6X0zUTpKQSW80Xu0Q/j0cfLi3tJJAsAQIVOQhxDvJCyVJe3IsIpwOS6zmy9NIyDLS3QK
         FvISZXtiqZXrtAoNDdNDxGQysH2pgyFxK50ZXGXMQiJEv0XJ9rZUzvSR90HPpAbtKs4k
         Lq3g==
X-Received: by 10.58.234.161 with SMTP id uf1mr11393196vec.57.1374590425502;
 Tue, 23 Jul 2013 07:40:25 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Tue, 23 Jul 2013 07:40:25 -0700 (PDT)
In-Reply-To: <7v7ggi9ned.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231041>

I wanted the former translator as well as me to correct.
(Or I wanted you good at English to correct Japanese translation by your patch)
I was waiting for someone to have corrected Git-gui Japanese
translation for a long time.
However, nobody corrected.

This is only a translation file. It is not the patch which breaks a system.
Is it necessary to correct at once? Are you unable to correct after
merging this patch by another your patch?

My wish wants to only use Git-gui in honest Japanese. (I hate brainfuck)
you may reject this shoddy patch and you yourself may translate
perfectly, how is it?
I think whether you yourself had better translate. It seems to you
that all my translations are not pleasing.

>> -#: git-gui.sh:2893
>> +#: git-gui.sh:2983 git-gui.sh:3115
>> +msgid "Usage"
>> +msgstr "使用状況"
> Is this correct?  I am not familiar with the context this string
> appears, but shouldn't it be "使い方"?

It is a title of the error box which does not have seeing mostly.
Therefore, I do not understand.
However, If you wish, it can correct with you yourself another patch later.

>> -#: lib/choose_repository.tcl:490
>> +#: lib/choose_repository.tcl:489
>>  msgid "Target Directory:"
>> -msgstr "先ディレクトリ:"
>> +msgstr "保存ディレクトリ:"
> I think this is better translation than the original (the Target is
> about where the new clone appears), but a few lines above we see
> "Source Location", which may want to be reworded.  Perhaps
> クローン元リポジトリ
> クローン先リポジトリ
> ???

"保存ディレクトリ"(Save Directory) is better. "先ディレクトリ" is very bad. (A strange word.
It saw for the first time in life.) "クローン先リポジトリ" is also bad to me. It
is hard to see the difference of only one character.
However, If you wish, it can correct with you yourself another patch later.

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
>> +"あなたはdetached "
>> +"head状態でコミットしようとしています。これは危険な操作です。もし続行すれば、他ブランチへ切り替えた際に変更を失ったり、reflogで変更を復元することが困難になります。あなたは次の操作をするべきです。1.
>> "
> The line wrapping of this look somewhat fishy.  It technically is
> correct, but ending the line with an explicit \n and closing dq,
> i.e.
>         "あなたはdetached head状態...べきです。\n"
> would be more natural and less error prone.
>
> Also, the original says "potentially dangerous", but "potentially"
> is lost in translation.  I am not sure if the difference matters
> very much, but since I noticed it....
>
>> +"このコミットをキャンセルする。2. 新しいブランチを作り、コミットし直す。\n"
>
>Also, the original doesn't say "1. cancel this commit. 2. Create a
>new branch to recommit", and it is better without 1./2., which may
>be mistaken as if the user can do one of two things.
>
>> +"\n"
>> +"本当にこの危険なコミットを実行しますか？"
>
>The last sentence in the original only says "your Commit", without
>saying "Dangerous".
>
>In short, the translated text is far more alarming than the original
>phrasing.

Is free translation impossible? I do not understand what for whether
it is a problem.
However, If you wish, it can correct with you yourself another patch later.


>> -#: lib/option.tcl:132
>> +#: lib/option.tcl:134
>>  msgid "Global (All Repositories)"
>> -msgstr "大域（全てのリポジトリ）"
>> +msgstr "標準設定（全てのリポジトリ）"
>The translation reads "Standard", not "Global".  「全体設定」, perhaps?

"標準設定" (Default settings) is better. Or, "グローバル設定"(Global Settings) is
better than "全体設定"(All Settings).
However, If you wish, it can correct with you yourself another patch later.

>> -#: lib/option.tcl:142
>> +#: lib/option.tcl:144
>>  msgid "Merge Verbosity"
>> -msgstr "マージの冗長度"
>> +msgstr "マージのエラー出力レベル (0-5, 標準2、最高5)(merge.verbosity)"
>
> The original does not have 0-5, 2, nor 5.  Translation shouldn't add
> one.
>
> If it will help the users to add these, please first add them to the
> original so that users of all languages would benefit and then
> translate the result.

An English native's person thinks that he does not want to read the
English sentence written by Japanese me.
If you wish, it can correct with you yourself another patch later.

> -#: lib/option.tcl:143
> +#: lib/option.tcl:145
>  msgid "Show Diffstat After Merge"
> -msgstr "マージ後に diffstat を表示"
> +msgstr "マージ後に変更量のグラフを表示 (git diff --stat)"

Ditto.

> -#: lib/option.tcl:150
> +#: lib/option.tcl:153
>  msgid "Minimum Letters To Blame Copy On"
> -msgstr "コピーを検知する最少文字数"
> +msgstr "他ファイルから移動/コピーを検知する最少文字数 (標準値40)"

Ditto.
