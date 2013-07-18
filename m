From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Fwd: [PATCH 2/4] Update git-gui/po/ja.po (Git-gui Japanese)
Date: Fri, 19 Jul 2013 05:52:57 +0900
Message-ID: <CAPM==HK3F5pw0ZPLbRMQZBsW3DFn=JjFxqux9H5optostpjCiw@mail.gmail.com>
References: <CAPM==HJy65+LoJZ3A_DUuyq0LZhZQ_XpB0djMKbeSnY_PAUasw@mail.gmail.com>
	<7v4nbr3eqy.fsf@alter.siamese.dyndns.org>
	<CAPM==H+nSZLQ-VOE7WJkJYRcQfVLZsy7XbEeFvCyv=zwghJHzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 22:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvCB-0008TN-6b
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812Ab3GRUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:52:59 -0400
Received: from mail-vc0-f196.google.com ([209.85.220.196]:45986 "EHLO
	mail-vc0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381Ab3GRUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:52:58 -0400
Received: by mail-vc0-f196.google.com with SMTP id ha12so432885vcb.11
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=qmyN3jx5+7fbdZSj6MT6EJy+KZpBkyyc8hmYmG/gIuc=;
        b=dCUeaBHWVHzxjsswcsrnCr460z2vvac06PR3/548l7XZ9RzcJ9mvCM1R6/kB4eWKAA
         RsPo2i6xRYZw7CjFK/wlxTZ/hKMVoxdDU9S1x/JuVc811NQTUtde7JDfgWjDg/rI5yJs
         +bCSf84lgwac0xNkzdUDxE5PErl97vj3ij4GlETSf4sVQ/+OGJh8ms2lXCugJ/0MA+46
         WMbaUuIL6+5951rybQ+Is/UMJ1AFKT1STlJUokZkpR2z92msWt8ATKycQ5P3jq9TuRa8
         NhXZPemq3NdOAGXWKucfA517ma/esYMBwC+WpvY/Cy/1KGLQPc9fDTWwsVv2G4PNFy/A
         sfaw==
X-Received: by 10.58.34.69 with SMTP id x5mr4754352vei.11.1374180778003; Thu,
 18 Jul 2013 13:52:58 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Thu, 18 Jul 2013 13:52:57 -0700 (PDT)
In-Reply-To: <CAPM==H+nSZLQ-VOE7WJkJYRcQfVLZsy7XbEeFvCyv=zwghJHzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230744>

---------- Forwarded message ----------
From: Yamada Saburo <devil.tamachan@gmail.com>
Date: 2013/7/19
Subject: Re: [PATCH 2/4] Update git-gui/po/ja.po (Git-gui Japanese)
To: Junio C Hamano <gitster@pobox.com>


Hi Hamano,

> I suspect that is not a name
Real name.

>> +"Language: \n"
>What is this about????
I used QT Linguist for Win. This line append by QT Linguist.

> fuzzy & No translation??? x7
translated in Patch4/4.

Thanks

2013/7/19 Junio C Hamano <gitster@pobox.com>:
> 悪魔野玉茶無  <devil.tamachan@gmail.com> writes:
>
> I suspect that is not a name (and I somehow have suspicion that the
> S-o-b is not real, either), but if you send patches as somebody that
> does not match your sign-off, please add
>
>         From: Yamada Saburo <devil.tamachan@gmail.com>
>
> followed by a blank line at the very beginning of the e-mail body.
> That will override the e-mail From: line your MUA puts in your
> message and record the commit as authored by "Yamada Saburo".
>
>> Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
>> ---
>
> Thanks.
>
>>  git-gui/po/ja.po | 1066 +++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 583 insertions(+), 483 deletions(-)
>>
>> diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
>> index 9aff249..0bbe504 100644
>> --- a/git-gui/po/ja.po
>> +++ b/git-gui/po/ja.po
>> @@ -7,41 +7,42 @@ msgid ""
>>  msgstr ""
>>  "Project-Id-Version: git-gui\n"
>>  "Report-Msgid-Bugs-To: \n"
>> -"POT-Creation-Date: 2010-01-26 15:47-0800\n"
>> +"POT-Creation-Date: 2013-07-10 02:45+0900\n"
>>  "PO-Revision-Date: 2010-02-02 19:03+0900\n"
>>  "Last-Translator: しらいし ななこ <nanako3@lavabit.com>\n"
>
> 山田三郎 would be the last translater, no?
>
>>  "Language-Team: Japanese\n"
>> +"Language: \n"
>
> What is this about????
>
>>  "MIME-Version: 1.0\n"
>>  "Content-Type: text/plain; charset=UTF-8\n"
>>  "Content-Transfer-Encoding: 8bit\n"
>
>> -#: git-gui.sh:1921
>> +#: git-gui.sh:2088 git-gui.sh:2089
>> +#, fuzzy
>> +msgid "File type changed, old type staged for commit"
>> +msgstr "ファイル型変更、コミット未予定"
>
> If this is no longer fuzzy, please resolve it by removing "#, fuzzy"
> marker.
>
> Also, this translation seems to be incomplete.  It may be OK for
> some strings (e.g. "RegExp" that seems to be a label of a checkbox
> or something) to be the same as the original, but some others may
> need a bit more work.
>
> I wonder if there is a mechanism in *.po files to differentiate
> between "I looked at this entry and using the original string as the
> template is fine" and "I didn't translate this string, but it should
> be".  I think the following entries seem to fall into the latter
> category.
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
>
> No translation???
>
>> -#: lib/index.tcl:398
>> +#: lib/index.tcl:380
>> +#, tcl-format
>> +msgid "Stage %d untracked files?"
>> +msgstr ""
>
> No translation???
>
>> -#: lib/option.tcl:149
>> +#: lib/option.tcl:151
>> +msgid "Use Textconv For Diffs and Blames"
>> +msgstr ""
>
> No translation???
>
>> -#: lib/option.tcl:153
>> +#: lib/option.tcl:156
>> +msgid "Additional Diff Parameters"
>> +msgstr ""
>
> No translation???
>
>> +#: lib/option.tcl:160
>> +msgid "Warn before committing to a detached head"
>> +msgstr ""
>
> No translation???
>
>> +#: lib/option.tcl:161
>> +msgid "Staging of untracked files"
>> +msgstr ""
>
> No translation???
>
>> +#: lib/transport.tcl:25
>> +msgid "fetch all remotes"
>> +msgstr ""
>
> No translation???
