From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 20:48:37 +0530
Message-ID: <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URlBn-0005vh-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab3DOPTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:19:23 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47173 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3DOPTW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:19:22 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so6049073ieb.29
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jN6ZfD4f81IaYhz09Pp3G5YerzWIOHYNiR6lHx5yKtU=;
        b=VlFuv/7WOin/miJFIAt7FYldsAn3ePZFZw7FElIqTRvo8bXFTPZcCqLi68n3NLfQ/s
         BuaJPpR6ANf1oe4r4KkzatE3VGnXZjRKgr6gh9svKA6qdpt2EC+p32wcl3yl8I4b4WOC
         fjb4Mfjw2qZb40LVJmOvWvwRkOBNxmL3ANPQeU9z73LQWt3nQK6mMsujx8IGL5be5DS/
         VfYUtRjMC+lRCSRJF0jzeNsV07ukVy0xSeHGl/ad+gVqSPFcPrrLpsL+jokvdWp4aJiC
         rx7OUmsVeheg6Ov5zGqVqOfqzMLAAEuIlRx7FyMv7MSherNx1Iqb6w77rvvJ/3EyLkWJ
         wMgA==
X-Received: by 10.50.17.71 with SMTP id m7mr5656943igd.14.1366039158649; Mon,
 15 Apr 2013 08:19:18 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 08:18:37 -0700 (PDT)
In-Reply-To: <vpqobdg515m.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221238>

A few small personal itches off the top of my head:

- Make git status -s show "state status" as well: this essentially
requires writing an equivalent of wt_status_print_state() for use in
wt_shortstatus_print().

- Make the -s and -b switches in git status configuration variables.
I currently have status aliased to status -sb, and this is less than
ideal.

- Make the -3 and -c switches in git am configuration variables.  I
have an alias.

- Create an advice.ui (like color.ui) to turn off all advice.  I don't
need advice.
