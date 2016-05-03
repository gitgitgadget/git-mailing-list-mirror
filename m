From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation: fix linkgit references
Date: Tue, 3 May 2016 10:30:09 +0200
Message-ID: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com> <1462220405-12408-1-git-send-email-larsxschneider@gmail.com> <1462220405-12408-2-git-send-email-larsxschneider@gmail.com> <20160502203445.GA19509@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 10:30:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axVim-0005c5-PR
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbcECIaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 04:30:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32835 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcECIaM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 04:30:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so2448953wme.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ji2p96gNjYKsU05+67YCLAB+4UTXLlVcdU/9c+jhQ8Q=;
        b=cTIjV3YaGWViO7u6eOKaBxmLMkSe5JRBJlpTjmc+Ms79rzZrst6oZ3es20buIOCYbc
         rMR13QXlojwHTwB8+0sfONx7LtoW5RjVeA5s0qKcAi2t8IFKZawoLNhsKS6QJGrikKyY
         65eMcqhKsJjisjcAUQmWZJLq0ze7oRuPwNMVpG31me6hHr61eKC+6TboBoVuKsbg8tYi
         MsfPts+VJfQW4KhPJAnH3byWXXluy7xqtDdk4fJptzS9Z0stFmKmCqHVupN7PgbEWjeV
         eQiQmbpS0CW7BxntS/w8HI86vGS1fmTemHkS8lvwNks0GYHfuukQOuChsXnVb/PI0xHj
         Eq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ji2p96gNjYKsU05+67YCLAB+4UTXLlVcdU/9c+jhQ8Q=;
        b=BO8+vX352mW4VEQF4SL0dN+/9TRJ8y3cCQgE9L2la2viv99UCDyNnmYl+w7v4mQyUs
         JE54aNOZBTdEXkD/XUV94pwTI7EySycdUpNBDsQm5vgqIsQ1KhW0tif25BnbhpaY8W0z
         7aXMxZqCakc9fWp3Zyws9xye7aShQj0O9LL76zy2H3gm4z4kg6t3oP1bRxeKrAMR6Luo
         NjtHs2RRKdk/hwYQ4cP370dWfXvp4j5WfVEFZJwCfDrR9ET6p9HP+iUKIsWTMZ6WQI7o
         +c8xsriWdqaprdHvEplM3hOiXb/A1FU8lnVb/hwszVv8HNm0+5aXgqVWeTHfSdhIXiij
         7H1w==
X-Gm-Message-State: AOPr4FXQhSdtxmwLp05MxN2PecBXzHI6VL+47eLFnVhoq+ueTmfzNSBbl3X6krGGpT7nVA==
X-Received: by 10.28.230.137 with SMTP id e9mr23477878wmi.90.1462264211057;
        Tue, 03 May 2016 01:30:11 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB77BE.dip0.t-ipconnect.de. [93.219.119.190])
        by smtp.gmail.com with ESMTPSA id v143sm23174306wmv.4.2016.05.03.01.30.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 May 2016 01:30:10 -0700 (PDT)
In-Reply-To: <20160502203445.GA19509@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293333>


On 02 May 2016, at 22:34, Jeff King <peff@peff.net> wrote:

> On Mon, May 02, 2016 at 10:20:04PM +0200, larsxschneider@gmail.com wr=
ote:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>=20
> Fix how? Your commit message doesn't say why this is a good idea. Sin=
ce
> this is v3, I'm guessing that reasoning is on the list, but it needs =
to
> be summarized here in the commit message.
You are right, I should have explained my thinking a bit more detailed.=
=20
A few of the fixed linkgit references are just typos, e.g.:

-linkgit:gitconfig[5]
+linkgit:git-config[5]

-values the `--date` option to linkgit::git-rev-list[1] takes).
+values the `--date` option to linkgit:git-rev-list[1] takes).

-	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
+	the Netscape/Mozilla cookie file format (see `curl(1)`).

I mistakenly assumed the "{litdd}" was a typo/bad search replace, too.
I checked this website and thought my change would fix it, too:

https://git-scm.com/docs/git-config

There it is rendered as "(See git-web{litdd}browse[1].)" and the link
is broken.


>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c7bbe98..c5f1d6b 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -894,7 +894,7 @@ branch.<name>.description::
>> browser.<tool>.cmd::
>> 	Specify the command to invoke the specified browser. The
>> 	specified command is evaluated in shell with the URLs passed
>> -	as arguments. (See linkgit:git-web{litdd}browse[1].)
>> +	as arguments. (See linkgit:git-web--browse[1].)
>=20
> The existing code renders fine for me with "make git-config.1". But w=
ith
> your patch, I get a unicode emdash, which is wrong:
>=20
> --- old	2016-05-02 16:27:53.242050262 -0400
> +++ new	2016-05-02 16:27:57.742050360 -0400
> @@ -978,7 +978,7 @@
>=20
>        browser.<tool>.cmd
>            Specify the command to invoke the specified browser. The s=
pecified command is evaluated in shell with the
> -           URLs passed as arguments. (See git-web--browse(1).)
> +           URLs passed as arguments. (See git-web=97browse(1).)
>=20
>        browser.<tool>.path
>            Override the path for the given tool that may be used to b=
rowse HTML help (see -w option in git-help(1))
>=20
> In case it's hard to see with your font, the generated roff looks lik=
e
> this:
>=20
> -\fBgit-web--browse\fR(1)\&.)
> +\fBgit-web\(embrowse\fR(1)\&.)

I can confirm. Sorry, I indeed missed that.


> So I think that's a step backwards. I did check the asciidoctor
> rendering on git-scm.com, though, and it gets the {litdd} case wrong.=
 So
> I think it does need fixing, but we need a solution that looks correc=
t
> in both cases. Maybe linkgit:`git-web--browse`[1] would work; it seem=
s
> OK with my version of asciidoc, but I have a feeling it will run into
> the same problem with asciidoctor (if it's not respecting {litdd} in
> that context, it's probably also not respecting backticks).
I will play with this to find a solution. Would it be an option to
replace "--" with "-"? Why do we need two dashes if they cause trouble?

Thanks for the review,
Lars