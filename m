From: Chase Brammer <cbrammer@gmail.com>
Subject: Re: StandardInput Not Continuing Process
Date: Thu, 23 Dec 2010 09:55:02 -0700
Message-ID: <AANLkTikvrDWYT8h_MCESd9sg4_8ykSOq3XFEsoNsYDuZ@mail.gmail.com>
References: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 17:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVoRb-0003ZZ-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 17:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab0LWQzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 11:55:05 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53334 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0LWQzD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 11:55:03 -0500
Received: by wyb28 with SMTP id 28so6255488wyb.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=mqry9mPYGvX0SxZo8rFyaRC0D0FHDqll54WpqJW40ak=;
        b=u1hwAqgSmSzMBIRJkFth7EiJTrhLxgNh0xZuNIIqnP7qq1aqLbCm3cPUpvDtbcIasm
         kz3T7v9mFC9S5XNhzxE4o4KlN7FKov5Ly0ifINcVmGBY5v96YRNlwxe7pE+XwAiLyfp5
         Jhd1tdyEWhHlmeZNDCcWXhslCIuNgcxWrw72E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=AEX2NBkJNcfeg6xiD5I56IAzx+7kKoodVPnd9++jSryY3aDPxLXvPI1wWdvMYllYew
         nJGjQXX5Tp1rnWnpFt6h87XpIOrmKVStRX/3vxSxRfQAE+LPUqCrjgdk1B9FPNLJKmL7
         GMq9mZq1ftM1sMSHYSyUtwpK50KyLAANeqEPk=
Received: by 10.216.71.209 with SMTP id r59mr12703155wed.15.1293123302452;
 Thu, 23 Dec 2010 08:55:02 -0800 (PST)
Received: by 10.216.175.130 with HTTP; Thu, 23 Dec 2010 08:55:02 -0800 (PST)
In-Reply-To: <AANLkTikBdOLjzJxikXCwTs52RByfNZzKamK+F-JhY0mQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164131>

Bump, any ideas?

Chase


On Wed, Dec 8, 2010 at 10:25 AM, Chase Brammer <cbrammer@gmail.com> wro=
te:
>
> I am try to directly interact with Git by using only stdin, stdout,
> and stderr. =A0So
> not going through a terminal at all, but calling Git directly. =A0=A0=
I am
> having an issue
> with being able to continue a process that requires input.
>
> For example, doing a clone from a HTTPS server may require a username=
/password.
> I writing the password as utf, and also tried just UTF byes (ie no
> prepended 16-bit int)
> but am unable to get the process to continue and start the clone proc=
ess.
>
> Is there some signal, or trick to getting the process to continue? =A0=
I
> thought that sending a
> "\n" would work, but that doesn't seem to be working either.
>
> Thanks for any help!
>
> Chase
