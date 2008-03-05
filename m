From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Wed, 5 Mar 2008 23:35:48 +0100
Message-ID: <8aa486160803051435q1b28ea65o40c5d6ece8a482c6@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <m3mypchol6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2EA-0008II-Em
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbYCEWgE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 17:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756289AbYCEWgD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:36:03 -0500
Received: from gv-out-0910.google.com ([216.239.58.191]:15803 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbYCEWgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 17:36:00 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1264861gve.37
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 14:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jZhAPlSgekk0pJZus6UpEuBSdHnn4V2sVZ580NIQw6o=;
        b=lLZ8dLItMR/WpgobuqAMwGFPZQ7iZje9DAfU0ePCS9O7IJm9Xcz6sTAB4cBNvt9ySXHDMOzZmSsURbAu2DLXvWGcco0CG3dvAnLHsOgJ0z8pde4Ly/Oe2EGaagBPIhUQPmQGwdWmDau/yoksXOdmsPPhiDBsKd/N93d3+ZVGwxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X4D667Yvl0BC7Y0u/DyEDv7VHnO6gU89jC+KkazZJq2+0fJuwUhUQXMrV/3cH6pfVbxHO+LhlCd2OuDA5uCwKw/QCXY2G8OR6dtI5lO8YNrpFt8xGbQreFuPkXtUy9IyBQcX5jh6xEQCsGtRZwihT8jbA4ES+K2kwfJPkgT4uG0=
Received: by 10.150.195.21 with SMTP id s21mr1538539ybf.9.1204756548603;
        Wed, 05 Mar 2008 14:35:48 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 14:35:48 -0800 (PST)
In-Reply-To: <m3mypchol6.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76281>

On Wed, Mar 5, 2008 at 10:01 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>  > Useful when you want a different email/name for each repository
>
>
> > +user.default::
>  > +     If false the defaults values for user.email and user.name ar=
e not
>  > +     used. Useful when you want a different email/name for each
>  > +     repository, normally set in the global config file.
>  > +
>
>  Wouldn't it be better to use user.noDefault, or user.explicit,
>  or user.dontGuess... user.default seems like place to provide
>  some default value, not place to decide if there should be some
>  fallback default values or not.

Make sense. I prefer user.explicit.

Santi
