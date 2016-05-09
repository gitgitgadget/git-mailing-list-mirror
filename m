From: demerphq <demerphq@gmail.com>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 08:30:51 +0200
Message-ID: <CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 08:32:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azeiX-0006ap-FE
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 08:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbcEIGax convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 02:30:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35070 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbcEIGax convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 02:30:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id e201so19029039wme.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=PqDallsoDBkDALiFUiNxtBNQexYj+X0XTcqSj49XfTo=;
        b=EcP/0XwenM9S5poA5DGBq7BjYoLqYuBrN1lTATW2OwdYNWXNsPnLqWUqDxWfpapvKO
         XsQlg3TCW25YZcmy6lQvOtEFFxmoCjUp8sDxPcePcD0LH3sa2FE9Lr0hL+HcwedMQHlD
         /n22OdBqvoXOP6jWMVRAxQqXoavvp4kqNT9/IzvEYNlwPJDXcREjoF7H2ufNshDKCSxb
         2+7DLWSq9R294BmxUVsqdS/e9H42OcbVJXvamAzTxngAAZ4/tzBkdKnfEWKTeOZUfte5
         mw0Pj7ZQtu3y9k2oO5D4C77ursL7791HHcgAFlrWAAniG1bas5sN1xPJGmBlbz/SdMGf
         XdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=PqDallsoDBkDALiFUiNxtBNQexYj+X0XTcqSj49XfTo=;
        b=GTQCInITR4+wlVJjV1Ve7FoUX++8zCCQsYtNIWvKV7CF/5yfaq4hV0l+Lrvqn/ZPps
         7xn//Bwy8AYPVx1OxKaCRQwzp4TBxaZ+FvGlJnGHdE7nhzlLJXgfJYc5457riP8fDmUj
         Rme4JA2J0IDWZYpM9qq3NJKlhKhQ2QhR/DVWawjHKufjhoORBqYl1HOcvqmN4AbLYGZt
         D1MlgWnsKmlRSBnKZxJCBp8dyf0m9wuMD7E2MZlYi/QTvUYyCrp7nfTFwaH7JKzXmrOq
         xm3PNs6WXgcNB0clhKUFiqvuRprphuLiLYAd3CiQZEaupp3m8pNgZ2DBRSjUd4xBHXix
         O3DQ==
X-Gm-Message-State: AOPr4FUWnEAaFO1JvCazHDlRKriIPgvhK/1BPlV4nqXfJAvo90gIhSND8NNPegqed7cfaxcYoL9gI6mxmu4t4w==
X-Received: by 10.28.154.73 with SMTP id c70mr9720013wme.12.1462775452007;
 Sun, 08 May 2016 23:30:52 -0700 (PDT)
Received: by 10.194.26.232 with HTTP; Sun, 8 May 2016 23:30:51 -0700 (PDT)
In-Reply-To: <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293988>

On 8 May 2016 at 20:20, Junio C Hamano <gitster@pobox.com> wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> May a  simple
>>  printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n"
>>
>> be an option ?
>
> If you were to do that, at least have the decency to make it more
> readable by doing something like:
>
>         printf "%s\n" 1 2 3 4 5 6 7 8 9 10
>
> ;-)
>
> But as I said, as a response to "t6044 broken on pu" bug report,
> s/seq/test_seq/ is the only sensible change.
>
> Improving "test_seq, the alternative to seq" is a separate topic.
>
> If you have aversion to $PERL, perhaps do them without using
> anything what is not expected to be built-in in modern shells,
> perhaps like this?
>
>  t/test-lib-functions.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8d99eb3..4edddac 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -739,7 +739,12 @@ test_seq () {
>         2)      ;;
>         *)      error "bug in the test script: not 1 or 2 parameters =
to test_seq" ;;
>         esac
> -       perl -le 'print for $ARGV[0]..$ARGV[1]' -- "$@"
> +       test_seq_counter__=3D$1
> +       while test "$test_seq_counter__" -le $2
> +       do
> +               echo "$test_seq_counter__"
> +               test_seq_counter__=3D$((test_seq_counter__ + 1))
> +       done
>  }

Is that perl snippet ever called with non-numeric output?

perl -le 'print for $ARGV[0]..$ARGV[1]' -- A E
A
B
C
D
E

Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
