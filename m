Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE4347B8
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="iNYsagyH"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804012A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699378558; x=1699983358; i=tboegi@web.de;
	bh=9gey4+L9ehanOYYMfQVomf0rpiPBef3omt4nGoxxbfY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=iNYsagyHdU9zEfK/+QE6Mc0j7vXedGBFYn2SeconJWgTe1GJ7zzFb7tS1huBt39D
	 oK97N1ceucVmpQ6VervrlY908DM64Lx4HeQ2s+0kIl8XTrmcY+VTkBWUTRkEPAEwD
	 wDDe5zfirlmKWzfYWv9u2UvFwPIIY+coniUETqljPKP3+dbhMP56d/inPb2bQu9L+
	 nM8/nnlLYYVT0nwllCFAluUCQ4roTZRX6FB2vj7LGdFQkwLSIlPXAmoW1U/iDglsZ
	 osG9LPwrSCNf4qK7/KYqBelQeOoCDRRGyyWZWBhMmOrf8ZhZd7Tfht3kopYMX0D4f
	 7+libaJP7gn3fQ09UA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1rfVQu3i8D-00f2b9; Tue, 07
 Nov 2023 18:35:57 +0100
Date: Tue, 7 Nov 2023 18:35:57 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: chengpu lee <okuxxo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: issue unable to commit file and folder name to upper lower case
Message-ID: <20231107173557.GA29083@tb-raspi4>
References: <CAHv3AeCOoEXxpNh=gzjNcKbVyZFaYZ5BzSf3FGL1=pdheNebZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHv3AeCOoEXxpNh=gzjNcKbVyZFaYZ5BzSf3FGL1=pdheNebZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:XABxKz9Mmy3NbtHyP60gXCVV2E9IN/OjTR9zt6/+zfPIM7wa0uF
 kBGlU6ihi1fVeyLB3dRowk05ZJ6QTzbPbBQKg5ATRgvWx7HBcZlQuT1m+H5jUeH4oprra/C
 yMpnEwWpuDttBwYtGKr9dCvloh+eP0TdZzV6cOkjm0xFXtMI7sFeZphjguPOieYka6FZCCD
 7RVOoC/xm5aMC3VerABpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3mBimHgGBnw=;VIJj2BHF9l+0cZpvkl4ZSkf0iTP
 hF2VnWjObBBP9a4qSkIRp4Ret1eJcdqL39vTcPneOKgpTK4cv99x7pFNVJUu2JsTYaNt6KgOk
 XRV5R5hGB9rQ1XP7EeUYifs57zG4+1JK/G3G4W/dioxpDYXlHN7CotqTqNAZsy+U7fLuHu0Zi
 DPLvexygXfc2LoSpeSdyqzk3pgMZS+hf2PI4/4rZTsOIQC6aMENlAEOWplnxH9lbFP2epataT
 oBNG7QtArZaWV+336EpnMdP3yhBrUU1RFtbAkrmRVTi2/YOnwUTXDNMRhyHVNtsE4GzeN1fl4
 AaQ1tdpBedk5+sTeqcjZseC5VkjoqNPrTyUQPQRtJKeMBgo738/ikX7kZRKbvmf1MDCpP+7ms
 UJAhhUqYIHf9tdBRTHug+b84t/yOgfIKaJ/33e5rQuBE1ubVA1+LZ4NentLnN2I4/u/MP84Ie
 tSa9WHBSWRuvXZIZKPXKavjU4xvRD22ggSO9HsfMkRtdIwsDe68fkDUqQUd8a8gZJt5F5ZVFx
 QE4cWCmxZY9b18XRJdVzRLyX1zrw3R2rcN6cYo6w5Mmpldent+QzNFO+Mw+x4zCJOEzwplLWx
 Bp63YFnqrRh3kKt/I3peatD3GizlSwxTqJaP2xTvTFF88/f7A/LKjabIj/GaarINR9n9kaF/n
 Q8/eJDHjBFPMqYvv2+rwGqbXQB65+gQlCxXKM0N3sdgZy5md56NyiCu7to+m2L7DLhGRCoX2K
 6O0e+XlKCSOqUaIjODspHyx2xEjYtQVJ5Y0NnJhjZ6odUSTfVM/rz73GKPyL4RJdFe4MfW/m8
 Zbrq1JZIzNRPDT0i8O+7pcP5ZXiAosdu4THuzDt91GJ84bMnPdJKu1GmOCN6h0ZwEz6ThB6lw
 mzEVEoBQ5efIk6qf+ZzkWNmhThuRoqMlFjHav36g+uQfV/mJRKpWo4C4Y8CYcJ3AYfaSPrzfR
 K9eiB1MgsFnymBOmYn++508XeT8=
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 07:28:14PM +0800, chengpu lee wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> $ mkdir abc
>
> $ echo "">abc/.keep
>
> $ git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         abc/
>
> $ mv abc Abc
>
> $ git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         Abc/                                                      # rena=
me
> to Abc/ successfully
>
> $ git commit -m "commit Abc/"                                     # comm=
it
>
> $ mv Abc abc
>
> $ git status
> On branch master
> nothing to commit, working tree clean                             # cann=
ot
> rename again
>
> $ git diff
> >""
>
> $ git add .
>
> $ git commit -m "Cannot rename from Abc/ to abc/"
> On branch master
> nothing to commit, working tree clean                             # cann=
ot
> commit to right, keep old file name / folder name
>
>
> What did you expect to happen? (Expected behavior)
> It should be correct to new name although just change upper/lower case,
> because other commiter can pull it from repo or improve reading clarity.
>
> What happened instead? (Actual behavior)
> can commit file/folder but cannot fix upper/lower case.
>
> What's different between what you expected and what actually happened?
> git unable to faithfully represent file/folder upper/lower case changes.
>

Yes, that is a restriction in Git, call it a bug, call it a missing featur=
e.
Unless someone fixes it, the recommendation is still to use a workaround:

tb@pc:/tmp/ttt> git mv Abc tmp
tb@pc:/tmp/ttt> git mv tmp abc
tb@pc:/tmp/ttt> git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    Abc/.keep -> abc/.keep

tb@pc:/tmp/ttt>
