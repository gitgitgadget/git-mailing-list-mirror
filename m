From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Sat, 01 Mar 2014 10:50:25 -0600
Message-ID: <85ob1pyib2.fsf@stephe-leake.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org> <858usvz5nj.fsf@stephe-leake.org>
	<87txbj1fnw.fsf@fencepost.gnu.org> <85zjlb1740.fsf@stephe-leake.org>
	<87eh2n16sw.fsf@fencepost.gnu.org> <85vbvyxl8i.fsf@stephe-leake.org>
	<vpqioryrvwg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 17:50:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJn7V-00070T-P7
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 17:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbaCAQuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 11:50:32 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:58317 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750762AbaCAQuc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 11:50:32 -0500
Received: from [70.94.38.149] ([70.94.38.149:50173] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 6A/8E-02678-4DF02135; Sat, 01 Mar 2014 16:50:29 +0000
In-Reply-To: <vpqioryrvwg.fsf@anie.imag.fr> (Matthieu Moy's message of "Sat,
	01 Mar 2014 12:38:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243104>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> $ git status
> On branch master
> nothing to commit, working directory clean
> $

ok, you've lost your conflict resolutions.

>> In fact, it now seems that 'git reset --mixed' is always the same as
>> 'git reset --merge'. So I must be missing something!
>
> "git reset --merge" is an alias for "git merge --abort" (IIRC, it's
> actually the other way around). Essentially, it reverts, or tries to
> revert everything (worktree and index) as it was before the merge. That
> includes throwing away conflict resolution.

Ok.

> Now, I do agree that the documentation of "git reset" is terrible, 

Ok, good.

So is this a sufficient bug report to request that the documentation be
fixed? (I obviously don't know enough to even think about submitting a
patch).

-- 
-- Stephe
