From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sun, 26 Apr 2009 11:36:04 -0500
Message-ID: <b4087cc50904260936t4aa05c92ldab3b8ce8c9bd33a@mail.gmail.com>
References: <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
	 <alpine.LNX.2.00.0904251445030.2147@iabervon.org>
	 <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
	 <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
	 <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com>
	 <20090426112802.GC10155@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 12:57:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly7N8-00077d-Ah
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbZDZQgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 12:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZDZQgH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 12:36:07 -0400
Received: from mail-qy0-f180.google.com ([209.85.221.180]:42604 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbZDZQgG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 12:36:06 -0400
Received: by qyk10 with SMTP id 10so812103qyk.33
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UThhrpEYI9zIwvDJ/OQaCa2onPj71Ti2ZT+9bnnYyrc=;
        b=LbcDW6i/hrYKivevZZq1gj2OVfvLaqVzc0OmzqNCjtr4xroIEqdmjqGiBHsT0A219d
         OkCHs9baHG+KGPdphfsCx0szBJCcx1XlD5ZDB2RLQzUreS4P6b3Gm4YO1z+0bOPm2W3L
         ynH4+6ElvR7JqcdGT7uTwaFIi2toAAIVgVQos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SqHimFR/FrVGZTTNrDTRTgZLDNR7SOQQyeoqIENfFy9lqB7YuquVkSJH2kADhJR0RF
         FUNxfgXUdx0xWzOWpyOu7zhK39U2MIXn2HISYR3QW7obH9RM4XVHLe6HrO7AVYBZ9u4J
         MQrzIGS9U0WwWSXtJpR4bdxwMRcLCEQbfj0f8=
Received: by 10.224.67.133 with SMTP id r5mr4782691qai.285.1240763764761; Sun, 
	26 Apr 2009 09:36:04 -0700 (PDT)
In-Reply-To: <20090426112802.GC10155@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117652>

2009/4/26 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.04.25 15:36:24 -0400, David Abrahams wrote:
>> Where it's relevant when the user notices that two distinct files ha=
ve
>> the same id (because they happen to have the same contents) and wond=
ers
>> what's up.
>...
> And why would your implementation save the same object twice, in two
> distinct files?

This question makes me think that you don't understand the parent's
point. He's not talking about implementation details; in fact, there's
no reason to mix the git world and the file system world at all in
this discussion.

David is pointing out that a user might notice that two different
trees list the same blob. This can be startling if you have incomplete
picture about what's going on.

=46rom a practical point of view, you might argue that not too many
people are looking at trees and blobs; however, it seems to me that
most people are afraid to use any of git's most useful features
precisely because they don't understand the git model and they don't
understand that nothing is ever lost unless you explicitly clean up
unreferenced objects---they don't see how easy it is manipulate their
repos. I argue that if they are given the full knowledge of git's
concepts, then they will be able to reason about their repo actions
with confidence, even if they only work with commits.

I think the key is to stress in the documentation the idea that there
are 2 separate worlds (the git object world and the working
directory's file system world) and that the git tools provide an
interface between them; this seems like a small and unnecessarily
academic point, but I believe that it's important to working with
confidence.

> ...
> You can't have two objects with the same contents to begin with, same
> content =3D> same object. =A0You can just have that one object stored
> multiple times in different places (for sane implementations this lik=
ely
> means that you have more than one repo to look at, and each has its o=
wn
> copy of that object, but that's nothing you as an user should have to
> care about).

Indeed it's nothing you should care about. It's an implementation
detail again; theoretically, every repo is in the same git world where
all git objects are stored---in a sense, a particular repo state is
itself an object of this world.

> It's an identity relation: same name/id =3D> same object. Unlike e.g.=
 a
> hash-table where you are expected to deal with collisions, and having
> the same hash doesn't mean that you have identical data.

However, having the same *cryptographic* hash does mean that you have
identical data.

The overall point is this: The documentation should force people to
learn the right ideas, so that they can have confidence to think
beyond blog-post templates for using git.
