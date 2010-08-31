From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 11:29:02 +1000
Message-ID: <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
	<AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: cdahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 03:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqFf8-0007B3-0P
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 03:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329Ab0HaB3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 21:29:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45408 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab0HaB3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 21:29:04 -0400
Received: by wyb35 with SMTP id 35so7290756wyb.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 18:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VUPfoAYZCmSuw8z4AfOKarnr9OmKJhhW/ePUxRCE3p4=;
        b=aj07q+fSAWIp5v13KAAUn9uU9oKxnzOAK1OtsNz5pOzzkp6qU47NijtZMsqfKdKMhJ
         HGGPfNPd8svg0D5qmvvKB+2jR4WUjABdfRKl5AAi0EzUnc0GZWkXn8EJWE7H+b1hCpsF
         F6ZYv0hPvTTKckcUv3KUDOPvDcfaz64rgaqPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sTDLPVWxMnR5dlRZqPZhLSd32iFdPjIlIqmBIXJdl0pxljtKmtyXVaR4pYQtZDiRid
         5VPyx9ASydkYWq+Z7ubNlD2Fac2xTZMRnkJdbxxdwujupu6Ni+03X1vkjBqtGgNECAdE
         vIoPJDjIZaOGwEzO9vq2FbQRz+gELnTGzF1qw=
Received: by 10.216.49.212 with SMTP id x62mr5659970web.55.1283218143251; Mon,
 30 Aug 2010 18:29:03 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Mon, 30 Aug 2010 18:29:02 -0700 (PDT)
In-Reply-To: <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154875>

On Tue, Aug 31, 2010 at 7:17 AM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 8:59 PM, =C2=A0<cdahlin@redhat.com> wrote:
>> From: Casey Dahlin <cdahlin@redhat.com>
>>
>> This isn't really what I'd normally call ready for public consumptio=
n, but
>> since there's been some minimal list chatter on a similar subject I =
figured I'd
>> put this out there early.
>>
>> git-hive is a peer to peer service for exchanging branches. When sta=
rted it
>> runs a small daemon to publish your repository on a random (or speci=
fied) port.
>> Two hive daemons connected to oneanother can exchange branch lists a=
nd
>> introduce eachother to more hive daemons to widen the network.
>
> =C2=A0p.s. is there any location where, in diagrammatic form, the
> protocol's described?

Also a short tutorial how to use it would be nice.

I take it I can put different repositories (say wine.git and git.git)
in the hive. When I fetch git.git from the hive, it won't fetch
wine.git?
--=20
Duy
