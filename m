From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/16] Subtree clone proof of concept
Date: Sun, 1 Aug 2010 16:58:37 +1000
Message-ID: <AANLkTimEOsNvCYyLmbLbMXEoJL-EPQbjE+iD5y7prLAt@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<AANLkTinMBAikByLfOi5sXbcRfCsYtYqMCNSTykRofQyo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 08:58:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfSVR-00023G-6u
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 08:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab0HAG6j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 02:58:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38500 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab0HAG6j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 02:58:39 -0400
Received: by wwj40 with SMTP id 40so2856626wwj.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CT67Rwb7fNOJHdMk2AkkV/LuaGYeS0fxc5jkK3eswwU=;
        b=OUdoWwSkDSCeO7vXVE6Yajc2wWxNozuRitrEFlKpw6eRSAAMUYI21nIEnUTWHdfEfN
         xjfC0m2WTcOqemqLJVrTPUd9XKT4NEgMEkrvflglchHAAPlAjsK1oLpnhASAsHOYoxQH
         6NhKU7H+QVdjPG6xldLG224K45ZwVN/k6ZgRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XtoqaFkeqAPRAF216pQOpyIcpmuW7iYXPP7+O/nR1SJNwacxehCOkXy5UuySyUGbbg
         H6wuphOpc3HaLc7OPn+zknZ+oy8KYS517BHTFNo+hUU8uQ3QXERHLpxiJIBQHboq/RV6
         j3EjMcALRtUn3D7ArOhAZfnBPgKlsJi/sdLWg=
Received: by 10.216.74.75 with SMTP id w53mr556052wed.86.1280645917797; Sat, 
	31 Jul 2010 23:58:37 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Sat, 31 Jul 2010 23:58:37 -0700 (PDT)
In-Reply-To: <AANLkTinMBAikByLfOi5sXbcRfCsYtYqMCNSTykRofQyo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152369>

2010/8/1 Sverre Rabbelier <srabbelier@gmail.com>:
>> Space consumption is 24MB (58MB for full
>> repo). =C2=A0Not really impressive, but if one truely cares about di=
sk
>> space, he/she should also use shallow clone.
>
> Can they be combined to create the fabled narrow checkout?

Yes. For the record, --subtree=3DDocumentation/ with --depth=3D1 made a=
 pack of 5MB.
--=20
Duy
