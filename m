From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: Add help target
Date: Tue, 28 Sep 2010 13:37:56 +0200
Message-ID: <AANLkTi=beUW5j4WSGOB__LNP7o60Wep_Y9n4YXOZUMtU@mail.gmail.com>
References: <1285661638-27741-1-git-send-email-bebarino@gmail.com> <7v39suurpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 13:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YVt-0004a6-I2
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab0I1LiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 07:38:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35982 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab0I1LiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 07:38:17 -0400
Received: by gxk9 with SMTP id 9so1872591gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=39Ajz9zd8Gw4IAWgWCIWUI8OzYCbV2dea4jD6+hwRhM=;
        b=TNqXxzjkyxQCAnPWQPtefgrXBALqTPCT1pE/lZ6LlW441JFhMgs5C6YAd6Pynpsubr
         dSQTr7fsXJfodZGbprQh+61BPxNDX7fhc7zAd1PM0dlNYLWpOA5DKz+vPaT+tUM5smJU
         pHe0e8iZfzHixn+HZl7YSy6cKyX0Q9DPeYK90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EIrJjZXQ72TD4gv/Sj3YJnJ62x/Y9lxRkYDc16YXac72amtPCwYw/34k1Lb1AtP1Rx
         EuwjjAjOxaCEhm3IYPC90mrsoMCU9BaVaokg1Mt5RV6ImnrpVM5lDxePuZiEY6CjIBqo
         EIJN7K1x422rnznTfUPAtRnpDa5CzMIoDswak=
Received: by 10.150.206.10 with SMTP id d10mr10669740ybg.350.1285673896974;
 Tue, 28 Sep 2010 04:38:16 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Tue, 28 Sep 2010 04:37:56 -0700 (PDT)
In-Reply-To: <7v39suurpw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157411>

Heya,

On Tue, Sep 28, 2010 at 11:45, Junio C Hamano <gitster@pobox.com> wrote:
> I do not look forward to having to maintain a large number of lines that
> are doomed to go stale

How often have we changed makefile targets recently? The most recent
one that I can find is Jakub adding "install-gitweb" in 152d94348f,
which was back in May 1st. The next one before that is the addition of
'gitweb' in 62331ef1637f which was back in January 30th. Besides,
'make help' doesn't have to contain _all_ Makefile targets, just the
important ones that a user is most likely to need. Similar to 'git
help' itself.

> and every time we need to touch we need to deal
> with a lot of noise "@echo '"?

I don't understand what is particularly bothersome about the leading
"@echo" lines. Adding or removing a target is still very easy even
with the leading @echo's, the only thing that would be a PITA is
reflowing paragraphs, currently, there _are_ no paragraphs, everything
fits on one line.

> It might be a bit less distasteful if it were plain text additions at the
> end of INSTALL file, though.

That does not help me nearly as much when I want to know how a
makefile target is called. Am I wrong in asserting that having a "make
help" target is an accepted "good practice" in the unix world?

-- 
Cheers,

Sverre Rabbelier
