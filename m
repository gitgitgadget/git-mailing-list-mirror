From: Stefan Beller <sbeller@google.com>
Subject: Re: [msysGit] Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 16:34:19 -0800
Message-ID: <CAGZ79kbcoN=-Byu8fPV9_9ZpFhsuZ=5U=V-Xif_30s-J8OWfJg@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
	<20150218193234.GA8298@peff.net>
	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
	<vpqioerz03s.fsf@anie.imag.fr>
	<CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
	<c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
	<vpqh9uavp6q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 25 01:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQPvm-0008Ct-6b
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 01:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbbBYAeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 19:34:21 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35317 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBYAeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 19:34:20 -0500
Received: by mail-ig0-f182.google.com with SMTP id h15so1809152igd.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 16:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/lSaCMCFVXYVjsT4JK9NY+PtO0hleZpqLqeH3Pabc1U=;
        b=Ghb4njKqugJHsS47GDz1E3mRX5n46H2G19ruPWkOWFnuih+udjSMezwPFb12/fyw0p
         U3ULFaAWZIkgn71SBYP1dCF4gEIpv3XlSyVYtwjxk0eF8o+rqNOdrOn7znT/vRRnUGgr
         VLv55n/hdnNqSQGJME6GLaJfw9WaRMjq7KtpMsZ3b+n2o+fn8au8LL4SNQ5NJxPb4eIv
         BDa8NcZTD08JOevibwMhFVz+g6M/F9CybiLDHwPrpnV/earMiv7CYmeOhycJ1sJbDMv4
         WTS/I0K87dmrt6ZlFW2BhJ5avkvn+XW6O3cztYqbu1SEqhQO8m0QpSx+yD+/0+4BlikZ
         qrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/lSaCMCFVXYVjsT4JK9NY+PtO0hleZpqLqeH3Pabc1U=;
        b=PmudMJy0vKhPhTlmtwqSUUnV/QLv9NhcZk8jY9lDjsQjz+Ok4ugglLE2pRCFR5QbtR
         Uvrvjvr1tEpp9T8YZDJtmasCc7H9K66gO1Q1ijYgxRyJR5QwhkRezBIBei9W6C/E7q2G
         B26hZhWCFrSUxTmvXrVDf1o6x03XCvuczAncdia3tTOeI0GA6scheujDDSXJxfQA7H9N
         Eg9bHi69brY6mv6M2Z/9hrqChbPsOgq3/aNigon6/lqZDAyFIhnJeGIEtC5dZKX5uVI0
         kn9A6xAUQ6GiBTlixH6CHf43iL2lSCBRlYDPb9fhv3tCFNPh3X3aQ0vV03b19KFI6Wsk
         z2Rw==
X-Gm-Message-State: ALoCoQkjoixU2hR+0b1GcGfE3889DYAtwPv7z3ftCpIan4RyIEUCdPz49QvW4pFpsU09HVktAuLy
X-Received: by 10.50.117.41 with SMTP id kb9mr1215860igb.37.1424824459761;
 Tue, 24 Feb 2015 16:34:19 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Tue, 24 Feb 2015 16:34:19 -0800 (PST)
In-Reply-To: <vpqh9uavp6q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264363>

On Tue, Feb 24, 2015 at 3:56 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Hi Junio,
>>
>> On 2015-02-24 19:25, Junio C Hamano wrote:
>>> On Tue, Feb 24, 2015 at 9:32 AM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> About the proposal:
>>>>
>>>>   The idea of this project is to dive into the Git source code and
>>>>   convert, say, git-add--interactive.perl and/or git stash into proper C
>>>>   code, making it a so-called "built-in".
>>>>
>>>> My advice would be to try converting several small scripts, and avoid
>>>> targetting a big one....
>>>> add--interactive and stash are relatively complex beasts, perhaps
>>>> git-pull.sh would be easier to start with.
>>>
>>> Yeah, I think that is a very good suggestion.
>>
>> Well, git-pull.sh is really small. I did not want to give the impression that the Git project is giving out freebies. But I have no objection to change it if you open that PR.
>
> To get an idea, I counted the lines of code written by the student I
> mentored last year:
>
> $ git log --author tanayabh@gmail.com -p | diffstat -s
>  43 files changed, 1225 insertions(+), 367 deletions(-)
>
> I would consider this GSoC as "average" (i.e. not exceptionnally good,
> but certainly not a bad one either), so you may hope for more, but you
> should not _expect_ much more IMHO.
>
> In comparison:
>
> $ wc -l git-add--interactive.perl
> 1654 git-add--interactive.perl
> $ wc -l git-stash.sh
> 617 git-stash.sh
>
> I'd expect a rewrite in C to at least double the number of lines of
> code, so rewriting git-stash would mean writting at least as many lines
> of code as the GSoC above. git-add--interactive.perl would be rather far
> above.
>
> But my point was not to convert _only_ git-pull.sh, but to have a GSoC
> starting with this one and plan more. Then, depending on how it goes,
> you can adjust the target.
>
> This all depends on what you intend to do if the student does not finish
> the job. If you're going to do the rewrite yourself anyway, then having
> the student do even half of it is good already. If you're not going to
> finish the job by yourself, then a 95%-done-rewrite means a piece of
> code posted on the mailing list and never merged (and a lot of time
> wasted).
>
> In any case, these are just advices, certainly not objections or hard
> requests to change.
>


Once upon a time (Sep 2013) I rewrote builtin/repack.c which was a
shell script before. I did not have much real-coding expertise with the
git community before and by today there are 403 lines of code in
builtin/repack.c. so going for roughly 3 times (1200 lines of code) change
would make a summer, specially if you need to learn how the workflow
is in the open source world.  There the lines in c doubled nearly exactly.
(before 197 shell lines, afterwards 387 c lines).

Just last weekend I met people, who were afraid of contributing to open source
"because sometimes the internet can be very mean". Git being quite a high
profile project, as it is widely used, might not help, but rather fear
people away.
That said I would not underestimate the initial time a student needs to learn
the workflow. Though most of that learning is done in the micro project phase.
