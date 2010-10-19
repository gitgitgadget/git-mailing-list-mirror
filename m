From: Miles Bader <miles@gnu.org>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 13:49:06 +0900
Message-ID: <buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<vpq8w1v5gce.fsf@bauges.imag.fr>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 19 06:49:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P848x-00026k-7m
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 06:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982Ab0JSEtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 00:49:22 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:39013 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab0JSEtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 00:49:20 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o9J4n8V5010157;
	Tue, 19 Oct 2010 13:49:08 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o9J4n8L04819; Tue, 19 Oct 2010 13:49:08 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.50])
	by vgate02.nec.co.jp (8.14.4/8.14.4) with ESMTP id o9J4ZIXD000842;
	Tue, 19 Oct 2010 13:49:07 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Tue, 19 Oct 2010 13:49:07 +0900
Received: from dhlpc061 ([10.114.97.89] [10.114.97.89]) by relay41.aps.necel.com with ESMTP; Tue, 19 Oct 2010 13:49:07 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 39D6352E1B8; Tue, 19 Oct 2010 13:49:07 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <vpq8w1v5gce.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	18 Oct 2010 23:41:21 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159303>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> We already came up with a better wording, namely "upstream", and used
> in in "git push --set-upstream".  Probably a next step would be to
> deprecate any other occurence of --track meaning the same thing

That doesn't make much sense to me; "upstream" and "track" are not
alternatives; rather, they're complementary:  "upstream" is a _thing_,
and "track" is an _action_ -- one _tracks_ _upstream_.  "--track", then,
merely implies "upstream", which seems fine to me, as I'm not sure
there's anything else it could refer to.

I think the original post, while well-meaning is a bit overwrought, and
reflects the difficulty in learning any new system as much as it does
any inconsistency in git's terminology[*] -- Git's huge sin, after all
(judging from most complaints I see about it), is that It Doesn't Use
Exactly The Same Model (and thus Terminology) That CVS Did...

[SVN's great sin, of course, is that It Does (interpret "CVS" liberally
here).]

[*] Git is certainly guilty of using inconsistent terminology --
cached/staged/index/yada is my personal complaint -- but I don't think
to anywhere near the degree implied by that post.

-Miles

-- 
Do not taunt Happy Fun Ball.
