From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 20:00:12 -0400
Message-ID: <BANLkTim7ZAGHO3a-G6cBwKjg4wKzskbVTg@mail.gmail.com>
References: <201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DF08D30.7070603@alum.mit.edu>
	<20110609161832.GB25885@sigill.intra.peff.net>
	<4DF10ADA.5070206@alum.mit.edu>
	<7v8vtayhnm.fsf@alter.siamese.dyndns.org>
	<20110609200403.GA3955@sigill.intra.peff.net>
	<4DF13D00.2060000@alum.mit.edu>
	<BANLkTinAxWfAgBOOF0gkYDWmXDCRH+6zYg@mail.gmail.com>
	<20110609223825.GA7771@sigill.intra.peff.net>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 02:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUp9B-0001M7-8S
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 02:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab1FJAAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 20:00:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53796 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab1FJAAO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 20:00:14 -0400
Received: by bwz15 with SMTP id 15so1769964bwz.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 17:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GamjLTkZinfcYSurBKYg+cJtMtTF+t+Mkuv2lPadU5M=;
        b=WqtCMxfsLoziXv7tcfmkfVgR42NXBhPTHkFWxepPudJ6/c9q3uTKwFkMSqjwjpYKTN
         Q09nEjmW+0YS78Lqee1fJGaj9VnmdF4Q3WLUeRST4GVQgbTNUYm++CSbraOJLGzQgQlb
         292PUBN0m18veZqJfy0Zdnx6rjrJ00rykPozo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=sFcCTB6iQO7G6Tr4pUXDFlFmwaaZFnQkwhF5OqsKPJnWBllHRRgP11tBTW9a4ZRj2o
         FQYmHFFK7Ds4LxGnpPmsrj4XOV6Hrx8sdZKXf5cwQOimBurUgTnboBnM7Fs+7O9tsA6r
         hFkyqUEB75wHex4MmBlfHIeIXNj0s0eC9fHI8=
Received: by 10.204.82.149 with SMTP id b21mr1243228bkl.196.1307664012653;
 Thu, 09 Jun 2011 17:00:12 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Thu, 9 Jun 2011 17:00:12 -0700 (PDT)
In-Reply-To: <20110609223825.GA7771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175589>

On Thu, Jun 9, 2011 at 6:38 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 09, 2011 at 06:27:11PM -0400, Michael Nahas wrote:
>
>> I dunno Michael, your idea sounds dangerous.
>>
>> You're saying that the user interface should be defined with concept=
s
>> that have nothing to do with the plumbing. =A0That's crazy talk! =A0=
Next
>> you'll be arguing that users don't need to know that the Index file
>> has 4 stages!
>>
>> ;)
>
> I know you are being sarcastic, but it _is_ a dangerous thing. One of
> the great things about git is that it exposes the details of its data
> structures. So you rarely run into corner cases where the UI has give=
n
> you an inaccurate mental model, and you have to reconcile what is
> actually happening with your mental model. The tradeoff, of course, i=
s
> that you get exposed to the full complexity of what is happening.
>
> And note that I'm not saying it's impossible, or it's something we
> definitely shouldn't do. Only that we should be aware of what
> inaccuracies we might be feeding to the user, and asking questions ab=
out
> how that might bite is. Like: how likely is the user to run into a
> corner case where git does something unexpected? If it does happen, h=
ow
> much worse will explaining the behavior be than simply having exposed
> them to lower-level constructs in the first place?
>
> Also note that I'm not even sure that this token proposal is in fact
> introducing inaccuracies, and is not simply an alternate but equivale=
nt
> mental model. But these are the types of things I think people should=
 be
> thinking about in a proposal like this.

The beauty of building a level of abstraction is that you don't need
to know about the lower level.  Git's plumbing is built on files, and
directories, and communication libraries, but, in general, we don't
talk about manipulating the plumbing in those terms.  We talk in the
concepts of the higher level: commits, trees, branches, pushes, and
pulls.

I don't know what are the right concepts are for the porcelain.  I
have a feeling that a lot of the concepts will map 1-to-1 will
concepts in the plumbing, which is what makes the two hard to
separate.  At the moment, the NEXT and HEAD concepts "feel" right.
But I also think they're just part of the solution.

A partial step towards the right idea is not always a good thing.  It
could leave users confused or give them the power to create a mess but
not fix it.  We should be careful, but not fearful.


>> Peff: "... use tokens to describe non-treeish sources and destinatio=
ns"
>> What is non-treeish about NEXT/WTREE/etc.?
>
> They don't resolve to git tree objects. :)

Touchee'.
Actually, nice succinct definition.

Tree objects have SHAs and are long lasting.  Good differences to keep =
in mind.

>> Do you know of anything in the INDEX file that would not be visible
>> from NEXT/WTREE/OURS/THEIRS?
>
> The stat information, but that is usually ignored in porcelain, anywa=
y
> (we refresh the state information at the beginning of most porcelain
> commands, so you can just assume everything is up to date with the
> working tree and will be shown as such).

I took a quick look at some documentation.  The index has almost all
the stats about a file that are directly available from a file in the
working tree.  It also looks like the index has far more stats than
can be stored in a tree object entry.  Is that right?

Mike
