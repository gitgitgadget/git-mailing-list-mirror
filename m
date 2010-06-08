From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 08 Jun 2010 15:04:18 +0200
Message-ID: <vpqaar5r7zh.fsf@bauges.imag.fr>
References: <20100605110930.GA10526@localhost>
	<vpqljas5e33.fsf@bauges.imag.fr> <20100606164642.GA10104@localhost>
	<buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
	<20100607185439.GB17343@localhost>
	<AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
	<20100608072958.GA24302@localhost>
	<AANLkTimOenmDE53LZJY2yVNkMh7-6PS3yBiaprWC_Po6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 15:08:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLyXA-0002cj-5A
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab0FHNHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 09:07:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:63813 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556Ab0FHNHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 09:07:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o58D4IFK019870
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Jun 2010 15:04:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OLyTa-0000Ia-Pk; Tue, 08 Jun 2010 15:04:18 +0200
In-Reply-To: <AANLkTimOenmDE53LZJY2yVNkMh7-6PS3yBiaprWC_Po6@mail.gmail.com> (demerphq@gmail.com's message of "Tue\, 8 Jun 2010 09\:47\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 08 Jun 2010 15:04:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148667>

demerphq <demerphq@gmail.com> writes:

> On 8 June 2010 09:29, Clemens Buchacher <drizzd@aon.at> wrote:
>> No they did not, because last time they _created a branch_.
>> Eventually, if they are lucky, they will learn in #git that they
>> were supposed to "git merge <remote>/X." And they will think "WTF?
>> Why do I have to _merge_? And what's this business about remotes?
>> Why is git is so complicated?"
>
> I'm confused. Wont they actually be told:
>
>   git checkout $foo
>   git pull
>   git push

Right. Just like they learnt clone/push/pull before knowing about
remote and tracking branches, because clone did the magic for them
when creating the repo.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
