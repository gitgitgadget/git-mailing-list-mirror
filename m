From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: getting git to ignore modifications to specific files
Date: Wed, 1 Sep 2010 12:12:59 -0700
Message-ID: <AANLkTi=cPzAAKsTR+_1sucF46Rez=yi2Okjz7RhcCZ20@mail.gmail.com>
References: <4C7EA1FF.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 21:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqskK-0002ij-DJ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 21:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab0IATNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 15:13:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37823 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab0IATNP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 15:13:15 -0400
Received: by iwn5 with SMTP id 5so7013009iwn.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WSqJGskfE4hgW9sUQO9S6bi6IpKHIuZfWfJLbuJlkU4=;
        b=ri4/U55GJwrlQqHhdeO6UJkGKGF5Ri4Cj1vABH7YYN5rIbPybQ16emrGJL94P6jMBT
         dN+BwLmStRpx8XiFafzsk9ZTlCGF8M2vlf7GrXm7bt9LD7Um+j5PU/n/kcpv5JNMD44t
         fGLSzs6/QtAeDycg8St5R9OHSWPwlcz4Z2yqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YY4xu27XEIOXUNURzGeifAvgYv8cRZQda7csyvNtWnP8919i0Nf5EvOs9dHUdhVMER
         1ux5q6qAQioaO07Y+Tv+wlaBwmYF+s3QXEcyrwokSOZtttPCRmO1mEteKzOrbNTChB1M
         lpeZA1WvQ6BTVefCZIx+VNAWoWJ2v45tOu6CU=
Received: by 10.231.152.78 with SMTP id f14mr9594595ibw.60.1283368394437; Wed,
 01 Sep 2010 12:13:14 -0700 (PDT)
Received: by 10.231.182.11 with HTTP; Wed, 1 Sep 2010 12:12:59 -0700 (PDT)
In-Reply-To: <4C7EA1FF.8030307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155070>

On Wed, Sep 1, 2010 at 11:57 AM, Chris Packham <judge.packham@gmail.com=
> wrote:
> I did a bit of googling and found
> =A0git update-index --assume-unchanged
>
> Which works locally to stop git status from complaining. Is there any=
way
> for me to make a change to our clone (a .gitattribues entry?) so that
> everyone can get this by default?

Isn't that what .git/info/exclude is about?
