Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B2C352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FCA20768
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 21:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pdinc.us header.i=@pdinc.us header.b="crbVquTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634013AbgDNVlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:41:44 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:57208 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634005AbgDNVle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 17:41:34 -0400
X-Greylist: delayed 2533 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 17:41:34 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 03EKwWw6020545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Apr 2020 16:58:32 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 03EKwWw6020545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1586897912; bh=uEb0olGkqcYRjiz6X1kZH1nbuLcjh4tz6xkzzwvTsHw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=crbVquTMjKf5FsO7rEdL3uZvrbwkXx17z7ibjmdzOrfKMQ+q8nvQcXhIqxFZjCAtr
         Od6wDQLKdK3JYxUhEfdbK3/zkqKHxWTbibpwG34vd+2+Cj1pu5sEdifMwcFcmNiR/8
         Zp3Nh/DOMyOBpglqNo00oam8sn88giSBpoxraWnS7Xq68ribZF26klY201la043ecc
         byGemdgIWU1tU8UZk32JkVcRsZE77ZGFc0OQnGVafWn4LiunTsh59/dlqqw2AqQ4Fj
         k2WQI/pO78n+isuXoBPD92gkNyghkZLVW8yfSruPyL8iSFxxDogZp4NNaJyYjCE27q
         54Zn6DhOFya4w==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Git Mailing list'" <git@vger.kernel.org>
Cc:     "'Robert P. J. Day'" <rpjday@crashcourse.ca>
References: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
Subject: RE: has anyone bothered to read this "Git is a security risk"?
Date:   Tue, 14 Apr 2020 16:58:42 -0400
Organization: PD Inc
Message-ID: <03a501d6129f$7b1545a0$713fd0e0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFN40TcLujYJQSCtkE5g7Jl/OQGA6mJcEHA
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes. It is a FUD tool to sell their product/service.

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf =
Of Robert P. J. Day
> Sent: Tuesday, April 14, 2020 4:14 PM
> To: Git Mailing list <git@vger.kernel.org>
> Subject: has anyone bothered to read this "Git is a security risk"?
>=20
>=20
> https://twitter.com/blubracket/status/1250123442600513547

They claim 5 risks.

Risk #1 - Secrets in code.
Risk #2 - Malicious code from unauthorized open source.
Risk #3 - Your business, network and infrastructure blueprint exposed =
through code.
Risk #4 - Sensitive code and PII on public code sharing websites.
Risk #5 - IP theft.

With a SALES PITCH at the end

"
BluBracket can help.=20

While software development has changed dramatically and software
has grown in importance, the ways we secure code have not. This has to
change. BluBracket is the first comprehensive security solution for code
in the enterprise. We deliver the insights and control enterprises need
to keep code safe. Contact us for an exploration of how we can help,
including an audit of your production environments for secrets in code
and other vulnerabilities.
"

In short by using FUD, the reader is more likely to buy their product =
which will alleviate your fears, uncertainty, and doubt around GitHub, =
Inc. and Git technology.

They have 10 specific attacks on Git/Github in their paper, I have =
listed them below. In square brackets ([]) I have added meaning where =
needed. The "Git" contextual quotes are as follows:

1. "A decade ago, companies didn=E2=80=99t worry much about code =
security. ... GitHub had only just begun ... code and coding =
environments today represent the biggest unmanaged and unmonitored risk =
to enterprise security"

2. "Between Google and Github searches, these secrets [keys, password, =
etc.] are a gold mine for hackers"

3. re-quote from How Bad Can It Git? Characterizing Secret Leakage in =
Public GitHub Repositories Network and Distributed Systems Security =
(NDSS) Symposium 2019 =E2=80=9CWe find that not only is secret leakage =
pervasive =E2=80=94 affecting over 100,000 repositories =E2=80=94 but =
that thousands of new, unique secrets are leaked every day.=E2=80=9D

4. "In 2018, for instance, hackers mirrored the popular Linux =
distribution Gentoo=E2=80=99s Github repositories and replaced them with =
a malicious backdoor that would erase files."

5. "In 2019, hackers attempted a similar exploit against =
Ubuntu=E2=80=99s Github repositories."

6. "Recently, an AWS engineer published a 1G repository to Github =
containing a treasure trove of PII, including bank statements, customer =
correspondence, drivers=E2=80=99 licenses, and multiple key pairs and =
tokens."

7. "there is so much valuable information now on Github, hacker groups =
have automated searches"

8. "hacker posted details about it [Capital One breach] in a public =
Github repository. Github was recently sued over their role in this =
incident"

9. " This [the finding of sensitive data in a repository] generally is =
inadvertent because Git makes it so easy to share code"

10. "

But unfortunately, Git is the wild west. Right now security teams have =
little=20
to no visibility into where this important enterprise asset lives.

While visibility is a huge issue, code proliferation is another. Git was
developed for open source projects, not the enterprise. By default, =
everyone
has access to everything. A contractor can download all the code in that
repository, not just the section he is working on. With one click, he =
can then
upload your code to his or her own personal repository.

There are currently no repeatable, scalable ways to lock down access or =
even
track and monitor behavior. And if an insider wants to take code and =
sell it
or use it at a competitor, there is currently no way of even being =
notified that
your code has been published. By default, Git proliferates code.

"

In my opinion, as a cyber-security SME, software developer, git user and =
developer, etc... numbers 1 through 8 have nothing to do with Git or Git =
related technologies/services. Bashing what one can do with GitHub.com =
is also silly, do not put your sensitive code on someone else's server.

Numbers 9 and 10 have a bit more merit, if only measured using the most =
sensitive measuring instruments. It is no more easy to be carless with =
your data stored in a git repository than subversion, than CVS, DVDs, =
portable hard drives, laptops in a caf=C3=A9, etc. It is just data, you =
can copy it. 10 is a real concern but not because of git, but because of =
poor training, bad trustworthiness between the organization and worker, =
etc. I will recite an event that happened where I work many years ago.

Manager: Did you take DoD source code home without permission?
Employee: excuse, avoids question, more excuses
Manager: Let me be clear, you are fired. I need the answer to the =
question, did you take controlled DoD source code home with you?
Employee: no.

Git is not a source of the problem, human resource management and cyber =
security hygiene are. We failed to cultivate a responsible employee, =
with a work ethic. The employee decided to telework without =
authorization (play hooky) claiming to work. But the git repository for =
that project was not accessible from home... Our Git was secure...

**SIGH**


--
Jason Pyeron  | Architect
PD Inc        |
10 w 24th St  |
Baltimore, MD |
=20
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397





