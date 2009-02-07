From: James Pickens <jepicken@gmail.com>
Subject: Re: [BUG] 'git log --quiet' doesn't suppress the output
Date: Fri, 6 Feb 2009 23:44:59 -0700
Message-ID: <885649360902062244v715a61b7nf32003c97cc4f707@mail.gmail.com>
References: <885649360902041819k4a168407wc57017e6a1c7d00a@mail.gmail.com>
	 <20090206191146.GC19494@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 07:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVgxP-00038W-Cb
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 07:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbZBGGpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 01:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZBGGpB
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 01:45:01 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:60217 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZBGGpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 01:45:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1115850rvb.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 22:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=aSIhtTFNeansP2+RgjgPwFNZOj69wkCTqL2dVbBHCBM=;
        b=fSHfn5NL99pQx46jUrUdFKDn+1M1ezfdP9574SCEaZCk7UL/Hgyy6ZM2fdKK8+QNaI
         Rb3kPRNRPlEuLR8daiQkCaqowa9CwHhDDH6AVzz3V53vUqejkakZ3e1GMNglG407Ofu4
         Y3ljTh43H+u7gCGvXi+hV3ZxLqz12fPHxKPCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=S7WmBMnit+WnHiiGbQKDemYYQ0w6zVWRz2z8c3TChpXk1+kKrcv/Kb2ivPLY62RY8+
         OmANIl1OR7Qrz3BEy1zfitNVMW0TIEoWr9x0A/EQ6IQOD01QAtoQR38gO0YBH6EGcw9Q
         dQLMenNkwvA0GvjijK2T8HoMWf/3rGNbo9mJU=
Received: by 10.114.89.1 with SMTP id m1mr1824364wab.35.1233989099371; Fri, 06 
	Feb 2009 22:44:59 -0800 (PST)
In-Reply-To: <20090206191146.GC19494@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108816>

On Fri, Feb 6, 2009 at 12:11 PM, Jeff King <peff@peff.net> wrote:
> It would probably be trivial to for "git log" to see that the quiet
> switch was given and silence the commit output. But I am having trouble
> envisioning exactly what that would be useful for (except for being a
> slower version of "cat /dev/null"). Care to elaborate?

I was writing a script, and looking for a way to figure out
whether there were any commits in origin/master that aren't in
master (i.e., whether I need to pull before I can push), and 'git
log --quiet origin/master..master' was the first thing I thought
of.

James
