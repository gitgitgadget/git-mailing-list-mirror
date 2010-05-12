From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv2 GSoC] gitweb: Move static files into seperate 
	subdirectory
Date: Wed, 12 May 2010 10:45:36 +0530
Message-ID: <AANLkTikrNRJY4vQetIfBF5OOx8ZmHc4gFs1zkOgOZkXe@mail.gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
	 <201005101455.50633.jnareb@gmail.com> <4BE803B8.4090607@gmail.com>
	 <201005120127.55971.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 07:15:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC4IK-0000ZP-CX
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 07:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab0ELFPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 01:15:38 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:39709 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0ELFPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 01:15:37 -0400
Received: by gxk27 with SMTP id 27so4934766gxk.1
        for <git@vger.kernel.org>; Tue, 11 May 2010 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yrXHo0TNJ22q8DCEuQ2/Mz8pHPcdpcEi4hXrX8Mhy7w=;
        b=je27PwbXky46ES+VvYwPFdI0RgsCOkx40allg3ar5cki2oZk0Rsh8IaeNSCAGLtY7f
         MJQ/+lCtUUBUp4NNZuL3KeDdUs+d6LnPqhZB0KzM9ENzCwBAB1VgSRNSJg9tBhgiN/02
         O05OJCoEbCR28ZWIJCyApQPPB03EBdLyd5l5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kzw9WC8kqtt/kqpfrSD04WpFY44bb0wrbY9UyJd1/nhV7BooBkbC3BhIo10XwbeAcH
         fK86jGHVD2YWV+5amceGqNI703PzT3e+t2RUT6eV+scsPt9mWKDIy3KpGLONOcAj9Z1F
         ufaxVR2zgSthg0WDWTevOf9kcjOnoeIkeOs/U=
Received: by 10.91.9.10 with SMTP id m10mr2728406agi.128.1273641336272; Tue, 
	11 May 2010 22:15:36 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Tue, 11 May 2010 22:15:36 -0700 (PDT)
In-Reply-To: <201005120127.55971.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146919>

On Wed, May 12, 2010 at 4:57 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:
>> On Monday 10 May 2010 06:25 PM, Jakub Narebski wrote:
>>> On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:
>>>
>>>> Gitweb: Move static files into seperate subdirectory
>>>>
>>>> Create a new subdirectory called 'static' in gitweb/, and move
>>>> all static files required by gitweb.cgi when running, which means
>>>> styles, images and Javascript code. This should make gitweb more
>>>> readable and easier to maintain.
>>>>
>>>> Update t/gitweb-lib.sh to reflect this change. =A0The default is
>>>> now to install static files also in 'static' subdirectory in targe=
t
>>>> directory: update Makefile, gitweb's INSTALL, README and Makefile
>>>>
>>>> Signed-off-by: Pavan Kumar Sunkara<pavan.sss1991@gmail.com>
>
>> I would like to know when this patch will be merged.
>
> Note please that this patch conflict on semantic level with the
> patch adding support for 'install' target in gitweb/Makefile (and
> install-gitweb to the main Makefile), which means that either this
> one or the 'jn/gitweb-install' would have to be changed.
>
> --
> Jakub Narebski
> Poland
>

Yeah, actually me and petr have been discussing about 'install' target
in gitweb/Makefile. So, I will apply these 2 patches
http://repo.or.cz/w/alt-git.git/patch/152d94348f6a38eb7cb5f4af8397f51ba=
06ddffb
http://repo.or.cz/w/alt-git.git/patch/8515392f5d4c5a36a0f9e4a73068f7106=
d7f4638

and resubmit this patch.

Thanks
- Pavan
