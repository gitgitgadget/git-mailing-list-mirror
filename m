From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: notes metadata?
Date: Sun, 7 Feb 2010 12:50:14 +0100
Message-ID: <cb7bb73a1002070350j750287abl43de4d936a47acef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 07 12:50:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne5fF-00013N-L3
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 12:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933495Ab0BGLui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 06:50:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:17154 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242Ab0BGLuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 06:50:37 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1133869eyd.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=jfNQXjphPQ/FK1gS+S6XJxeYHuNsi144bvEEoQB1ugc=;
        b=RfaQ1ehPTkQbN4n0D6MI7VHkz4dkpDOklDvBAKdTlCSdYSMA8XsaJWgKgoc9ecrJYa
         I03f1NRgyux7FzeehVVV4QOtdub1wOiasStq62dYXVowtr9/g2gl0KCe8C2YksrPUnRp
         7tPXuhmu1qEGIYeckb/MZ86gcMYcu6KVh0K+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=DX8KAY3zrZmzWtnNhyy8Zmb5v+1vxg5f+nUFLqxOgspcsaIHhMDu/YpcGrphCTNlr1
         JbEoHRoQPhMaaJkGsVOpDNttZyM7l9tdKtmXHFRWmOch3uxcZAK+NZDfYhb1qy9rMpRK
         9y5SJ/rph3Wprc1a7TLJ7eqzxPHKDdMidNcBA=
Received: by 10.213.42.79 with SMTP id r15mr2582770ebe.94.1265543434156; Sun, 
	07 Feb 2010 03:50:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139235>

Hello all,

ok, this may sound a little odd especially with the 'notes vs
metadata' thread going on, but I was wondering: do we store _any_ kind
of metadata _about_ the notes themselves? If I'm reading the code
correctly, we have neither author nor date information about the notes
themselves, so we don't know who added them or when. Is it too late to
suggest that this kind of metadata be added to notes? Making them
full-blown commit-style objects is probalby overengineered and wrong
under many points of view (not to mention probably incompatible with
current storage), but maybe we can set up a convention that notes
SHOULD be in pseudo-mbox format? This would mean that when a note is
created, the template starts with a 'From ' line including the user's
name &  email and note creation date; when editing, the note is again
augmented with the new author name email and date. Of course the users
are then free do expunge the From lines if they don't want it (just
commenting it would be enough, of course). How does the idea sound?

-- 
Giuseppe "Oblomov" Bilotta
