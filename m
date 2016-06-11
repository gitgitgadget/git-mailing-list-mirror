From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Sat, 11 Jun 2016 20:31:46 +0100
Organization: OPDS
Message-ID: <5A8F8EE0162B49818813DAEFD68F61DA@PhilipOakley>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org> <1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org> <xmqqmvmui9d2.fsf@gitster.mtv.corp.google.com> <CALkWK0nJDwH27V9B+X2K=c_X2k82ZXnab1r1zR6_axipxT5gkg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Git List" <git@vger.kernel.org>,
	<erwan.mathoniere@grenoble-inp.org>,
	<samuel.groot@grenoble-inp.org>, <tom.russello@grenoble-inp.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Jeff King" <peff@peff.net>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 21:31:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBodN-0004bI-QZ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 21:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcFKTbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 15:31:49 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64851 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbcFKTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 15:31:48 -0400
Received: from PhilipOakley ([2.96.201.101])
	by smtp.talktalk.net with SMTP
	id BodGbmA4ZwhW1BodGb5mJi; Sat, 11 Jun 2016 20:31:46 +0100
X-Originating-IP: [2.96.201.101]
X-Spam: 0
X-OAuthority: v=2.2 cv=E92PnuVl c=1 sm=1 tr=0 a=Y4v4M/+rR7swj2cHUUnfDA==:117
 a=Y4v4M/+rR7swj2cHUUnfDA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=TSbVqHtbAAAA:8 a=UHSIfI8_zsccmT7IqMsA:9 a=gt3PgYYCzfyN_ewW:21
 a=Bt_mMEhvqu7TtNGL:21 a=6kGIvZw6iX1k4Y-7sg4_:22 a=NJcUIoPEKLAEIzHnl83t:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMC8dNZLQ4+ax9cpQmAuHeO4LXZ4vAsOuncomiWHrTiqx9Jd3odI6TneRq6sjSJrW4rnmtW2ZqajtlMmqlQ9t82QZl54tsmjctlpOO5+TpAwVgt5ZRQK
 8+mIPD/TuDJwo8Y95dG7elsVSJftGdKOniuMKJLVe6SWWo4kyKxnE1F1fEtHZyMqBsD2tId8d18eSbkjui0hshUkrOqUXhjz3Bl7zNItnyZLxxNUefPdzXrB
 rPCusck3vTYmct1CK4WHYs+Tk+WZ2uFfkf139Br8i//S2SHS5ZD0R7eM4nZMLLbLMy4BD7zh9LD973LY2fT2pMsv9qvpPhOwCJN3CiSjNeNeoGRIzCXu37Qk
 BIrscuuSE0BPxLhwNqpqD26W5TZ3Lk1l0wVGAhc/rDh7s8jPMm2gatN5wfXbDcHLdQM2zBIzvhuqx3WVDajqfrTJEpBriMXkWXrgJse/2x8pXAFHQBBjVEW0
 4A2bwD/7qzq08Qj3qCIN2jhCaIyjgt8zK4MQHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297100>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> Junio C Hamano wrote:
>> Jordan DE GEA wrote:
>>
>> > +* Allows contributors to work with Git even though they do not have
>> > +write access to **UPSTREAM**.
>> >
>> > +* Allows maintainers to receive code from contributors they may not
>> > +trust.
>
> Triangular workflow is the ability to accept changes from contributors
> without mailing patches back-and-forth. Whether they send a pull
> request or

>       commit directly to the master repository

Surely, if they can do this then they do not need a distinct publish repo.

The triangle is necessary because of the accessibility 'standoff' between 
the upstream and local repos when a pull workflow is used.

Matthieu had clarified this (to me 
http://article.gmane.org/gmane.comp.version-control.git/296538) - I was (at 
that time) confusing the use of the fork as a home vault (with passive 
publishing) with the need for actively publishing a branch for a PR.

>   when review is
> done, is inconsequential. Essentially, they maintain forks of
> upstream, which they work on at their own pace.
>
>> > +* Code review is more efficient
>>
>> I have no idea what data you have to back this claim up.  More
>> efficient compared to what?
>
> They're orthogonal. LLVM has one giant SVN server that everyone
> commits directly to. However, they review process is a lot more
> efficient than GitHub projects, because they use Phabricator. What
> does code review tool have to do with triangular workflow?
>
>> > +Preparation
>> > +~~~~~~~~~~~
>> > +
>> > +Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
>> > +repository.
>> > +
>> > +======================
>> > +`git clone <PUBLISH_url>`
>> > +======================
>> > +
>> > +Setting the behavior of push for the triangular workflow:
>> > +
>> > +===========================
>> > +`git config push.default current`
>> > +===========================
>> > +
>> > +Adding **UPSTREAM** remote:
>> > +
>> > +===================================
>> > +`git remote add upstream <UPSTREAM_url>`
>> > +===================================
>> > +
>> > +With the `remote add` above, using `git pull upstream` pulls there,
>> > +instead of saying its URL. In addition, `git pull` can pull from
>> > +**UPSTREAM** without argument.
>> > +
>> > +For each branch requiring a triangular workflow, set
>> > +`branch.<branch>.remote` and `branch.<branch>.pushRemote`.
>> > +
>> > +Example with master as <branch>:
>> > +===================================
>> > +* `git config branch.master.remote upstream`
>> > +* `git config branch.master.pushRemote origin`
>> > +===================================
>
> It's much too simple now. Just `git clone <upstream>`, `git remote add
> mine <fork-url>`, and `git config remote.pushdefault mine`. Only the
> last line requires an explanation.

I note that you use 'mine', Jordan was proposing 'me', while I started using 
'my'. It is useful to see these personal choices, especially as there is no 
'origin' in the nominal triangular flow diagram.

Whether to use branch configs or remote configs is part of the 
clarifications.

>
>> Instead you would set default.pushRemote to publish
>> just once, and no matter how many branches you create later, you do
>> not have to do anything special.
>
> I think you meant remote.pushdefault here?
> 
