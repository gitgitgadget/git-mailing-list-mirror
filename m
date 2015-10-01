From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.6.0 apply --cached failed
Date: Wed, 30 Sep 2015 22:57:46 -0700
Message-ID: <xmqqzj035dwl.fsf@gitster.mtv.corp.google.com>
References: <CAHtLG6TxAZsd54g+_eH2R3M=5oZ65V5cJ-0kkBt4vjbga+h9rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 07:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhWsN-0007W0-5v
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 07:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbbJAF5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 01:57:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36334 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565AbbJAF5s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 01:57:48 -0400
Received: by pablk4 with SMTP id lk4so63232087pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/Ca9QdKZgaA7Q6rj4+AO/Zdu64zIGskz24IZunK46Ig=;
        b=hVDg3DzXTW7rnsttRN5Ru8c39T/B3kAVEJpZ8fMwGhBB/hmqRfhJ+0GGYyOpVjKn/O
         3uTLG7ZACTWMQt8DWRQ+niVv87yIcD4RGtYKxugOLaruLN3f6ErlmxKp+cdiypQBRwzj
         i4GyqWaZ9+zRgt3seaVpolGXsu2I/M90L5GO4lHQAINYV0S4Fu9XweII/b2QJAA/9Bp3
         nnBs1lg1voSzMR5qoRS4vDQm88h/oD70MrN243IwbYbzSuL4scGa1VbCXCIAdL8uVwUf
         3A4xnTn1BqDoyGbGCl9zCXQLqGCDnjMXdd/DtoEsd4oaWxNe19IFCQfGX1ACiIYBOR0+
         612Q==
X-Received: by 10.68.202.66 with SMTP id kg2mr9723342pbc.81.1443679068153;
        Wed, 30 Sep 2015 22:57:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b504:7e09:d70d:e9ec])
        by smtp.gmail.com with ESMTPSA id on5sm4112269pbb.65.2015.09.30.22.57.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 22:57:47 -0700 (PDT)
In-Reply-To: <CAHtLG6TxAZsd54g+_eH2R3M=5oZ65V5cJ-0kkBt4vjbga+h9rQ@mail.gmail.com>
	(=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Thu, 1 Oct 2015 13:38:17
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278888>

It probably is this one:

    http://thread.gmane.org/gmane.comp.version-control.git/270370/focus=270501

Older Git was loose and did not notice it, but the second hunk of
your patch is judged to be broken, with no added or deleted line
whatsoever, by the latest version.
