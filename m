From: demerphq <demerphq@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 8 Jun 2010 09:47:07 +0200
Message-ID: <AANLkTimOenmDE53LZJY2yVNkMh7-6PS3yBiaprWC_Po6@mail.gmail.com>
References: <20100605110930.GA10526@localhost>
	<vpqljas5e33.fsf@bauges.imag.fr>
	<20100606164642.GA10104@localhost>
	<buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
	<20100607185439.GB17343@localhost>
	<AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
	<20100608072958.GA24302@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jun 08 09:47:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLtWo-0005n2-RN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 09:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab0FHHrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 03:47:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60317 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab0FHHrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 03:47:08 -0400
Received: by fxm8 with SMTP id 8so2631719fxm.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TG9+6dms0w3HOZvlekJ8OwxbcC6QB0VRSXWwL1HvLgY=;
        b=b1AIfj6H7TBxF/q09m2R7sQUubEpBxrwWITmY1Cu/5SPsoq/NU5XoplIxxfcaXLEYa
         wky/YfQ/tySxosuHrq/vrWHsObyhbjcOTxHS353Q+JUK/e8vIVDzKR3y+NS497nH6khG
         sCQZ2/1rGem5ajIegMQCYPiCNxWdi88wKilvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Dv/843chiuTZjvW36b5cVBZWhWO6R2CboOzRElSHOhfP8eKlzRRAINYxbFrr5a/cV6
         two7BH6p7wO/ggY0r1EPOLs/1258bVsyvig9xljSdytatr2J/9EQhQg98nfTevTh9YQG
         +DIk9F0PVBY3IIrHBTYNlBtjUlQ84pmMmG8ug=
Received: by 10.239.182.2 with SMTP id o2mr1146357hbg.51.1275983227357; Tue, 
	08 Jun 2010 00:47:07 -0700 (PDT)
Received: by 10.239.143.140 with HTTP; Tue, 8 Jun 2010 00:47:07 -0700 (PDT)
In-Reply-To: <20100608072958.GA24302@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148648>

On 8 June 2010 09:29, Clemens Buchacher <drizzd@aon.at> wrote:
> No they did not, because last time they _created a branch_.
> Eventually, if they are lucky, they will learn in #git that they
> were supposed to "git merge <remote>/X." And they will think "WTF?
> Why do I have to _merge_? And what's this business about remotes?
> Why is git is so complicated?"

I'm confused. Wont they actually be told:

  git checkout $foo
  git pull
  git push

Why would they need to do a git merge $remote/X?

The only reason I can think of is that they are doing cross branch
merges, but then they are by default beyond the novice user and can be
expected to know various things, and to have read the docs.

Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
