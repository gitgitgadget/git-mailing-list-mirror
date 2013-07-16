From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Tue, 16 Jul 2013 10:13:28 -0700
Message-ID: <CAPc5daXZxkLOJwzaoSMZvJ87zYvns1MeYZU=RoEK=CQYP1qpag@mail.gmail.com>
References: <20130715164658.GA8675@bottich> <7v61wba3gu.fsf@alter.siamese.dyndns.org>
 <20130716082413.GA27283@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 19:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz8p4-0000Jq-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 19:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab3GPRNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 13:13:52 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:41107 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab3GPRNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 13:13:50 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so733759lab.21
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Dz7PzuAIRiXD4mb1wi1kl3PUzpdJM5RNELz9Z6295xM=;
        b=VQ3qJSEmQpxuWG5xmu9jXAN7aKdd8kvg2RwY7/AxNZpFB2gfA0YxsfxbIM103rV72q
         XSsqLOOgiQxXC7EZm4/W0zv8NojZWo5kvYXUHDw4k1sJi4lo2QjJaYWphcJRKD4jaBaT
         CgZ+mW0Tafh5A+RH+Wsn5CfFBpwWFF8yORUOi4qSpJQMPyqu+Sdk8x33dy/9jodltTCh
         v0lh5iTwdr73ZRFx8/685hZoFAa0DvoB2fMzNpEP68CTLLdm6Cy0O0ewCEiqNmWyZl14
         xfpKFqtM3AzvS/vEqJLqtQ7j5fxiPLvMPzBrH5N8aDJFUlphGYqO/PYEOBzVNGWSIDMw
         nkWw==
X-Received: by 10.112.29.17 with SMTP id f17mr1545967lbh.20.1373994828550;
 Tue, 16 Jul 2013 10:13:48 -0700 (PDT)
Received: by 10.112.64.73 with HTTP; Tue, 16 Jul 2013 10:13:27 -0700 (PDT)
In-Reply-To: <20130716082413.GA27283@bottich>
X-Google-Sender-Auth: Geq-N_JSboVflRdMgODXJAlv0po
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230565>

> Why would you want to limit those files to be source for HTML only?
>
> The HTML after this patch is still fine.

Have you thought the reason why the formatted result _before_ the patch is good?

These *.txt files are asciidoc formatted source files. They are meant
to be easy to read and edit without distracting mark-ups (unlike roff
and html), but with one big precondition: your tab-width ought to be
8. That is how asciidoc expands the tab when producing the formatted
output, and that is why the formatted result _before_ the patch is
good.

Expanding these tabs to all spaces do not buy us anything, other than
source code bloat, and with one downside.

It would give a false impression that it somehow is OK to open these
*.txt files with a wrong tab-width setting, and even worse, edit them.
You may even type a new tab yourself to indent by 4 places, and
formatted result will be broken by such a person.

It would signal that your tab-width setting is not suitable to
view/edit these files if the elements in the illustration do not line
up. View it as a bonus safety feature ;-)
