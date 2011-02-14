From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Tue, 15 Feb 2011 08:47:00 +0900
Message-ID: <AANLkTikyc5QEou8Em-3HkLSHWHQyx+MnYMQ9OSN33_QS@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net> <buod3muswq7.fsf@dhlpc061.dev.necel.com>
 <7vtyg6tu9e.fsf@alter.siamese.dyndns.org> <AANLkTinnCLVDEZpNPVYZ2fq1BY=257BTxkzNj44-Yz3O@mail.gmail.com>
 <7vzkpyql2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp88y-0002eb-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab1BNXrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 18:47:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46591 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1BNXrn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 18:47:43 -0500
Received: by bwz15 with SMTP id 15so6043063bwz.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7E1hPDrsy1tZIFMOPLk8Jf1N8IIHLLbOqPTlzIqinsI=;
        b=aUMzRhNhSVYEY4p8IA4hdwpEUtHjRv86QtjUzOypOoKsI61CFL7M0oMzbTuZOAhFP4
         dQtIHCEXFP8N7rzMaS1pt4qqIjuj3kAFM1NcFhKHVPBWXfMV3JN0CePcyXXcZxjjpp0j
         J7bztpoSGTp3SBEZcl+hflYU0oNmWvxSf/2WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=R2F2cTmb/PQz90YyKYyqd/VRM7zTxRVnZBDDcNz6vmxXqgq4A48Ar4fKWsus0G63ZY
         sBo6V6B/kCTkmU6Ph/mq6uUlfKoeBpjtJf9onLpsFHIck9F+96uGvRrAqPz6FC4ptBKJ
         i+Ply3gOQmiL+blZcABF+8NqK85GKmfXP0eyU=
Received: by 10.204.99.145 with SMTP id u17mr3937774bkn.1.1297727262144; Mon,
 14 Feb 2011 15:47:42 -0800 (PST)
Received: by 10.204.119.130 with HTTP; Mon, 14 Feb 2011 15:47:00 -0800 (PST)
In-Reply-To: <7vzkpyql2r.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: PQU2OU7HdCsjodb7slLTdM2eQuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166798>

On Tue, Feb 15, 2011 at 7:59 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I actually was hoping that it was obvious that -s is a no-starter fro=
m the
> messages so far in this thread, as neither --cached nor its more
> descriptive spelling --index-only has character 's' anywhere in it, a=
nd we
> have been keeping --staged as a low-key synonym for a reason.

It was not at all obvious.  Even if you like --cached more than
--staged, there's a difference between advocating "--staged", and
using "-s" as a short-option for the operation which --cached /
--staged invoke.

Short option names are often a compromise, because clearly there are
often conflicts.  That _doesn't_ mean that one should simply not have
a short option, when a "perfect" choice cannot be found.  If a
"perfect" short-option isn't available, then usually one turns to
somewhat less perfect choices, trying to at least find some heuristic
that can make them easier to memorize -- because in the end, short
options must be memorized (and if they are truly common operations,
this isn't generally difficult; it's memorizing _rarely_ used short
options that's hard).

Of the various choices, "-s" does at least have such a heuristic
connection to an appropriate long option ("-i" is arguably worse than
-s, because it doesn't have any such connection...).  Can you suggest
something better?

[BTW, isn't the name "--index-only" something of a misnomer?  If
something is called "--XXX-only", that implies that the default
operation uses "XXX + something else" instead of XXX, but that
otherwise they are the same.  However in fact the difference in
behavior resulting from --cached is more subtle: it changes _both_
sides of the diff (default: worktree<->index; --cached: index<->HEAD).
 The names --cached and --staged actually capture this well -- they
basically say "the default is worktree changes, and --cached/--staged
diffs cached/staged changes instead" -- but the name "--index-only"
does not.]

-Miles

--=20
Cat is power. =A0Cat is peace.
