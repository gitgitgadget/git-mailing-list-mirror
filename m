From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Mon, 03 Mar 2014 11:12:09 +0100
Message-ID: <vpqvbvvegli.fsf@anie.imag.fr>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
	<CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
	<vpqlhwsr3ww.fsf@anie.imag.fr> <53144881.6090702@alum.mit.edu>
	<vpq7g8bfws8.fsf@anie.imag.fr>
	<CACsJy8CPhTQxpnY70PxD9zFSipaJCTQPBsmReD8E9tmEgsvTRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:12:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKPrN-0003VP-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbaCCKM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:12:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48084 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbaCCKM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:12:26 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s23AC9k1009202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2014 11:12:09 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s23ACA5C017533;
	Mon, 3 Mar 2014 11:12:10 +0100
In-Reply-To: <CACsJy8CPhTQxpnY70PxD9zFSipaJCTQPBsmReD8E9tmEgsvTRg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 3 Mar 2014 17:04:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 03 Mar 2014 11:12:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s23AC9k1009202
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394446331.22884@HfkTgOv9UyltvAn5NIZ80A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243211>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Mar 3, 2014 at 4:37 PM, Matthieu Moy
>
>> This would actually be a feature for me: I often want to rebase "recent
>> enough" history, and when my @{upstream} isn't well positionned, I
>> randomly type HEAD~N without remembering what N should be. When N is too
>> small, the rebase doesn't reach the interesting commit, and when N is
>> too big, it reaches a merge commit and I get a bunch of commits I'm not
>> allowed to edit in my todo-list. Then I have to abort the commit
>> manually. With -N failing on merge commits, the rebase would abort
>> itself automatically.
>
> would "git rebase -i --fork-point" be what you need instead?

I don't think so. My use case is when I did a manual merge, so
@{upstream} is helpless or even not positionned. There is for sure an
accurate command (remember the branch I just merged and put it on the
command-line), but my fingers prefer typing quick and dirty commands and
hope I won't get too many trial and error cycles ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
