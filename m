From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 16:12:48 -0500
Message-ID: <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Thu Mar 18 22:13:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsN24-0007TH-EU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab0CRVNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 17:13:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:54936 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab0CRVNK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 17:13:10 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2834108fgb.1
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3Vlci4++JHRcYg3tC9qBDZ3x4aQWoMcSi6ovZKHjJzY=;
        b=B6GsiBJoM2W1JoB7CpHML38UrqWccRL6UW65TI04pnexuqW+k2CIUqRWNAbwcRIcxk
         2ueTfRe+GJmW8sHo2XE/fXZlEt15F5KkayLPj1sKrd7DqoUlHsdoNfApCDQt5i7q+ppc
         UIIQQ9ZoubhhlsrYPw9Blp1EgxwKi37X2VUPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PNhMhBll5cynUIVWtsZbPieQLB95PS8FtAJ0xosUGR6nRR2rVbHRmlrHTrVbwkqP7s
         V9ijRnLdfGZGnb/fUMSWyOUq3b4WNXyDvDoxFTN6j0FpkLB3qM6M+l/Um3o2FYHXoVm1
         kdRoaWC5VMMOWPZrALnQy8JLj9U/Z1tml8qzM=
Received: by 10.239.170.139 with SMTP id s11mr1498040hbe.99.1268946788137; 
	Thu, 18 Mar 2010 14:13:08 -0700 (PDT)
In-Reply-To: <20100318204416.GM8256@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142520>

On Thu, Mar 18, 2010 at 15:44,  <tytso@mit.edu> wrote:
> =C2=A0 Hi, I'm <dd1b51a1-ce2a-41fd-ae89-f68b7f0ace85> and here are th=
e things
> =C2=A0 that you need to fix with your patch....

Look, there is a huge misunderstanding.

This is all that I'm saying: Keep git exactly the way it is, but add
one extra piece of identifying information for each person.

That's it.

Nothing is being taken away.

You can still see/grep/access the full names and email addresses just
as before, only now there will be another piece of information on
which to filter (or ignore it if you want).

In the most general form of my proposal, the idea is to let the user
choose some piece of information that he himself deems to be uniquely
identifying over a long period of time. However, I think it would be
smart to reduce that information to a SHA-1 (at least when it's
recorded in, say, a commit).

Essentially, the goal is to distribute the task of maintaining aliases.
