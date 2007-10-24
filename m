From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 01:27:10 +0200
Message-ID: <8fe92b430710241627v3ec51b20qf0b4e60356336363@mail.gmail.com>
References: <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
	 <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com>
	 <20071024102950.GA3908@diana.vm.bytemark.co.uk>
	 <8fe92b430710240404u202521d4g2275bc4886956807@mail.gmail.com>
	 <20071024113123.GB6459@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Catalin Marinas" <catalin.marinas@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 01:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkpdF-0006Zm-4a
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 01:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbXJXX1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbXJXX1M
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 19:27:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:57397 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXJXX1L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2007 19:27:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so420112wah
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kwvt0CWQ7r/DElyRafHT+nM/maOWHyjl18BlqPEjRjM=;
        b=tw183vREPr6PEJFK3N0XdfcxMsbNb/YmPbkx4FcrQCCGfUN5Gq42brQ7KOf7sGm8Vhp+9kzIzg20Jegvs6Q2WxX+SFV+4qpvyNCHRmMDR/TJNjRXSlo/EHCotvcjZDTcOZGdqQtVO2/1TAbJnJMCx1CzRYJAoe82fMnvqnOS3Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tQT5v2YAiF1wMnyYiWCZttxQme4cT0enw/kETebLYL1oUx7oVForcBIZtpva1zYw21ZHwlGSk6LqXiU4XO9IIBGTx4NL9gRaumWxvfs19f/BvV8QH/MZpmfZkVA53HDVeZ6jRefhLgto5WPQdIQ6OEIUdvgUaTFQFm0XCTvF1MM=
Received: by 10.114.190.6 with SMTP id n6mr1303450waf.1193268431028;
        Wed, 24 Oct 2007 16:27:11 -0700 (PDT)
Received: by 10.114.195.16 with HTTP; Wed, 24 Oct 2007 16:27:10 -0700 (PDT)
In-Reply-To: <20071024113123.GB6459@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62252>

On 10/24/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-24 13:04:01 +0200, Jakub Narebski wrote:
>
>> By the way, there is SRPM for StGIT in
>> http://homepage.ntlworld.com/cmarinas/stgit/ (I need it because I
>> have Python 2.4), but it is not listed on downloads page...
>
> I'll leave the webpage question to Catalin, but I'm curious about the
> Python version remark. What exactly is the problem?

If I remember correctly the StGIT RPM requires python 2.5
(and is build using python 2.5, so install with --force doesn't work).

BTW. SRPM is better than tar.gz because I can simply do "rpmbuild
--rebuild" to get binary RPM to install.

--=20
Jakub Narebski
