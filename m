From: Miles Bader <miles@gnu.org>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 8 Jun 2010 09:25:07 +0900
Message-ID: <AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
References: <20100605110930.GA10526@localhost> <vpqljas5e33.fsf@bauges.imag.fr> 
	<20100606164642.GA10104@localhost> <buobpbnz6mh.fsf@dhlpc061.dev.necel.com> 
	<20100607185439.GB17343@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jun 08 02:25:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLmdJ-00059m-GT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 02:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab0FHAZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 20:25:28 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:36019 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0FHAZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 20:25:27 -0400
Received: by pzk15 with SMTP id 15so85575pzk.15
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=f7xAKky6hkgTXKxEcz5cJ7XFVIcUJqDkttJiRUM6b4k=;
        b=bAFgHN0WvpmVc/mwMj9k0jS4U2bWraAJFnC2mK9SG/fUIuQFgkYZj0czbz8XrGdVxV
         a57nLkPaMv14k05wJ4qJ7lssfOo4Ilgk9/XXE8rbbNMPOOGDSsx1Dtzy2fUfxGFtqwE7
         jspkyBcYECv+5ZLaRICUoynN9AkdWpg208aVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=cN/UapuT1P/f7k/ZFyKeaTdciZPrtyl00Wfo6TAvmTnN3ThKyu4apjXTgx3xydLHjb
         6qD1rZd9Xg/PdHf34at5aQx0i3bMM7yTu/QIyv+ABlYTeCf0CbExbD+MtYEldt6enc7s
         e7CY6ML7sIo+XrOZ/c8xN6cigR68BWa5gdzio=
Received: by 10.142.201.12 with SMTP id y12mr623196wff.174.1275956727134; Mon, 
	07 Jun 2010 17:25:27 -0700 (PDT)
Received: by 10.142.144.10 with HTTP; Mon, 7 Jun 2010 17:25:07 -0700 (PDT)
In-Reply-To: <20100607185439.GB17343@localhost>
X-Google-Sender-Auth: INXUAAHY2JDWVl0TTsZKFXve_4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148636>

On Tue, Jun 8, 2010 at 3:54 AM, Clemens Buchacher <drizzd@aon.at> wrote:
>> then be annoyed that they had to type all those boilerplate args when
>> git clearly knew what they wanted to do... and that would be the case
>> every time from then on...
>
> Why should the user make the same mistake over and over again?

What I mean is that every time thereafter that they want that
functionality (making a remote branch local), they'll have to type the
"long form".

> And it makes me sad that you think it silly to even talk about it.

I don't think it's silly to note your concern, I think it's silly to
put a fair amount of effort into a campaign for its removal, which is
what you are doing.  If new points can be made, fair enough, but so
far it seems mainly a lot of back and forth stating the same things
over and over.

> I believe that it's because of things like this that many users
> still consider git to be complicated and hard to use. That's what
> really bothers me.

Why do you think that?  I mean, you could be right, but it's certainly
conceivable that this feature causes users to consider git _simpler_
to use, because it lets them think about local branches only.

-Miles

-- 
Do not taunt Happy Fun Ball.
