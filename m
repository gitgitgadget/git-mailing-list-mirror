From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: Simplify handling of python scripts
Date: Fri, 9 Apr 2010 17:39:12 +0200
Message-ID: <i2ifabb9a1e1004090839hd55a81bfid820180815c8d94d@mail.gmail.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com> 
	<1270827245-28958-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0GJ3-00030Z-5O
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0DIPjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 11:39:36 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:35117 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab0DIPjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 11:39:35 -0400
Received: by qyk9 with SMTP id 9so1483721qyk.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gDH/v7fuHFhXXX0RCZh7Jbk6pEHkK5kSRvBEk/Zzci4=;
        b=bZR1GeToyr+MFUejaPLAKhzVgNMMv5eZsn32qO2CAeQ976et+YDrx2mjT2ZcctOS0T
         dPsu7qUu/OiiAmEuP/nQOBd+LpsNYvdM6fw4YaY/57p32iq4WPnAvUntFkJelfTdlZKQ
         KnFegKHHsVR8cXujTsTsNWBEBj9EdJJAEkSHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MzANUyNsP8ynDwOPk5xzEUNC6kOOrIIFUJxZOxVb7mb7TeWBb6RPJjLPAg5cpETU9v
         YKUhVu90LKtcRHZWzYx8SmlHKc3eNtdhi05yLkijG/ocdl3wZPSrMlYmrOzsgmReeain
         EzP9cge01/6uAnoyc6jeu0w6mpl6BTsJTTMtY=
Received: by 10.224.74.3 with HTTP; Fri, 9 Apr 2010 08:39:12 -0700 (PDT)
In-Reply-To: <1270827245-28958-2-git-send-email-brian@gernhardtsoftware.com>
Received: by 10.224.70.129 with SMTP id d1mr66431qaj.357.1270827572103; Fri, 
	09 Apr 2010 08:39:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144445>

Heya,

On Fri, Apr 9, 2010 at 17:34, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
> The sed script intended to add a standard opening to python scripts
> was non-compatible and overly complex. =C2=A0Simplifying it down to a=
 set
> of one-liners removes the compatibility issues of newlines. =C2=A0Mov=
ing
> the environment alterations from the Makefile to the python scripts
> makes also makes the scripts easier to run in-place.

My sed foo is not that great, can you explain (in the commit message)
what exactly the new sed script does?

--=20
Cheers,

Sverre Rabbelier
