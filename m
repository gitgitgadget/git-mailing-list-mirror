From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Wed, 5 Mar 2008 23:33:41 +0100
Message-ID: <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:34:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2Br-0007FU-4Y
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYCEWdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYCEWdp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:33:45 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:54912 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYCEWdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 17:33:44 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2209646tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sUW81W9m4EloPubZrZJ9Fv57xCwBw3AyspRvl/fxCtg=;
        b=Qq+9qd3NM8nDr4vgUTgJ1NK3wvagFkUGlQa5+zle1EMgXKT+hv75Xn/7mQJ27YQ93v2MqalEPJTtcdy2Nq1SSwFmFI/Dk3EMf+AjKnH/FHa80nTV6+hQBDaqvwIENmw941LLL7B1pJRRqvqqKI2aXR71D5fhq/xLM4tlTbSRahg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XwuWBkjQ0QlYqvmBDj2eqtWo9NlAHunS7jyewlq2/fmsMf6QD36yVtKnDVi28L5tavooxbqk6UEi9UbM6t0QS6lhmM9UzbzqI57ZZx2QgW5d/g2uVwbq+E46NzcBsghvSTPrTtLArIjBAvuY4Wq0H0Qq25NBU66tv9SBvwWxnCM=
Received: by 10.150.197.8 with SMTP id u8mr1168867ybf.182.1204756421165;
        Wed, 05 Mar 2008 14:33:41 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 14:33:41 -0800 (PST)
In-Reply-To: <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76279>

On Wed, Mar 5, 2008 at 10:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>  > +user.default::
>  > +     If false the defaults values for user.email and user.name ar=
e not
>  > +     used. Useful when you want a different email/name for each
>  > +     repository, normally set in the global config file.
>  > +
>
>  Aren't there other configuration variables that you might want
>  to tweak per repository?
>
>  Perhaps you can make git-init run a post-init hook script by
>  default, and have ~/.gitconfig specify the location of it, and
>  have it do whatever custom settings to the per-repository
>  configuration file?

I would still need something to prevent doing a commit without a
locally specified name/email.

Santi
