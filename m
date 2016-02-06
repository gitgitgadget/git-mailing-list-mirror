From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 12
Date: Sat, 6 Feb 2016 23:07:05 +0100
Message-ID: <CAP8UFD2mKVwiTO9kMQ3HW_kczf2XeqajP-DqOM7qA=wHAS9=gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Eric Wong <normalperson@yhbt.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Howard Chu <hyc@symas.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 23:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSB0d-0000FH-NS
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 23:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbcBFWHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 17:07:08 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33333 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcBFWHH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 17:07:07 -0500
Received: by mail-lb0-f169.google.com with SMTP id x4so67477444lbm.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 14:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=d9blWjEXZpFOFqtz2kPRQAA1oX9I+S/XKWp7t933Trg=;
        b=rp6fgEHnY+6PhGb0qElfkKT0HrgXU4/nnXeUONA9baxadXD4UlKRo3YmXB7hgfrU9q
         JLVL7FiGiVgRtCIBHdBoLf5IHayI9mRAGeh8dNEIGVfcf9/FJd8rAK2Ma95iuxbN2vMk
         bKkpsrJMGsfd67PogPQwZu+1hV6IYkd/eHvsQLCQrI9YJGXy0leAAe7eTnYtg+37Jbxa
         AMq/rsqJ3wEVt9wu/r6XjdmB8cVkZM4bQ3jLa47C4FCMkRpCwA7KDrFNoGTpL96zUvtn
         xJ5bBcvqgZ+N9u3A+oYcGv6NeQrCKQKhVYm3WPpg1SEVCNqo1ybhXr5S7FKkvGN6Bmet
         LgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=d9blWjEXZpFOFqtz2kPRQAA1oX9I+S/XKWp7t933Trg=;
        b=OpSoK3ebGazbqgxEQ4rq4WyRyFjXSOt28/R3QR9+XMWqgxdAdTkxpwCot2NiZqpr3Y
         V+fgJ9a1QgEZpQrKP55Gk6hGnmfIHizOlC7HL3sLZBUWoZlQY+Dv1ERcxBMsWbdTpHa1
         oNULp+jsXbxz49Z1szPyVmR19xYk2PbumzfqHTt8ycumM2d0uJfqGHvIYcTkn9oSkcgW
         +Wp+hAXOAQ9T4YB9e5WfmmftBi9DGQFRhKv4nNqpmxd6EwD0lAAgY1aDlZmh2zMthe/e
         EwG0ed4jI4w7xddXmsz5mORHqJERirJpdCpjcisH1QCI37Om3x+qFGZWXqoUDm2TaCYN
         Jzwg==
X-Gm-Message-State: AG10YOQ7s5BvH57hoi0TZjjIdAeHWJXFTaAd8hOI5+xjj9QW16eAU9oPBC1S47bn0UIuoRw/AiOkmyHZkcK0SA==
X-Received: by 10.112.168.5 with SMTP id zs5mr9101308lbb.56.1454796425368;
 Sat, 06 Feb 2016 14:07:05 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Sat, 6 Feb 2016 14:07:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285705>

Hi,

A draft of Git Rev News edition 12 is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-12.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/118

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
the 10th of February.

Thanks,
Christian.
