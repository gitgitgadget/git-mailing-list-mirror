From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 12:58:10 -0700
Message-ID: <d411cc4a0808191258i9037a84k267c09795dffb3b8@mail.gmail.com>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
	 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
	 <20080819185804.GA17943@coredump.intra.peff.net>
	 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
	 <7v63pw3ick.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVXML-00074z-WA
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbYHST6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYHST6O
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:58:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:1321 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYHST6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:58:13 -0400
Received: by wx-out-0506.google.com with SMTP id h29so123962wxd.4
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FenIU5bTpHhaMyIJKZ1cowhoRTzMlvcEmq+h88qkcw8=;
        b=QtsLhIjsBBL49eAWsWiXZL+mqxM0en0nruDQrxHHxQDP4S7EJrdaGiIp5CzugpGRau
         quRDOrHDr0J4gTzLV/rTvQfYIrSx4ab2z17wuXbLhwZ5CiEpAYTudXC8FyL51xtIJ5Oa
         UbVCrpOyTfgmsxaRFuLijKOp5Tag/LFV9cqO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oGKbQjTJV9qsmwsrO685fNKyYzqs526hVmgt+k3YgBBOTgFPT59d8TuLMVVuuJGnQ0
         g7MjALjr1zlCGsL2/68dbjoHCv0Ra55ekBCBnmi/eL4oMPinYbiKFNt083NQ0vffjxR6
         EUm5QCygJS7SoifnsiibZ5jJiSCI+v1M17V4M=
Received: by 10.114.178.13 with SMTP id a13mr7181623waf.158.1219175890922;
        Tue, 19 Aug 2008 12:58:10 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 19 Aug 2008 12:58:10 -0700 (PDT)
In-Reply-To: <7v63pw3ick.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92918>

On Tue, Aug 19, 2008 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
>
>> If the patch is acceptable, I will update the githooks doc with more
>> information, but we would like this so that you could add a hook that
>> runs your automated tests before a push would go through.
>
> I've said this number of times on this list but I guess it has been while
> since the last time I said it.
>
> "If the patch is acceptable, I'll document it" is the last thing we as
> reviewers would want to hear from the submitter, *unless* there is an
> ongoing discussion that already have established what is wanted and a
> patch came as "ok, here is a possible solution, what do you guys think?".
>
> If the original submitter does not care enough to defend why it is needed,
> why should reviewers spend their precious brain cycles to decipher what it
> does, guess what situation the change would help, and determine if the
> change actually would help the situation it might be trying to help (and
> risk wasting all this work because they guessed the motivation wrong)?
> And what assurance would we have that the change will be maintained and
> supported?

I didn't say, "if it's acceptable, I'll document it", I said I would add more
information into the githooks doc. I updated the git-push.txt doc and explained
what it did with the commit message and sent test cases.  There should have
been more than enough information on what it did in the message.

Then I sent a patch to githooks with use cases like 5 minutes later.  I'm more
than happy to defend it and replied to Jeffs email almost immediately.

> Having said that, I would agree "validate and potentially stop before
> pushing" is a very good thing to have.
>
> It is still unclear at this point what kind of input that validation would
> want to base its decision on.  At least we would want what branch is being
> pushed (so that a validation failure on a branch that is not being pushed
> would not interfere), and possibly where you are pushing to (so that you
> can still push a change you would want to verify and potentially polish on
> a different test/dev box without getting interfered).

I would be happy to add the name of the branch being updated and the remote
we're trying to push to.  Is there interest then, in the patch?
Should I spend my
precious brain cycles on adding that functionality?

Scott
