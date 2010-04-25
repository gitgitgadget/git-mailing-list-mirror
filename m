From: Aghiles <aghilesk@gmail.com>
Subject: Re: Recent documentation patches, and an RFC on terminology
Date: Sat, 24 Apr 2010 20:31:52 -0400
Message-ID: <j2g3abd05a91004241731ofcb744b4z266d656ae85bb1b7@mail.gmail.com>
References: <20100423215448.1EF5B479E92@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 02:32:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5pm2-0000uw-6L
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 02:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab0DYAcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 20:32:16 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:45282 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0DYAcO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 20:32:14 -0400
Received: by wwg30 with SMTP id 30so663530wwg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=90SmTCqSK6u2FjlD4zCQXNJgNaZuF7KeP6PLBk0O86c=;
        b=TUWHDTAfn6MZKzRm90if5/pFIpwRYEkD3vuL/dfWDx047aZ5v2Hci2uZgn7uHFz/QZ
         xAwifSg27x37zQRjXVA13rnL1tLMT9IQ/1PYWJ+ksB90gPE6Yt3yi3NCafqM3XgR8286
         6nTXx3wN8zL4m+NP8Q39UuYrwPxpZNrXvm0LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y2JI7lPA7Avh4ttbuRUjw8xxkJSpTfoRkyB0zBRPHUSsgyn/KR4EhJ0dCdtoc/QRFq
         WlMz0uYIFfzxmoRyuKQ6qNBfm/b9ukCOWtrnNJ6Jzkrjzc8jk5DL20fFy+s/X5upuLqo
         8/q5M6ZvUSjF98YBe85/mLMeSomxRsfAETHEk=
Received: by 10.216.162.212 with SMTP id y62mr2625550wek.109.1272155532162; 
	Sat, 24 Apr 2010 17:32:12 -0700 (PDT)
Received: by 10.216.164.141 with HTTP; Sat, 24 Apr 2010 17:31:52 -0700 (PDT)
In-Reply-To: <20100423215448.1EF5B479E92@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145713>

Hello Eric,

> We may have an opportunity to improve on the term "staging area". =A0=
As
> I reflect on it, I think replacing that with the term "depot" might
> not be a bad idea. =A0In English this word has the general sense of
> "warehouse", and the more specialized connotation of a place where
> freight is temporarily held for transshipment, or where military
> supplies and recruits are mustered before field deployment. =A0That i=
s,
> a depot is a particular kind of staging area.

=46or what it's worth: I am a non-expert git user and I find the name "=
staging
area" to be perfectly adapted. With this terminology, it makes it easie=
r
for me to explain some git principles to new git users.

The name "depot" is confusing because there is no expectation of a
following action. I already see this question coming: "can I leave my f=
iles in
the depot now?"

  -- aghiles
