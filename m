From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Wed, 15 May 2013 00:55:43 +0530
Message-ID: <CALkWK0=fr6413jY0wEf061y6Q_1MOksuWWBFuKhgdhphPHY-Cw@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <7vwqr1jw67.fsf@alter.siamese.dyndns.org> <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
 <7v8v3hjt57.fsf@alter.siamese.dyndns.org> <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
 <20130514191757.GP3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKro-00035H-R6
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246Ab3ENT0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:26:24 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54374 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212Ab3ENT0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:26:24 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so1917832iec.34
        for <git@vger.kernel.org>; Tue, 14 May 2013 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=thOQ2OuwAaHe35/d3ibftmX3w447gDPyGHf8DZG8KRE=;
        b=riYDC9rthNHROBqwECNvTXHu7skJZV8wWr50TeBeataiFRla/NytLLdGfhRoWh7kCs
         Mf3MSMlBeJ8ulF13TdqcIYEQB+CroiGk2mMMwZSfDmr+Jwl3D0syBjjIjhzBjKqSdEhs
         Jx5GbeczyW5R5yCC/MhRWXEn6jUgHDpRxeiJI8JadjCTcftiwSKSJJzV1aw4e/joZQ3k
         9SiKXDh4wy8aX1L7YcOD19ESIPwWBwQaLjuuFXfkbcH09YpfJm/IOfi8O4Nd/Fgziagx
         h2kSTXCgPyji0Cnt70Aulv7QJFJGfgF9gCVmpQMOesM1guiTpWjWFCehkRhfBTR/tBup
         Jrxg==
X-Received: by 10.43.68.134 with SMTP id xy6mr12520611icb.48.1368559583654;
 Tue, 14 May 2013 12:26:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 12:25:43 -0700 (PDT)
In-Reply-To: <20130514191757.GP3657@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224321>

Jonathan Nieder wrote:
> Write a better shell?

Shell, editor.  Both are very hard problems, and the successful
projects last many years (emacs, zsh are over 20 years old).

> Teach "git gui blame" to blame on arbitrary
> regions instead of single lines?

Or in my case: get magit to do log -S.

Should we mention in the -S documentation that temporary shell script
is the way to get multi-line input?
