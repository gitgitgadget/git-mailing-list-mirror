From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Sat, 11 Jun 2016 20:25:58 +0100
Organization: OPDS
Message-ID: <5B90624A6DC7442C94B933A07F0CD08D@PhilipOakley>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org><1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org><E41AB752AE614E189BC5BE289A8AEB2A@PhilipOakley> <xmqqinxhf0sx.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jordan DE GEA" <jordan.de-gea@grenoble-inp.org>,
	<mhagger@alum.mit.edu>, "Git List" <git@vger.kernel.org>,
	"Erwan Mathoniere" <erwan.mathoniere@grenoble-inp.org>,
	"Samuel Groot" <samuel.groot@grenoble-inp.org>,
	"Tom Russello" <tom.russello@grenoble-inp.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Jeff King" <peff@peff.net>, <artagnon@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 21:26:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBoXv-0000PM-2x
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 21:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbcFKT0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 15:26:05 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64639 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbcFKT0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 15:26:03 -0400
Received: from PhilipOakley ([2.96.201.101])
	by smtp.talktalk.net with SMTP
	id BoXfbm9SrwhW1BoXfb5m3n; Sat, 11 Jun 2016 20:26:00 +0100
X-Originating-IP: [2.96.201.101]
X-Spam: 0
X-OAuthority: v=2.2 cv=E92PnuVl c=1 sm=1 tr=0 a=Y4v4M/+rR7swj2cHUUnfDA==:117
 a=Y4v4M/+rR7swj2cHUUnfDA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=G_E_k4kaGSxAnGtSnbsA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfIaxYbigo1mJbXXgnUrobHCFGbTZKJnqHzCfmVxQr1AZkBM3pmMGyRE2BpNO0YWqUtNAS23wytdoQESshWJX1DQ0+jg2SEozj2rDkOALLb9dJFtgS4eQ
 uXkhebK1wUD2VUDe1nnuYeHYDyG99hjQ9g+hb+D2QoOdZrvez+GZTqgidAj7TxmaXxNSDMsw+RI/Iuk0G6bD0KOUTWOj7eEP93zTtdl8BiJQLRoAxcFezln0
 5TP3hoKdBJdsf9bsmn/bmrFjf0FkJ/n0DxVjuZMxYJElQev8oKIJ7F9xFBFsGSRB6QXYNmfBPhsWRjw6pVo3IwW+cXkPsWuRaIZwqeaqDURVr2BgkI9isppN
 EWNwk75INzarvWAQuxsdEdS4M8K6JZvhZLQ7rtkHYT9DGIWKb2IHscs7X8E/8mZLyiqKXWmspeCXeNlX+MUG00S+gTz+Z5PjxTfnoUL5rOJvJvPOLzyZBfC3
 rVheGUGAphUM4V0wL02GVm6F0BEYOtLWhDkl0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297099>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> +Preparation
>>> +~~~~~~~~~~~
>>> +
>>> +Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
>>> +repository.
>>
>> I agree here. To clone the upstream, to which you have no push access (by
>> definition), would leave the config badly mis-set for the basic user.
>> It's
>> better for the user to clone their publish fork (to which they have both
>> read and write access).
>
> I do not think I agree.
>
> If you apriori know that you do want to hack on a project's code, then
> forking at GitHub first and then cloning the copy would be OK.
>

You've clipped my other point:

-        One issue may be the different expectations of how the fork is
-        created (it's only one click on the GitHub..)

The fork creation issue is surely an essential part of triangular workflow - 
a fork isn't required for a patch workflow. Git uses patch flow, while 
Git-for-Windows makes use of (GitHub's) Pull Requests.

Most projects will be using some form of hosting service to provide their 
public publish repo, and often allow no public pushes. It's the upstream 
that choses the hosting service, which decides the users choices.

> But I doubt that would be a common set-up, unless you are focusing
> only on school-like setting where you are told by your instructor to
> "make changes to this public project, and show the result in your
> fork".  In real life you cannot tell if the project is worth your
> time modifying until you see it first, can you?

At this point there are multiple choices depending how the hosting and 
project is set up. It may already be packaged. It may allow full web 
browsing of the code. It probably has tar/zip download of the latest master. 
Some popular sites offer free hosting and forking, which leads to the the 
suggested method.

>
> I suspect that the majority of local clones start from something
> like "I want to build and use from the tip", "I want to use a module
> that does X, and there are three candidates, so let's clone them all
> to evaluate", etc.  You do not bother "forking at GitHub" but just
> clone from the upstream for these clones.

Any stat's for this. I'd be far more likely to fork first, giving me a 
backup vault, and clone that, especially since being bitten (historically) 
by the need to juggle the configs after the fact..

>
> After you build it and try things out, you may start making local
> changes, and you may even record your changes as local commits.  You
> play with your local clone of the upstream.  After doing so, you may
> find that some of the projects do not fit your needs, but for some
> others, you would find that it is worth your time and effort to
> upstream your changes and/or keep working further on the project.

In all these cases there is the 'backup' copy question for any of those 
mods, which tends to mean the user will have a fork acting as a home vault.

>
> And at that point, you would create a publishing place, push into
> it, and tell others "Hey I did this interesting thing!".  That
> "creat a publishing place" step could be just a one click at GitHub.
>
> Isn't that how you work with other people's projects?  Or do you
> always modify every project you fetch from the outside world?, Do
> you always fork first, just in case you *might* change and you
> *might* have to have a place to push your changes out?

As noted above, yes, if I'm interested enough to go for the clone, then mods 
are a real posibility and I'd typically use the hosting service as a 
vault/triangle.

>
> If you tell novices "You fork first and then clone your fork", and
> in the ideal (to you) case they will follow that advice to the
> letter and they will end up with forks of all projects they will
> ever look at, in many of which they make no local commit.
>
> What is more likely to happen is that they will first ignore you and
> start from a local clone of the upstream, and then find this
> document that says "triangular workflow requires you to fork first,
> clone that fork and work in it".  Because they would have to fork
> first and make another clone, this time a clone of the fork, in
> order to follow the instruction of this document, they oblige,
> ending up with two clones.  More importantly, this makes the local
> clone of the upstream they made earlier and the changes they made in
> that clone appear useless.  They need to be told how to transplant
> the work done in the clone to the newly created clone of the fork,
> in order to publish them.
>
> If your instruction begins with "You clone from upstream as usual
> (i.e. just like when you make a "read-only" clone without any
> intention to make changes or push changes out), and add a publish
> place if/when it becomes necessary", the problem described in the
> previous paragraph goes away, no?
>

Yes, the document does need to cover both routes, which should be the main 
outcome of the discussion.

But I still think that, by definition of the triangular workflow (and the 
reader will be here because they are expecting to be part of that flow), 
that the fork first (if available), is to my mind, the easiest was to get 
started. And if it's not, i.e. they clone upstream first, create a publish 
server/host/repo, push to that, and adjust all the configs for that, then 
that should also be described. It all depends on the phantom 'git fork 
<upstream> <publish>` command.

E.g.
* Establishing a triangular workflow using upstream's host fork method.
You do not have a local clone of upstream yet and hope to work on the 
project with a triangular flow. /describe the easiest steps from here/

* Converting a local repo to a triangular workflow.
You already have a local clone of the upstream, but no public repo that the 
maintainer can pull from. /describe the necessary steps to set up a fork, 
and appropriate config settings/
