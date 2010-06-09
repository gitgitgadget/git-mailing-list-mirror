From: John Tapsell <johnflux@gmail.com>
Subject: Re: [RFC/PATCHv2] bash completion: Support "divergence from upstream" 
	warnings in __git_ps1
Date: Wed, 9 Jun 2010 17:45:15 +0900
Message-ID: <AANLkTiltzOHvsVkqnKLV-fy-T8KyGQ8vg6pPm4xPZpJ-@mail.gmail.com>
References: <4C0AE640.3040503@pileofstuff.org>
	<201006062014.59386.trast@student.ethz.ch>
	<4C0C09BF.4070503@pileofstuff.org>
	<201006070942.34753.trast@student.ethz.ch>
	<4C0EB7F1.1030707@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Jun 09 10:45:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMGua-00089l-5V
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 10:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025Ab0FIIpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 04:45:17 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:59120 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab0FIIpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 04:45:16 -0400
Received: by pzk6 with SMTP id 6so2791659pzk.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XJIVJ0zafqgZiZXiQlKIGfMG0+BAvKOwHANPbGpheng=;
        b=e0fOcU+9j41yk6Igt0j/2ktKgCF2HLRLuVFqvyXs/4OzG1WLeVpJH24Q0EdKeUYxT/
         eGGRe6qTuc6utZQBQNf0/OZOmhKqCZnhytQbI93KS2SKTZLMhcpRVjGyIlWvNM2ECQ7V
         v/06cy30cRjqA5RZVJVbcuSj52r6HHU6LQz98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h7Nk0G0nGnDcKpQSZ45YIwO/aBrrgJD2yk8b5fxKrotTZtnHjPy12orYaLrPwGkuml
         05xEtGH2LTi8dw/fZF+D00RFniqtACPo3j8f4+BxiTLR8zq9y71neG4ZKs5aTYocCMl/
         1M0VCO1FvYEnSPZZ+8hRayVaqg5g5OjbhDrkk=
Received: by 10.115.149.4 with SMTP id b4mr5898528wao.143.1276073115718; Wed, 
	09 Jun 2010 01:45:15 -0700 (PDT)
Received: by 10.114.26.17 with HTTP; Wed, 9 Jun 2010 01:45:15 -0700 (PDT)
In-Reply-To: <4C0EB7F1.1030707@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148754>

On 9 June 2010 06:36, Andrew Sayers <andrew-git@pileofstuff.org> wrote:
> Add a notification in the command prompt specifying whether you're ah=
ead of
> (>), behind (<), diverged from (<>) or at (=3D) your upstream. =C2=A0=
This is
> especially helpful in small teams that (forget to) push to each other=
 very
> frequently.

I hate to get all feature-bloat on you...

But could it state the number of commits as well please? :) :)

John
