X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 17:08:52 +0100
Message-ID: <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 16:10:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31995>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYBz-00016S-VD for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934410AbWKUQJs convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934411AbWKUQJs
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:09:48 -0500
Received: from main.gmane.org ([80.91.229.2]:45232 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934410AbWKUQJr (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:09:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmYBg-00010f-MP for git@vger.kernel.org; Tue, 21 Nov 2006 17:09:32 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 17:09:32 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Tue, 21 Nov 2006 17:09:32 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-11-21, Santi B=E9jar <sbejar@gmail.com> wrote:
> On 11/21/06, Andy Parkins <andyparkins@gmail.com> wrote:
>> Hello,
>>
>> I'm sure this one will be known about already.  git-show --stat on t=
he the
>> first commit doesn't show anything.  I assume it's because git-diff-=
tree has
>> nothing to diff against (although shouldn't that be an everything-ne=
w diff?).
>>
>> Given the above; does anyone have a suggestion for what I could use =
as a
>> replacement?  Even just a list of the new files would be useful.
>
> $ git show --stat --root
>
> In general the initial commit diff (or stat) is hidden, but perhaps i=
t
> make sense to show it in "git show", you asked fo this specifically.
>
> Santi

Why not make --root the default? I also stumbled over this behaviour an=
d
even asked on this list.

In my opinion this will help new users which are supprised that they
can't get the diff of the inital commit (which is totaly non-intuitiv b=
ehavior).

And one less "wart" to clean, which another thread is all about. :-)

Peter

