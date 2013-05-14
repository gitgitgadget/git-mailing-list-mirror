From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 23:50:42 +0530
Message-ID: <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com> <7vwqr1jw67.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJqz-0000Ay-7o
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064Ab3ENSVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:21:25 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43738 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab3ENSVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:21:24 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so1763182iee.13
        for <git@vger.kernel.org>; Tue, 14 May 2013 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RAn5tFxIMYW/jrOKbTGhyKZj5NfBt39snuPegnKQ3es=;
        b=nHJaePetcTipYa0O/iE+2TCsWkTYX8wdI6PRUXBCJYn7c8ML2alDqFKg0nkwIEtWiX
         jHcIfsLMnWwlbNoszCiXFmjgX9c8uKhCjXAuPyb2Xl6MsQ0D7i+byQE97p5frDDsdoG3
         k1qWPHE5V+rj9VV085cg2Nz7/enNBxgxHOBeZ5PEo9n8ipGhGVN6No7ovn0WV+A4KBGi
         RWqM1VsI/wpD+pZKrh+zmx+wnHX6CSuhbupZ43fvse66OrzSc4efnueIhJqKp93x3lzN
         Lust7MGN0FNuQsMZ7Dsg6T/csT04LHR+U0sEgRgUjnhiAqukh42xt4ZbGxMuVH2pFAX1
         xq3w==
X-Received: by 10.42.27.146 with SMTP id j18mr17987820icc.54.1368555684002;
 Tue, 14 May 2013 11:21:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 11:20:42 -0700 (PDT)
In-Reply-To: <7vwqr1jw67.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224311>

Junio C Hamano wrote:
> Any time you say "This means that", "More precisely", etc. please
> check if you can rewrite it to lose everything before them (i.e. a
> vague sentence that needs to be clarified may not have to be there
> at all).

Right.  I thought both are necessary in this case: the first sentence
gives easy information to a first-timer.  For someone who has played
with it a bit, and wants to know more: the second line.

>> ++
>> +It is often useful when you're looking for an exact string (like a
>> +function prototype), and want to know the history of that string since
>> +it first came into being.
>
> I think you should remind that the most useful case (and indeed the
> intended one) is for "an exact string" to be a multi-line "block of
> text".  People often get a (wrong) impression from the word "string"
> that it is meant to be used with a single-liner.

Yes, I've been meaning to discuss that.  I've been having some trouble
with multi-line strings: zsh doesn't insert a TAB in the next line.
The workaround I have is to write a shell script and execute that.
How do you do it?
