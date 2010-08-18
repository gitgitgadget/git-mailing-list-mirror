From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: fully deepening a shallow clone
Date: Wed, 18 Aug 2010 19:36:08 +1000
Message-ID: <AANLkTi=qEwcE6qSmAoNnqE-2Z41rjqPBSfgbaesQBPrA@mail.gmail.com>
References: <20100817004905.GA8305@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Aug 18 11:36:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olf4C-0004fv-6J
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0HRJgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 05:36:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49586 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab0HRJgJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 05:36:09 -0400
Received: by wyb32 with SMTP id 32so561082wyb.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ntz8ZdF+8gX37gD/NuN9G3/ja0Pbduk6dd+iWb5L2qY=;
        b=L2f8e7ZsDU6KBW1u1wIFsdDcT5GPilyVFmTEYDdROw5qByH6jyD0Iqt8pgEave9Rss
         fSC2W1XN7Y9HNF5HLGwoFR11onTJtnYea60biZc7EQM+blscqv3PqLssPxLQt09Ukb62
         NC1GvJwEUAXg/mH1FCz0/z/UtBvQ7SvYbdYj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UMnFKaGzWn7DjiISay4k90eQ1wks4q6pS2jRphZSHRmY3m/q2iUsJvtXpX/WLBYP6w
         Z9GmOaePfQqhVJYg/6bHFs8DgVkb+8r4iVvNHVaDdj26mAdZVURFlj2bg2lORzNSRF3T
         0v8n04gZI+ZPsLHBou7z6SbhOCwYiWUk34aJA=
Received: by 10.227.145.146 with SMTP id d18mr6798886wbv.172.1282124168071;
 Wed, 18 Aug 2010 02:36:08 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Wed, 18 Aug 2010 02:36:07 -0700 (PDT)
In-Reply-To: <20100817004905.GA8305@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153823>

On Tue, Aug 17, 2010 at 10:49 AM, Joey Hess <joey@kitenet.net> wrote:
> git-pull(1):
> =C2=A0 =C2=A0 =C2=A0 --depth=3D<depth>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Deepen the history of a shallow re=
pository created by git clone
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with --depth=3D<depth> option (see=
 git-clone(1)) by the specified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 number of commits.
>
> Well, what if I want to deepen an existing shallow clone to include
> the full history? In practice, something like --depth=3D100000000 is =
going
> to work, but in theory, that will eventually fail some day when there=
 are
> enough commits. :)

I have always thought --depth=3D0 will make full repo again. Have you t=
ried that?
--=20
Duy
