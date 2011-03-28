From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH] Fix two unused variable warnings in gcc 4.6
Date: Mon, 28 Mar 2011 08:57:54 -0500
Message-ID: <AANLkTinUVnBxtp8-_QMh0m-DuqK4mK1=vof_avuV4XFU@mail.gmail.com>
References: <1301275939-17018-1-git-send-email-dpmcgee@gmail.com>
	<92140045-86C2-4525-A867-7654D3FE53FB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 15:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Cy1-0003pT-O8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 15:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab1C1N6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 09:58:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42690 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab1C1N6k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 09:58:40 -0400
Received: by fxm17 with SMTP id 17so2663067fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JRsIznWqJpDDIhXN4S5e5k8RJeh6ksCSkPtwpep2N/U=;
        b=dMipFU196vqPtj+XJKZ2tUe8jZTyUPoNpQRHGQmSlDweUHE3f04G680Mxl3OoMchrZ
         KjeukEvBvxcch1SoyaqqyYDZnAq+YLEKOQIvfVQnthk6mC1GjRpXw1xvbXy4bUB2+mPc
         FypW5TOVOUS8TeqnqfLU/MTcQ80eVUSty5Xow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N5SssPxChpBl+DyBFSZDiphXhosT0qScxD6U+YRsfbYuaxilo/qnnMgv5xjaXvLKkg
         nS1jALAeVAGIEIXsieA4YEma6e2o/39eWDKUrozexwH/Jo7En+Z9gryaMPT6lJWUqrB2
         zhGFbljA2k1/bBdJBzNwkHTVkAb9M+vEg1paM=
Received: by 10.223.1.136 with SMTP id 8mr4431924faf.0.1301320674055; Mon, 28
 Mar 2011 06:57:54 -0700 (PDT)
Received: by 10.223.107.82 with HTTP; Mon, 28 Mar 2011 06:57:54 -0700 (PDT)
In-Reply-To: <92140045-86C2-4525-A867-7654D3FE53FB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170128>

On Mon, Mar 28, 2011 at 8:05 AM, Joshua Juran <jjuran@gmail.com> wrote:
> On Mar 27, 2011, at 6:32 PM, Dan McGee wrote:
>
>> diff --git a/http-fetch.c b/http-fetch.c
>> index 923904f..3af4c71 100644
>> --- a/http-fetch.c
>> +++ b/http-fetch.c
>> @@ -8,7 +8,6 @@ static const char http_fetch_usage[] =3D "git http-f=
etch "
>>
>> int main(int argc, const char **argv)
>> {
>> - =C2=A0 =C2=A0 =C2=A0 const char *prefix;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct walker *walker;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int commits_on_stdin =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int commits;
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 8e82a8b..af13150 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -356,7 +356,6 @@ static void
>> make_room_for_directories_of_df_conflicts(struct merge_options *o,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *last_file =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int last_len =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0 struct stage_data *last_e;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < entries->nr; i++) {
>> @@ -961,7 +959,6 @@ static int process_renames(struct merge_options =
*o,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0, j =3D 0; i < a_renames->nr =
|| j < b_renames->nr;) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *src;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct string=
_list *renames1, *renames2Dst;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rename=
 *ren1 =3D NULL, *ren2 =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *b=
ranch1, *branch2;
>
> Looks like three unused variables, not two.

You are correct, my lack of caffeine can be blamed for the misleading
message. I didn't think it was important enough to resubmit for that
though.

-Dan
