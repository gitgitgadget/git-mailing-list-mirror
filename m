From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Mon, 17 Mar 2014 15:11:09 +0100
Message-ID: <5327027D.6090500@alum.mit.edu>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com> <1394742059-7300-1-git-send-email-zhaox383@umn.edu> <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com> <xmqqiorghgaj.fsf@gitster.dls.corp.google.com> <CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com> <7v38ihuvq7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 15:11:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPYG8-0005Zk-FV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 15:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbaCQOLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 10:11:15 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54685 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932692AbaCQOLN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 10:11:13 -0400
X-AuditID: 1207440d-f79d86d0000043db-b5-53270280f1ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A7.2D.17371.08207235; Mon, 17 Mar 2014 10:11:12 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD44AD.dip0.t-ipconnect.de [79.221.68.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2HEB9t3010614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Mar 2014 10:11:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <7v38ihuvq7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqNvApB5scOKUnEXXlW4mi4beK8wW
	Z940Mjowe1y8pOyx+IGXx+dNcgHMUdw2SYklZcGZ6Xn6dgncGUt+lBYc1Kg4N7WTsYGxUaGL
	kZNDQsBEYm/XImYIW0ziwr31bF2MXBxCApcZJR7ff8MI4Zxnkti7ZDETSBWvgLbEv56lbCA2
	i4CqxPq1x8BsNgFdiUU9zWA1ogLBEqsvP2CBqBeUODnzCZgtIqAmMbHtEJjNLOAtcWv9PDBb
	WMBf4tiLPqjNz5kkdvQsZAdJcAqYSTQ8+Q1UxAF0nrhET2MQRK+OxLu+B8wQtrzE9rdzmCcw
	Cs5Csm4WkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJaN4d
	jP/XyRxiFOBgVOLhnaCsFizEmlhWXJl7iFGSg0lJlFf4P1CILyk/pTIjsTgjvqg0J7X4EKME
	B7OSCK/TO6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mC9wijerCQ
	YFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCiC44uBMQyS4gHa2wTSzltckJgLFIVo
	PcWoy7Fh25pGJiGWvPy8VClx3u0gRQIgRRmleXArYOnrFaM40MfCvK9AqniAqQ9u0iugJUxA
	SxZNB3muuCQRISXVwBj14MeU7UsM/C1dtV59WLM65UYtd2WK6qsF+39HXT4ZV+B+s/rcxK/H
	XjVFme/kZXozz/bscteJRSHznTawmj2c9YNDU0xIMvEpy6WgA987jrfxbLk3JaDj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244252>

On 03/17/2014 08:31 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> Perhaps it is time to mark this microproject as "taken" on the GSoC
>> page [2], along a fews others for which we have received multiple
>> submissions.

I just marked #8 as taken, as it's been beaten to death.

I haven't been keeping careful track of which other microprojects have
been overused.  If you have suggestions for the chopping block, let me know.

>> [2]: https://github.com/git/git.github.io/blob/master/SoC-2014-Microprojects.md
> 
> I actually have been of multiple minds on this.
> 
>  * After seeing that many candidates tried to solve the same micro,
>    apparently without checking answers by other people, and seeing
>    how they responded to the reviews given to them, I found that we
>    had as equally good interactions with them to judge their skills,
>    both techincal and social, as we would have had if each of them
>    solved different micros.
> 
>  * Many reviewers may have gotten tired of seeing many novice
>    attempts on the same micro over and over again, giving gentle
>    suggestions for improvements. Because the _sole_ purpose of these
>    micros were to help candidates get their toes wet in the process,
>    duplicated efforts on the candidates' side are not wasted---they
>    each hopefully learned how to interact with this community.
> 
>    But it is true that, if we were wishing to also get some trivial
>    clean-ups in the codebase as a side effect of these micros, we
>    have wasted reviewer bandwidth by not having enough micros, and
>    reviewers may have had some feeling that their efforts did not
>    fully contribute to improving our codebase, which may have been
>    discouraging.
> 
>    Big thanks go to all reviewers who participated despite this.  If
>    we had more micros, the apparent wastage of the reviewer efforts
>    might have been avoided.
> 
>  * Many candidates did not even bother to check if others are
>    working on the same micro, however, which would be a bad sign by
>    itself. Concentrating on one's own topic, without paying any
>    attention to what others are working on the same software, is
>    never a good discipline.
> 
>    Some may argue that it would be unfair to blame the candidates on
>    this---they may have picked up micros that haven't been solved if
>    we had more---but after seeing that many candidates' submissions
>    apparently did not take into account the reviews given to others'
>    submissions on the same micro and/or had many exactly the same
>    issues like log message styles as submissions on other micros
>    that have already been reviewed, I personally do not think they
>    are blameless.
> 
> So in short, yes it would have been nicer if we had more micros than
> candidates, but I do not think it was detrimental for the purpose of
> these micro exercises that multiple candidates ended up attempting
> the same micro.

I wish I had had time to invent more microprojects.  I think we were
lucky: since students didn't seem to learn from each other's attempts,
the fact that many people tried the same microprojects wasn't much of a
problem.  But if a student had arrived with a "perfect" solution to a
well-trodden microproject on his/her first attempt, I would hate to have
to be suspicious that the student plagiarized from somebody else's
answer plus all of the review comments about the earlier answer,
especially since a perfect solution would itself reduce the amount of
interaction between the cheating student and the mailing list compared
to a student who required several iterations.  I also hope that students
didn't feel unwelcomed during the times when the list of untaken
microprojects was nearly empty.

If we really wanted to make this system cheat-proof, there would have to
be not only enough microprojects to go around, but also some mechanism
to ensure that student B didn't start work on a microproject that
student A was just about to submit a solution to.  Maybe students would
have to claim a microproject when they started work on them, or request
a microproject to work on as opposed to picking one from a list on a web
page.  But realistically, I think that this hypothetical improved system
would be more work than we would have been able to invest.

Maybe in the future our microprojects should have two parts:

a. Fix ...
b. Invent a microproject for the next student.

(Just kidding.)

> Again, Big Thanks to Michael for the excellent "micro" idea, and all
> reviewers who participated.

I'd really like to thank the reviewers, who put in enormous effort
reviewing submissions promptly, and showed superhuman patience when
dealing with the same issues over an over again.  Without such great
reviewers the whole idea would have just resulted in frustration for the
students; with them, I think that even the students who don't get a GSoC
spot will have learned something valuable from their participation.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
