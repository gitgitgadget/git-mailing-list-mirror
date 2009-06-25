From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 0/8] gitweb: gravatar support
Date: Thu, 25 Jun 2009 15:15:00 +0200
Message-ID: <cb7bb73a0906250615i2ed880eci2d3716aa1ca43e4d@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906251455.32953.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 15:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJont-0001IP-3X
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbZFYNPB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 09:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755856AbZFYNPB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:15:01 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:34190 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbZFYNPA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 09:15:00 -0400
Received: by bwz9 with SMTP id 9so1386775bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yPobmitXt/CXuKZ3U4HqRSonP3LI6EDlLvMqkvI12K0=;
        b=XJR8kj/HzrWomg3MXipydtTbIDH4XogCL3lX9BNBSh9LWp0PiD+SAUHPetgSFkQeXE
         Wj2dEiq1MXIJUvVt075Vi4O0kNOK/MoiSAv+NMLgDKga2iTKaqIMZ1o9kTj3uQDkkQfp
         6kNhoiTz1k4yWoNGMVGr3Ns2BAZle67EhywOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=boJvcsnosIKldMkjc7z4JQpi8YbMjdokOU5lcAGOTPSVBUXBXIfvWJVA2AmBlFLfBU
         1lvvSuSZ1jtDAn8xDTJs4wlha/3fcixnTAbU/fyVXZlIXdrPGq7kqhywspkIswxRE31z
         c5A2A2yXnLluScAo17VQPTS8B7YniiUOjd4iU=
Received: by 10.204.55.140 with SMTP id u12mr2440144bkg.98.1245935701215; Thu, 
	25 Jun 2009 06:15:01 -0700 (PDT)
In-Reply-To: <200906251455.32953.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122208>

2009/6/25 Jakub Narebski <jnareb@gmail.com>:
> Giuseppe Bilotta wrote:
>
>> Significant changes from the previous iteration are:
>>
>> * the feature has been renamed to 'avatar', and 'gravatar' is a poss=
ible
>> =A0 value for it (currently the only sensible value, other than '');
>
> By the way, I think it might be better solution to provide picon URL
> as 'default' attribute for gravatar URL, so it is used if there is no
> gravatar for given email.

I was thinking about some form of fallback like that too, but I
haven't the slightest idea how picons work, so I'm afraid I'll leave
that enhancement to some later time.

>> * the last patch adds avatars to signoff lines.
>
> Perhaps it would be better to add gravatars at beginning of line?

I'm not sure. As I mention in the email for that commit, I'm totally
not satisfied with the layout. I'm lookint into turning signoff blocks
into tables.

> I'll try to post my comments today (i.e. within 24 hours)... but it
> looks good.

Thanks a lot.

--=20
Giuseppe "Oblomov" Bilotta
