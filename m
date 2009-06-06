From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 17/23] http.c::http_fetch_ref(): use the new http API
Date: Sat, 6 Jun 2009 09:04:44 +0800
Message-ID: <be6fef0d0906051804t704a802ane4921c56d4577401@mail.gmail.com>
References: <20090606000556.9cbf4ac0.rctay89@gmail.com>
	 <m3eity5rtq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkL9-0005FE-1J
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbZFFBEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 21:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbZFFBEn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:04:43 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:39935 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbZFFBEn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 21:04:43 -0400
Received: by pxi40 with SMTP id 40so307477pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BQG3sCsU44KEtRmqdPzS0DIwWe9LPqpJGM9VlUG0csY=;
        b=fSIlOKG7o9hc/HRc0UFK9hI1CEGbNZnYSEUJMoFzVGeiOdGfcsIeaV/Yh/BfGJkM8A
         l+0orR5CfwAkBkDu3KbzLSE2SPu8fy8z8CYYIL5BnELjSlRrb77WjcCUwuk14Z3+X8PV
         YwnrjLn8NWTOvbhxdCGZ4vUEOiHk5KTPhkvGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FP2oOMW9upqumlrMRQ53OFbyFLwToJJ1E8hTI2zdvSLlH0OkFKNYJYIFEkYfdVHmJp
         FOtLe8pTgU3ih59OSydycwqqRCa+8r943vhkw965lSLsw4X4HWnRoQ3W5NwlLLa4kfcs
         3FQQ8lHwtHl+khqxR0y2cuzgycLjgv5iYkUxI=
Received: by 10.142.173.6 with SMTP id v6mr1575312wfe.121.1244250284814; Fri, 
	05 Jun 2009 18:04:44 -0700 (PDT)
In-Reply-To: <m3eity5rtq.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120856>

Hi,

On Sat, Jun 6, 2009 at 4:50 AM, Jakub Narebski<jnareb@gmail.com> wrote:
>> From: Mike Hommey <mh@glandium.org>
>> Subject: [WIP Patch 04/12] Use the new http API in http_fetch_ref()
>
> What is the subject of this patch:
> =A0"http.c::http_fetch_ref(): use the new http API"
> or
> =A0"Use the new http API in http_fetch_ref()"

See my reply for patch #12.

> Perhaps this and previous patch should be squashed?

Why should this and patch #16 (for get_refs_via_curl()) be squashed?
Are you perhaps suggesting that all the use-the-new-http-API patches
should be squashed?

--=20
Cheers,
Ray Chuan
