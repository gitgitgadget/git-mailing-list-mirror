From: Miles Bader <miles@gnu.org>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 8 Jun 2010 16:52:40 +0900
Message-ID: <AANLkTiljpUDEYKar1ni-lvTMvGEKvM5o7cb95qn798Ok@mail.gmail.com>
References: <20100605110930.GA10526@localhost> <vpqljas5e33.fsf@bauges.imag.fr> 
	<20100606164642.GA10104@localhost> <buobpbnz6mh.fsf@dhlpc061.dev.necel.com> 
	<20100607185439.GB17343@localhost> <AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com> 
	<20100608072958.GA24302@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jun 08 09:53:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLtcS-0000SX-Q9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 09:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab0FHHxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 03:53:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38304 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab0FHHxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 03:53:03 -0400
Received: by pvg16 with SMTP id 16so1770663pvg.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 00:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=50cluLB2uakjWoliMKeDNRXYHplu+lwEj4y3Q7LPQpQ=;
        b=LltwEPz/lVcTswK/4B4dtbjjWMp130u0x47lQxISkV2tmXUhPQzCGbSz3M7McN+CPk
         46vtWIuiVbA/a5cQrQvDP5s8ROUF7QbIJq5FMX6kAfUfAapRjkZI7fb4x19Y628wQ2Qv
         5g5EIpSTPNO0scVr31Y/JR8+xOd/k17ubPrac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=YLCa+RjFLQHsrPGPnRFwEotcTaDTHqcQAOeoRbMhStPwXTmidzZxL0Om55aCQbwSDh
         ug7MhWuMO/luppvy8ZbzwBaXBlheFxz+klNUxn9NlLF0HXL8l9RmLSNCvOnX5wopDNyp
         VIHjgcanKSQ8yGEHaoTwlKXmuC7Yw7GR4ASuc=
Received: by 10.143.27.16 with SMTP id e16mr11717658wfj.24.1275983580240; Tue, 
	08 Jun 2010 00:53:00 -0700 (PDT)
Received: by 10.142.144.10 with HTTP; Tue, 8 Jun 2010 00:52:40 -0700 (PDT)
In-Reply-To: <20100608072958.GA24302@localhost>
X-Google-Sender-Auth: kAYBoudb2wSslqFSceiov6ADgYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148650>

On Tue, Jun 8, 2010 at 4:29 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> Eventually, if they are lucky, they will learn in #git that they
> were supposed to "git merge <remote>/X."

They don't have to do that, they just have to do "git pull".  This
concept -- that to get the latest changes, one pulls -- is something
people learn very early.

So, in fact it seems quite natural -- you switch to a local branch
with "git co branch", and then if git tells you it's not up-to-date,
you "git pull".  All nice and smooth and simple and standard.  The
DWIM simply makes the first time less clumsy, and while everybody
benefits, beginners probably benefit a bit more.

-Miles

-- 
Do not taunt Happy Fun Ball.
