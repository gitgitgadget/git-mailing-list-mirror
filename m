From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Fri, 20 Aug 2010 08:15:19 +1000
Message-ID: <AANLkTimHKc7y7ktAkAUffLzOtMGxqWO0i2nOWWuo4N9J@mail.gmail.com>
References: <201008180854.18474.ComputerDruid@gmail.com>
	<1282214437-16384-1-git-send-email-pclouds@gmail.com>
	<201008191031.40230.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, joey <joey@kitenet.net>
To: Daniel Johnson <computerdruid@gmail.com>,
	mikachu <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 00:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmDOQ-0007jE-RZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 00:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0HSWPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 18:15:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39532 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0HSWPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 18:15:20 -0400
Received: by wwi17 with SMTP id 17so3040071wwi.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q9Cl5wU8skiMohJL1MayXJ+Y2BKfkUA/oN4oV7xVBXg=;
        b=G34SQ+DhuxLD3IUU/4wo2CgX8RkadjyoXSuZTtJPuP2vMqKHRzOg+HdqhgX4UZ91yi
         SepkaK7bZbSZRk0LvwAdnzYeXE4wN89T+IIEgZ8An2R0Ntq9Jznwbik9aSA3TgXpq/AA
         Pyd1kXFc0YGDVB7mqX1bZm0ax+JwjIX/9nhgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fWX+P6ZngsV97QYWokuEm710cptQkscCyqGt8lcJnbFwdqslObI/G2QwiLXEmmhgUY
         K6Cb5W0f4PyRdXHDnsxCx7JWIqvEC+2PvmTPWe8sP1GbTFSf8kvF2rimaT6vY6uRQaXz
         7KDVK6ieK3+uhKyKKxsDeXXU9vvUJIXdgzyis=
Received: by 10.216.17.130 with SMTP id j2mr1225421wej.47.1282256119268; Thu,
 19 Aug 2010 15:15:19 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Thu, 19 Aug 2010 15:15:19 -0700 (PDT)
In-Reply-To: <201008191031.40230.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153963>

On Fri, Aug 20, 2010 at 12:31 AM, Daniel Johnson
<computerdruid@gmail.com> wrote:
> On Thursday 19 August 2010 06:40:35 you wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0builtin/clone.c | =C2=A0 =C2=A07 +++++--
>> =C2=A01 files changed, 5 insertions(+), 2 deletions(-)
> Can you make it a little clearer what the rationale is for this chang=
e? Why
> wouldn't you be able to do a limited-depth local clone? Seems like th=
is
> would
> break some tests, and even if not, would prevent the writing of them.

It's been like this ever since and it puzzled me, "why 'git clone
--depth=3D2 ~/foo' did not work? What did I do?" Will do as Mikael
suggested.
--=20
Duy
