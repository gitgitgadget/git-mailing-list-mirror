From: David Barr <davidbarr@google.com>
Subject: Re: [RFC] "Remote helper for Subversion" project
Date: Sun, 4 Mar 2012 21:37:28 +1100
Message-ID: <CAFfmPPPs0FRbT-i+ZwBLNSca330Eo7thjNxDt3hJf0yUATthtQ@mail.gmail.com>
References: <1330777646-28381-1-git-send-email-davidbarr@google.com>
	<CAFfmPPMPDCKjAmZ85Cj1cdT2yAUykm9sV6a66zXeFRmYfrmtjg@mail.gmail.com>
	<20120304075424.GI14725@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 11:37:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S48op-0000FQ-U8
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 11:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab2CDKha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 05:37:30 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42823 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2CDKh3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 05:37:29 -0500
Received: by yenl12 with SMTP id l12so1337732yen.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 02:37:29 -0800 (PST)
Received-SPF: pass (google.com: domain of davidbarr@google.com designates 10.236.173.195 as permitted sender) client-ip=10.236.173.195;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davidbarr@google.com designates 10.236.173.195 as permitted sender) smtp.mail=davidbarr@google.com; dkim=pass header.i=davidbarr@google.com
Received: from mr.google.com ([10.236.173.195])
        by 10.236.173.195 with SMTP id v43mr22381602yhl.40.1330857449069 (num_hops = 1);
        Sun, 04 Mar 2012 02:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=10dM19O1UgSrheH/rglMZbhATXg9V+HP+upBqq+TstA=;
        b=O0vz3ylMCnAuxjCopeZ0AJElbdzsIzMlc2SOjPf32YFiE0ebJ4Y0GEDc6N1jrdzU92
         Pf63LpEgzKBDswl3xgZqWGqaQGoBDEpJftGQGL36GrCcDHNVDxD6hQbx1sVYc3kQw1od
         QdhmP4qJx8LcN0Q6hbNQoKo2ta8HjI9J+4Fp9OoPRjW6hdqBcRStIzKVDRG9SRxlTtK2
         kvw+8s94yzdv6I5V080rhePvl+vxbdz19MnwIUenvUAFF6Vl8cDBoiYQT3vLGgoP8Hnx
         D9rTlSOhV27M85vLfoujtBKDm3cYPE21GrEajuPjPLgB+kFL+dLwHES0N48K++Kz5r3l
         YXoA==
Received: by 10.236.173.195 with SMTP id v43mr17752343yhl.40.1330857449014;
        Sun, 04 Mar 2012 02:37:29 -0800 (PST)
Received: by 10.236.173.195 with SMTP id v43mr17752322yhl.40.1330857448578;
 Sun, 04 Mar 2012 02:37:28 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Sun, 4 Mar 2012 02:37:28 -0800 (PST)
In-Reply-To: <20120304075424.GI14725@burratino>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkXA+SdySyfpxsHZtAetiiV/aotRf+gCpvH9i5Npu+aBKVLK0Sm1bVbmtay9Wo7qvREC7S3iLENtKyo1iuY5ZdfpY2viN6obLBH70swesKDfNGoskYiN0JOEpIhIq3YLxdZsBYtCI7h0X4eV6TRnssnip/SQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192148>

On Sun, Mar 4, 2012 at 6:54 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> David Barr wrote:
>> On Sat, Mar 3, 2012 at 11:27 PM, David Barr <davidbarr@google.com> w=
rote:
>
>>> --- a/SoC-2012-Ideas.md
>>> +++ b/SoC-2012-Ideas.md
>>> @@ -182,3 +182,29 @@ this project.
>>>
>>> =A0Proposed by: Thomas Rast
>>> =A0Possible mentor(s): Thomas Rast
>>> +
>>> +Remote helper for Subversion
>>> +------------------------------------
>>> +
>>> +Write a remote helper for Subversion. While a lot of the underlyin=
g
>>> +infrastructure work was completed last year, the remote helper its=
elf
>>> +is essentially incomplete. Major work includes:
>
> By the way, didn't we have a remote-svn prototype? =A0I'm happy to me=
rge
> any old hacky thing for staging in contrib/svn-fe, as long as it is
> not documented in a misleading way.
>
> (More generally, if anyone wants to resend useful svn-fe patches, tha=
t
> will help a lot.)

=46ound at former SoC2011Projects wiki page:
(http://git.wiki.kernel.org/articles/s/o/c/SoC2011Projects_b1f9.html#Re=
mote_helper_for_Subversion_and_git-svn)
[vcs-svn, svn-fe: add a couple of
options](http://thread.gmane.org/gmane.comp.version-control.git/176578)
[remote-svn-alpha
updates](http://thread.gmane.org/gmane.comp.version-control.git/176617)

The introduction should be rephrased to include Dmitry's progression.

>>> +* Understanding revision mapping and building a revision-commit ma=
pper.
>
> Does this mean creating commit notes to record which subversion rev
> corresponds to each commit, and marks or lightweight tags going the
> other way?

Yes. I think once again, Dmitry produced a good prototype for this comp=
onent.
However, I think it also potentially incorporates git-svn style
slicing of history.
That's a significant chunk of work.

>>> +* Working through transport and fast-import related plumbing, chan=
ging
>>> + =A0whatever is necessary.
>
> I think Dmitry and Sverre took care of most of this.

Ditto.

>>> +* Getting an Git-to-SVN converter merged.
>
> Probably could fill a summer in itself. =A0In previous starts I think
> there was some complexity creep. :/
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/170290
> =A0http://thread.gmane.org/gmane.comp.version-control.git/170551

This is my preferred focus, and is a sufficient project in its own righ=
t.

>>> +* Building the remote helper itself.
>>> +
>>> +Goal: Build a full-featured bi-directional `git-remote-svn` and ge=
t it
>>> + =A0 =A0 =A0merged into upstream Git.
>
> Sure would be neat. ;-) =A0Another nice piece to build would be branc=
h
> tracking / follow_parent heuristics.

As noted earlier, the remote helper itself is now half-complete.
I do think the immediate goal should be bi-direction.
The remainder is porting git-svn logic to the new helper.
However, it would be interesting to see what's missing with respect to =
porting

--
David Barr
