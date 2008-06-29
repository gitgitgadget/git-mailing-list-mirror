From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 1/4] Allow e-mails to be sent with the Unix sendmail tool
Date: Sun, 29 Jun 2008 22:55:43 +0100
Message-ID: <b0943d9e0806291455j2684514bt5c0cb23e0f4d6c03@mail.gmail.com>
References: <20080619214023.27794.97039.stgit@localhost.localdomain>
	 <20080619214201.27794.18891.stgit@localhost.localdomain>
	 <20080622151026.GA4468@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:56:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD4t0-0002cw-2f
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 23:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYF2Vzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 17:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYF2Vzq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:55:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:44520 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYF2Vzo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 17:55:44 -0400
Received: by wa-out-1112.google.com with SMTP id j37so993741waf.23
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 14:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FQuOgEn43ozaw6zRHAPB+TR/mz76sd8qrsKrFc3q1ws=;
        b=IG0UNni8lqza9Z9JppXHdlsAC7d+if20NNoH7o+lncpI9Hnjpghxz0HVddPPtKfRr7
         bT50M0h/hGDT/4ao6Srw1sK/mNG+aLeXHJ4E0gsFLHREMYuyZrwtXkcrptUMg1eXKUWj
         GdB4kwzRKw1bmtwtIZNIsCgIi4FhkHDQ3gAlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lagtQoFPJIpzhwtEoIDpQKScghag3cmI8VV2UxLpxmB5FQ0TPY0RqOKZxsLfJpuQXo
         t7AxI/uevqsUdnlK7ja5M91w9N1+JNNceivg38jyl6/cAenugiyntxFuQj1MQldtSZMi
         kALDn0MNWFjTWNZxYLKfZfBTgMR6vGAd5ck6A=
Received: by 10.115.48.12 with SMTP id a12mr3418886wak.38.1214776543933;
        Sun, 29 Jun 2008 14:55:43 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 29 Jun 2008 14:55:43 -0700 (PDT)
In-Reply-To: <20080622151026.GA4468@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86837>

2008/6/22 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-19 22:42:01 +0100, Catalin Marinas wrote:
>>  class GitConfig:
>>      __defaults=3D{
>>          'stgit.autoresolved':        'no',
>> -        'stgit.smtpserver':  'localhost:25',
>> +        'stgit.smtpserver':  '/usr/sbin/sendmail -t -i',
>
> Hmm. I think it's actually more common to have a misconfigured (or
> insufficiently configured) sendmail program than a misconfigured mail
> daemon listening to port 25, so I'd argue that the default shouldn't
> be changed. But it's not that important.

OK, I'll leave the existing default (but I found in recent years that
major Linux distributions come with pretty sane configuration).

--=20
Catalin
