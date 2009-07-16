From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Make a non-bare repo bare.
Date: Thu, 16 Jul 2009 17:09:37 +0530
Message-ID: <2e24e5b90907160439i29171e9fka3baf6bf871a6011@mail.gmail.com>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
	 <7vbpnlbbln.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 13:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRPJR-0007Yt-SI
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 13:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbZGPLjj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 07:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZGPLjj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 07:39:39 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:46258 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZGPLji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 07:39:38 -0400
Received: by gxk9 with SMTP id 9so79277gxk.13
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pTVdIixOd/4Ssq9kgpfthdVVul5LGCZSl7t/v0U7O4w=;
        b=eikfwNgD52Qy1vAkv55j6OB3iQl/v1IMKVR57jdaE5xrou65Ff+zrHc8OEUmwqKHD+
         1fQvd+g0di/L1twHUQX6BL4b5VA27d45c/axcZ+XPyL+rsXN/EVL6/UszxlC6ELgsI3i
         qR84pZ1iKfZn8x3ewdK+1CbyhbKKWlihZZIY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zh5+5O6/DlOfxQm7EsDMEML8K7/2lVepSrbTJObB/ysl1KJ7cc3rv5ckpe0VRyGZB7
         2T7ImEdFfBnkUzw9AWu0rbRp9e78dTb18hZO5Y4ZVSQCgeEBWIh/RvFhzTNYEOGCpZwR
         3jEgMYxp6F35EjKHPlaZ9LzwCrk/OcLA3JoqU=
Received: by 10.231.16.136 with SMTP id o8mr2335753iba.24.1247744377390; Thu, 
	16 Jul 2009 04:39:37 -0700 (PDT)
In-Reply-To: <7vbpnlbbln.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123398>

On Thu, Jul 16, 2009 at 8:03 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Tim Visher <tim.visher@gmail.com> writes:
>
>> Hello Everyone,
>>
>> I recently had occasion to make a previously non-bare repo bare. =A0=
Is
>> there any way to do this? =A0It will not allow me to delete a branch
>> that I'm on so I wasn't sure how to proceed.
>
> Funny.
>
> =A0 =A0http://article.gmane.org/gmane.comp.version-control.git/123303
>
> It is posed as a question but describes the correct (and officially
> supported) procedure.

The linked procedure uses git clone --bare.  It is my belief (and
please correct me if I'm wrong) that only a git clone --mirror
actually does what you want here -- a mere "bare" clone would lose
your remotes and their tracking branches would it not?

If I'm wrong please correct me...
