From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] misc-sh: fix up whitespace in some other .sh files.
Date: Sat, 6 Aug 2011 13:33:48 +1000
Message-ID: <CAH3Anroe0b8ebg80S_Hx-QEm7Ho0Lo+x+fRYwX_ejeMyFpDfNQ@mail.gmail.com>
References: <1312551089-3753-1-git-send-email-jon.seymour@gmail.com>
	<7vmxfn3h2v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 05:34:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpXeD-0007R4-Lh
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 05:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab1HFDdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 23:33:50 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57477 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1HFDdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 23:33:49 -0400
Received: by vws1 with SMTP id 1so2330824vws.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 20:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kNUcVKzgkYKdQIYrkBlPMUskAiWcrMVJqZ5phQHufGk=;
        b=obMXW09mWtji9/kLPhz1Dq/9ZnDxtQ2OAAWZs1iSxa/ZGR86KYf7Gt83k0M0nYHzU+
         apNMqllJtsGvoqH4yTyzcmJYugld8S2DPlV9/D72oxz/Ercjba5ZQoIytuGMVkPAI1Ur
         a+2DAkhkWC/l1cWLoEl+0cP3RPpdHfUPz1gYw=
Received: by 10.52.66.226 with SMTP id i2mr3105540vdt.268.1312601628262; Fri,
 05 Aug 2011 20:33:48 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Fri, 5 Aug 2011 20:33:48 -0700 (PDT)
In-Reply-To: <7vmxfn3h2v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178821>

On Sat, Aug 6, 2011 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index 962a93b..0d399aa 100755
>> --- a/git-filter-branch.sh
>> +++ b/git-filter-branch.sh
>> @@ -98,11 +98,11 @@ set_ident () {
>> =C2=A0}
>>
>> =C2=A0USAGE=3D"[--env-filter <command>] [--tree-filter <command>]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--index-filter <command>=
] [--parent-filter <command>]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--msg-filter <command>] =
[--commit-filter <command>]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--tag-name-filter <comma=
nd>] [--subdirectory-filter <directory>]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--original <namespace>] =
[-d <directory>] [-f | --force]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[<rev-list options>...]"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--index-filter <command>] [--parent-f=
ilter <command>]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--msg-filter <command>] [--commit-fil=
ter <command>]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--tag-name-filter <command>] [--subdi=
rectory-filter <directory>]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--original <namespace>] [-d <director=
y>] [-f | --force]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 [<rev-list options>...]"
>>
>> =C2=A0OPTIONS_SPEC=3D
>> =C2=A0. git-sh-setup
>
> Everything other than this hunk is unquestionably fine. I think this =
one
> also is Ok but I wonder where the "Indented by 12 columns" comes
> from. "Usage: git filter-branch " that is prefixed to the first line =
is 25
> columns long, so the "[--index-filter ..." on the second line would n=
ot
> align with "[--env-filter ..." on the first line to begin with.
>
> And I do not think they need to align --- the point is if the second =
and
> subsequent lines do not aim to align with anything on the first line,=
 it
> is just fine to indent them with a single HT, I think
>

I double checked the actual output (e.g. with git filter-branch --X) an=
d
on the screen the output looks identical, although there is still white=
space
difference. So, I think it is ok.

jon.
