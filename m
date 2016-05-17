From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 20:06:06 -0400
Message-ID: <CADKp0px_RzPwwyFVQ6oNE6dn1QNtVUjJ9zCUSgfSn6mdkOrgfQ@mail.gmail.com>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
 <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
 <20160515212332.GB31809@sigill.intra.peff.net> <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net> <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
 <alpine.DEB.2.20.1605161526510.3303@virtualbox> <20160516133731.GA6903@sigill.intra.peff.net>
 <CADKp0px3v3K4vqNeNk7NdWZFdSCyqMa+i_Nv0wW80Tkf0C=RUQ@mail.gmail.com>
 <alpine.DEB.2.20.1605161700360.3303@virtualbox> <20160516151721.GA8678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 17 02:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2SXE-0007ZQ-3P
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 02:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcEQAGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 20:06:48 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35235 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcEQAGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 20:06:47 -0400
Received: by mail-io0-f173.google.com with SMTP id d62so3563580iof.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FQlnH7aidvlQWkpqkSFnoxmM3+tJ0LRM5VE1junQ03M=;
        b=t4mNkYWKR0OIU7axRDkYbd4zRJ62e8ktHcucra93kCJvLCnG6Ms/2plFxJnUQ0O8UI
         89OTbNLtiVgXz8NSJjjdDimWAeadHzDYvRBxppCEbSnPF2dSNulIPKmTRBjvFAk8cVpu
         +FEHKZgLBejIT2XaMsG1V+Um3dDG592k9iARWUXvyu1QfXMJxeaFs5PRJLafjroRc8FE
         7ZWKgjCYL72z5JeQ1i/aUq+oI3GNid2PUYvfNyF9ra1xE62s+9pYfrZw9X4Y82UIYkV+
         i1zx+KCDPqmi8tIJPthdmeO4g0CoXQDDAFK5RsQQAm58fYEYhOUqNBfvr6XG++dADC63
         9Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FQlnH7aidvlQWkpqkSFnoxmM3+tJ0LRM5VE1junQ03M=;
        b=j6u1ijovrv5H7Ivl64Dm3yhahmP3lkjykEN4u7G3ZmvwPPVc5Y7UhTWQ+3TsfEEDe2
         g2r9N4W4hRgbafcACQX92jEfnVtZqjphmafFO4SfHb9PHNYCP0uIOhN21gk8rUElm6RZ
         6SZZGv5fIBiaYOGL94HPYi302PWw/IZckz70iZHxilRFeKs5NOtrpHZUiiphemPNUnNg
         imgtn9VqS1tWhdaFCEluzpyDyt/kSNH8l8+l8U1sCE401igRaAFjeZGEoDqrNNdbHhO2
         Dy5Vd4+uAfNSnBJN6EdBUUPsUYQz4JTURTh5Bnx8kDm9FTeb3T0zKCc8ILhAIVo8vByM
         DaLg==
X-Gm-Message-State: AOPr4FXnG4S8eBxGcuu4artE9arn0lUf6xT09QZ4VA6/kR9IKl1wHlP4jjG8GEDjVK3tG2Do0i9vYqSjPsl3HA==
X-Received: by 10.36.82.84 with SMTP id d81mr12858033itb.32.1463443606339;
 Mon, 16 May 2016 17:06:46 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Mon, 16 May 2016 17:06:06 -0700 (PDT)
In-Reply-To: <20160516151721.GA8678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294823>

>> Once I included the whole email in my reply, but otherwise I deleted it
>> all.

> Both are bad practice. If you are considerate with the reader's time, this
> consideration is typically reprocicated. So it is a good idea to save the
> reader time by giving them the precise context they need.

This is among a few reasons I don't understand why in 2016 we use mail
lists for this kind of stuff. First time I've had to deal with this
since the 1990's so I forgot how it works.

On Mon, May 16, 2016 at 11:17 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 16, 2016 at 05:04:34PM +0200, Johannes Schindelin wrote:
>
>> > Anyway, it is not a Powershell thing. I tested on another repo on
>> > GitHub and it worked as expected. So I guess indeed the problem lies
>> > with Microsoft's implementation.
>>
>> This is *really* unclear.
>>
>> What "Microsoft's implementation"??? Do you refer to VSTS, or do you refer
>> to Git for Windows, or PowerShell?
>>
>> Please. To make it really simple for everybody involved, try to repeat as
>> closely as possible the same push from PowerShell, Git CMD and Git Bash.
>> We want to compare oranges to oranges.

As I was mentioning GitHub I assumed "Microsoft implementation" would
indicate their hosted Git service "Visual Studio Team Services".

I really didn't think there was anything else to provide. The feedback
lead me to test with Github and with that I verified that when the
remote was for Github it worked, but when the remote was VSTS it was
not.. and "not working" means not paying attention to "--quiet"
setting only with git push, while it does work for other commands such
as clone. (though I think I have to re-test with pull.)

The problem is not with Powershell (though how it handles seeing
output in STDERR is not anything I agree with). I was merely trying to
point out that 'git push --quiet' was not working until we realized it
was with VSTS.

This "ticket" if it exists as such in a maillist can be closed.

I think this accurately sums it up:

> The "bug" is that the server is asking the client to write non-error
> output to stderr, even though the client should have asked the server to
> be quiet (though it would not hurt to check that it is doing so by
> looking at the output of GIT_TRACE_PACKET).
>
> -Peff
