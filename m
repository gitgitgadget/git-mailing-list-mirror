From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon, 28 Feb 2011 00:01:55 +0700
Message-ID: <AANLkTimO8U5Lp7GkMf0K_v5hKvBktfEbnZTW=AZn_71u@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org> <AANLkTimox7NhBsp9V=9p4hooeB-sprV21UbUFtzf+-Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 18:02:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptk0t-00011f-7z
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 18:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab1B0RC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 12:02:27 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50429 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab1B0RC0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 12:02:26 -0500
Received: by wyg36 with SMTP id 36so2988131wyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Ococ+Vbj37ES0GgUsOHy8Epd3yvL3tILlSBcTcGo2W0=;
        b=SakXhnWZlksNWB8FDgh3r02fAUwGIGxwy5bYrMP3RKQ4Tv93T2Ms8CSRIfDZgUAmjB
         I6COS6ZpYdCj5sRWpDYmkKfzu0PjsBqvysX7ttmE2JagxfZ+F38gWOrENRrMlf0lRx7k
         2FaoKDPptNgCb+qKKlkIHBksyhx9Odp9pK7Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=achH1jhAYw7TKC0Z5D606+Vdgq+Fl2oS9xVFWeYDl30J9JCVxZY3pImvza+TeLlSbb
         aqhuaUdKAglc+SE/iTKwLb/CrBvUsAMPm/COoy27xdh9hwdnlY7bpE3mpo86jW1jvNJl
         E8Q5WnrZtb+hMnOU1HNfrA9TlKkpDW9KX2vrE=
Received: by 10.216.24.135 with SMTP id x7mr1428548wex.43.1298826145075; Sun,
 27 Feb 2011 09:02:25 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Sun, 27 Feb 2011 09:01:55 -0800 (PST)
In-Reply-To: <AANLkTimox7NhBsp9V=9p4hooeB-sprV21UbUFtzf+-Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168045>

On Sun, Feb 27, 2011 at 8:35 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Sun, Feb 27, 2011 at 11:46, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C2=A0* Ship this as 1.7.X and see how well the new feature is accep=
ted in the
>> =C2=A0 wider user community. =C2=A0If the feature is not widely used=
, there is no
>> =C2=A0 point in proceeding further.
>
> I'm confused, I thought we were doing this for consistency reasons?
> That would benefit mostly new users, right? New users, which are
> unlikely to notice this new feature, or report to this list that they
> find it useful?

I think the purpose is to see if this benefits current user base
first, which is large enough. If it beats the user base hard, it's not
worth adding even for consistency. Unfortunately not all of us users
reads release notes. I don't know how we know it's widely used.
Putting something like this in docs?

"This is experimental. If you use it and like it, raise your voice in g=
it@ver"
--=20
Duy
