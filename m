From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 17:32:34 -0400
Message-ID: <AANLkTinLOQEXk3AIKxC_prMO_j7hcFVh-zW6hqFfuhhI@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<20100722195653.GC4439@burratino> <AANLkTikUqbAGPXcAmGsx_oML0tZHpMWHOFl7CCkjBca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 23:33:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc3O2-0003FI-C2
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 23:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0GVVc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 17:32:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45568 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0GVVcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 17:32:55 -0400
Received: by wwj40 with SMTP id 40so3953994wwj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=raUG7RT3jmCV+pIP+1G0JA1Ds2mc/0rmo7kQIqiBpEc=;
        b=UB5Qh3EsGy8mUBdGMX2GdUUBGUGazqTlhfb7FjoBVJx6+po3OdQ1ilqElhgRVG484q
         fWtE9hr9MxVR5rXjcB9XRRJwz2+t4mqUx87j5NZRcrmNL1t8g6vPWp4WkXG1hd3piRXm
         BOtal+zFvMmx+wRl6nFPmD7yyncDTecdAt+4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RoqboqSgeAh9t5CX6Hshn3HMWRZSWQKRiwsKr/hIB9rvP/X19eWyth5qWJ7EUviBSB
         HfQDX5YgqdXGGsK7BCJmJpf5nDoZtZhLHmcLGDMFbLww5ha5yzENWKNPlsvl/eJvEUCP
         s9kwGvcuX+AamGEdaBs4caV7gIcvh9w0t8M0Y=
Received: by 10.227.69.17 with SMTP id x17mr2545810wbi.87.1279834374128; Thu, 
	22 Jul 2010 14:32:54 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 22 Jul 2010 14:32:34 -0700 (PDT)
In-Reply-To: <AANLkTikUqbAGPXcAmGsx_oML0tZHpMWHOFl7CCkjBca0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151486>

On Thu, Jul 22, 2010 at 4:43 PM, Elijah Newren <newren@gmail.com> wrote:
> (e.g. the known issue about --prefix being ignored with
> the code being merged under a different directory due to
> rename-detection, [...])

Aside: if this is the bug I think it is, then it's is fixed by the git
merge -Xsubtree feature, which has since been merged into git.  (I
think Elijah knew that, I just wanted to make sure it's clear to
anyone else reading.)

Have fun,

Avery
