From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 14:08:35 -0400
Message-ID: <e06498070805271108t66a45abfy9abb5ed065e59e35@mail.gmail.com>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
	 <alpine.DEB.1.00.0805271151430.30431@racer>
	 <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
	 <alpine.DEB.1.00.0805271411520.30431@racer>
	 <8aa486160805270637m3fc640bfr9fa51eb917460e5c@mail.gmail.com>
	 <20080527135259.GA12551@cuci.nl>
	 <8aa486160805270721q64dff3f0gfbb9eb5384db027d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K13c0-0005bo-Bu
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 20:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbYE0SIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 14:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757025AbYE0SIh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 14:08:37 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:36374 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643AbYE0SIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 14:08:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so547441and.103
        for <git@vger.kernel.org>; Tue, 27 May 2008 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gVAgxLz/pJRlNFyfhtcA4Pn+CPom3frSgugYfNk88qk=;
        b=P5g05pQikxnG3NjN5vdDbeIBrXy42av/6obSUzljKeUaVbKHAkyVN2t4rSh3NZHjux03sBi9nq7RzmdtkJXEDcu7/K/V7JD+I3IIujcGPWFbVCxKiUY33GcDp9GUujE/VHiAwkbxxeVf58T2H2bPts3vMUbyyutLQ7rgzn0knQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lsWXCTo8Q5BGnJCgMbJetBQ1XQjGC6CeQG953zVh7Kg+D+i8KMG4E/K3QiGe6TfaFdVutXgYDaYEJAUJX1jUS2QE0xqv2mgYu+GAvbzGhB6MOT5ZaALwbGcnxA/GYSOlvzjseAEyBNMnlbf91UIxV0qKDkggA2Xzaxpy+f3VwEg=
Received: by 10.100.165.13 with SMTP id n13mr1814854ane.76.1211911715526;
        Tue, 27 May 2008 11:08:35 -0700 (PDT)
Received: by 10.100.92.6 with HTTP; Tue, 27 May 2008 11:08:35 -0700 (PDT)
In-Reply-To: <8aa486160805270721q64dff3f0gfbb9eb5384db027d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83035>

On Tue, May 27, 2008 at 10:21 AM, Santi B=E9jar <sbejar@gmail.com> wrot=
e:
> On Tue, May 27, 2008 at 3:52 PM, Stephen R. van den Berg <srb@cuci.nl=
> wrote:
>> Santi B?jar wrote:
>>>On Tue, May 27, 2008 at 3:12 PM, Johannes Schindelin
>>><Johannes.Schindelin@gmx.de> wrote:
>>>> Sure it is.  But cluttering up the commands for something that is =
not
>>>> really proven to be wanted by many is IMO inferior.

WANT.

>>>This is an argument against git-whatzzup.sh in general. Point taken.
>>
>> Not really.  It's an argument against cluttering up the existing cor=
e
>> with this stuff.

The only changes I saw were to porcelain, not plumbing (or is this not
what you mean by "core?")  I see no problem with making the plumbing
more user-friendly.  That is really the only point of the porcelain.
If you don't want user-friendly, use the plumbing directly.

> It is not a hands-on tutorial, it is more of "in which state (merging=
,
> bisecting,...) is my working tree, if it is in the middle of a comple=
x
> process (bisect, merge, rebase,...) tell me what was the help
> message". It is not that different from the output of "git status",
> but for states.

Surely it has happened to everyone that you start a rebase, walk away
and then continue hacking and committing with the rebase still in
progress.  It isn't too bad for an experienced user to recover from
this state, but prevention is much better than cure.  A simple "git
what" command that could remind you of what you were doing would be a
welcome addition, in my mind.
--=20
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
