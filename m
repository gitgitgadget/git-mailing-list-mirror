From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 11:27:46 -0600
Message-ID: <85vbvz171p.fsf@stephe-leake.org>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org> <vpq38j3z1jj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 18:27:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJRE2-0007Bg-G2
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbaB1R1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:27:50 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:40567 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752460AbaB1R1u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 12:27:50 -0500
Received: from [75.87.81.6] ([75.87.81.6:49274] helo=TAKVER)
	by cdptpa-oedge02 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id D7/E0-30151-417C0135; Fri, 28 Feb 2014 17:27:49 +0000
In-Reply-To: <vpq38j3z1jj.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	28 Feb 2014 16:42:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.130:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242992>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> So it appears that adding a file _does_ tell git that the conflict is
>> resolved.
>
> Yes it does. Git _knows_ that you consider the conflict to be resolved.
> It cannot know how happy you are with the result.
>
> Similarly, in a conflicted merge, the last "git add" does not trigger a
> commit silently. And a silent commit would be much less serious than a
> silent data drop.

Ok, I see your point now.

So a message "merge complete; you can drop the stash" would be the most
git should do.

-- 
-- Stephe
