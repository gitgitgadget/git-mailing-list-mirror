From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Pull is Mostly Evil
Date: Sat, 3 May 2014 21:24:44 +0100
Organization: OPDS
Message-ID: <CFC38D3E32F9460685EFFD76228E4E21@PhilipOakley>
References: <5363BB9F.40102@xiplink.com> <87k3a4xjzg.fsf@fencepost.gnu.org> <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley> <5363ec734572a_70ef0f30cdc@nysa.notmuch> <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley> <20140502225342.GQ9218@google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"Git List" <git@vger.kernel.org>, "David Kastrup" <dak@gnu.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 22:24:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggUL-0006hB-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbaECUYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:24:46 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:48744 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753178AbaECUYp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:24:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: As4ZAEdPZVNOl322/2dsb2JhbABZgwZPiHy8LQQBAQIBAYERF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAw4HAQIJJRQBBAgSBgcXBhMIAgECAwEKAYgRAwkMCasvl2INhluMO4IXgzGBFQSJTYY7hHKCSIMui1uFXYM1PDAB
X-IPAS-Result: As4ZAEdPZVNOl322/2dsb2JhbABZgwZPiHy8LQQBAQIBAYERF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAw4HAQIJJRQBBAgSBgcXBhMIAgECAwEKAYgRAwkMCasvl2INhluMO4IXgzGBFQSJTYY7hHKCSIMui1uFXYM1PDAB
X-IronPort-AV: E=Sophos;i="4.97,978,1389744000"; 
   d="scan'208";a="445477606"
Received: from host-78-151-125-182.as13285.net (HELO PhilipOakley) ([78.151.125.182])
  by out1.ip04ir2.opaltelecom.net with SMTP; 03 May 2014 21:24:43 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248057>

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Friday, May 02, 2014 11:53 PM
> Hi,
>
> Philip Oakley wrote:
>
>> That assumes that [git pull] doing something is better than doing
>> nothing,
>> which is appropriate when the costs on either side are roughly
>> similar.
>
> I think the conversation's going around in circles.

I agree it's going around, but it's a non-exact recurrence. Issues are
being surfaced.
>
> Potential next steps:
>
> a. Documentation or test patch illustrating desired behavior
>
> b. More traditional formal design doc explaining desired behavior and
>    the thinking behind it ("problem", "overview of solution",
>    "alternatives rejected", "complications", "example", "open
>    questions").
>
> c. Implementation patch
>
> d. Someone takes an existing patch and figures out the next step
>    toward getting it ready for application.
>
> My preference is for (a), I guess.

I disagree about the leap to the presentation & discussion of a
'solution' in these awkward scenarios (the old joke about "if I were you
I wouldn't start from here", when asking for directions tends to apply).
This is the same point made by Brooks in the 'Mythical Man Month'. A
leap to code is no guarantee of success.

>
> The point being that something more concrete (code or a design doc)
> makes it easier to avoid talking past each other.  And having
> something concrete to edit makes the stakes clearer so people can make
> it incrementally better without being distracted by unimportant parts.

We've had Junio's training wheel, and now Filipe's n'th attempt at code
examples, so my bad code wouldn't help ;-). As a systems engineer I've
seen these confusions quite a few times in different guises.

I tend to fall back to P Checkland's "Systems Thinking, Systems
Practice" model of the various processes that have to go on [1] to
improve the situation (note he doesn't expect a solved solution in most
cases, just an improvement in the situation). At the moment most of the
discussion is in the "unstructured" parts of the processes. He also
identifies 6 elements 'CATWOE' [2] that need to be considered when
studying these problems.

Most of the discussion/arguments here are about the different
'Weltanshaung's" (world views) of the contributors.

In terms of the new user pull problem, what needs to be modeled is the
new user's and their weltanshaung, not how we ('experienced' users?)
might 'solve' the problem.

The pull problem is, I believe part of the bigger problem of the
mind-set shift required for the transition to a DVCS for most new users.
Git has grown organically, so still has some soft (unclear) edges, which
probably needs more than just a transition plan for Filipe's pull
changes, and its choice of the final default (or lack of).

For example, if users aren't understanding the differences between
remote branches, remote tracking branches, and branches, which is part
of the pull problem; have we made it easy for them to understand? [They
already have to comprehend the 'staging' concept, so are already
cognitively fully loaded].

For the branch type example, some cleaner naming may help, such as:
'remote branch', 'Tracking branch', and '(local) branch', which excludes
the noiseword 'remote' from 'Tracking branches' (my deliberate 'T'
emphasis). Though that does still leave the confusion between remote
servers and remote repos, where the latter may actually be local, and if
a file path, be the local '.' repo itself!

>
> Thanks and hope that helps,

Sorry if this went off at a tangent, but I believe it's important to get
to the bottom of the new user problems, which are deeper than just a few 
command defaults.

> Jonathan
> --

Philip
--
[1]
http://40qx6d15vq6j25i83v3ks8nxfux.wpengine.netdna-cdn.com/files/2012/08/seven-steps2.gif
or http://portals.wi.wur.nl/spicad/?Soft_Systems_Methodology Checkland's
7 Steps.

[2] CATWOE: customers, actors, transformation, weltanshaung, owners,
environment.
