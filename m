From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT and conflicts
Date: Fri, 25 May 2007 11:00:33 +0100
Message-ID: <b0943d9e0705250300o419d1d7ld175b273dbed2429@mail.gmail.com>
References: <20070524164038.GA27661@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 25 12:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWbE-0002Tw-Kj
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXEYKAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 25 May 2007 06:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbXEYKAf
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:00:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:55640 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXEYKAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 06:00:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1083688ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 03:00:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mR6FPAnSE3aJWQRh6Dn8T1euXl+JCZOhu1TVA0EfdFbu+IYLBcjIdiMvXOH1UrnEUwNsYoUWc6noaoB0ycaHlCl+hiA2+HPECWYCwxIgHzH9oIl4r5VGnVnC5+wuaoAt1tyvD38sZnB3HbZ5zOqapx+Lv0p4ymNUt5R8lv1uIFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c3TG6Li28iCYZnvSeg2Z7zu7oM28irqmnnlTchhyvTT35kUEi16raT8Mi45bExF56GAcxPuDMqEQDoLZEhSlsSBP8QtllTzwPpaaCsKdHnZ6zNG8uqDbVEn2uRpTHFQONfcC6yIAMinJxPBSh1+UXA+KSRctpEnpQmrPfu3vU68=
Received: by 10.67.99.1 with SMTP id b1mr2823241ugm.1180087233120;
        Fri, 25 May 2007 03:00:33 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Fri, 25 May 2007 03:00:33 -0700 (PDT)
In-Reply-To: <20070524164038.GA27661@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48351>

On 24/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> The current behavior of StGIT is to not use the index for conflicts
> like git does. What advantages does this have that are great enough t=
o
> motivate a deviation from the git behavior?

I don't think there are any advantages in deviating from the git
behaviour, only that when I first implementing it, git didn't have any
smarter behaviour and I used diff3 (or other external merger, which
can be used right now as well).

I'm not sure if git-diff still works when there are conflicts in the
index. The current stg behaviour is to reset the index to the base of
the patch and a stg diff would show the diff (including the config
markers) to the base. I find this quite handy.

--=20
Catalin
