From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] Fix invalid revision error messages for 1.8.3
Date: Tue, 21 May 2013 23:46:24 +0530
Message-ID: <CALkWK0mJMUYe1GpGXQ+mw-ZomODuiO5KqbrwgskTMek1O3WexQ@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
 <7vy5b8p9wm.fsf@alter.siamese.dyndns.org> <CALkWK0nXbncV4bjHLSQCu21w36vQP5E9irNhBbyXoEZ4-oqfcQ@mail.gmail.com>
 <7vk3msnrlf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 20:17:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uer7X-00048y-HX
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab3EUSRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:17:06 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:56074 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab3EUSRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:17:05 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so2627319iea.18
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M3iVNsNOPlwvS6RkgHNh7Z+/Wpz6i5zEDEvIy90inuY=;
        b=OYPN8PkQEf+/ctn3yefnUzZksA8LS4U64Ibimr+AmSfC1TxOZLwSlXZp3pyiIOy6+j
         P76RWTU4WVI0IZfpEj1XdbXO9O4+UWRmIy0w/IA2GGwg0Npawj2MSnq/PGaho8zkgKN7
         n3PoVrP9IJ0csTg1S/A8uH13Nr8+El5U/A8YcP8HFyd3LS9KAx4lmFgrf0bvlKQIi43d
         ty2QtJxMQPSH0hQ54YvvOVQdq2myW/Xoi1sGQ8PUElEPOk8HksMXyL8MQNSQI6h9/El3
         Nc6ZLgstF4t/sEmRGAh6TtizeVRVBECo4U9OiRfqfhzp8PEst6uABT9skhIv8+NtOewM
         BwoQ==
X-Received: by 10.50.66.140 with SMTP id f12mr2095497igt.63.1369160224603;
 Tue, 21 May 2013 11:17:04 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 11:16:24 -0700 (PDT)
In-Reply-To: <7vk3msnrlf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225059>

Junio C Hamano wrote:
> People have _already_ seen and lived with these issues in released
> versions.  Changing it may or may not be getting it back to the
> state to that of an even older release, but at that point the
> differences do not matter.  It is a "fix", too late for the kind of
> regression fixes we focus during _this_ -rc period, which is about
> regressions between v1.8.2 and 'master'.

Makes sense.

On a related note, I really wonder why people run anything < master
git; it's so easy to compile and use from ~.  The idea isn't insane at
all: most people run a -p ruby from ~ using things like rbenv (yes, it
compiles from source).

(ofcourse servers have to run a release)
