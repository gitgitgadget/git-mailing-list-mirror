From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 01/12] gitweb: introduce remote_heads feature
Date: Sun, 26 Sep 2010 19:19:10 +0000
Message-ID: <AANLkTikotGEOOeUOwz03xtL09fV+oycV3yG1O4hQhoQB@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1285344167-8518-2-git-send-email-giuseppe.bilotta@gmail.com>
	<201009261924.06237.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 21:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozwkm-0002C3-Gt
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 21:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab0IZTTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 15:19:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58554 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173Ab0IZTTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 15:19:11 -0400
Received: by iwn5 with SMTP id 5so4092427iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hs1HE+nV1oIJFWxmWS/QLWq/amFERlwvKg+mbVPVQws=;
        b=kR8RK4gcjmf8vhvBig97wtJ54qRh4d8DgOyA4ySUepDGO521v2aZEYHrqZllI84z+Q
         NuQWxs6T8kfgIeYrVekXni4bXYDDV9vayNzPBrVS624NIaY8CXtsLoITVcxeDjPyBGP6
         IteorgWAWFci3zPBnjo8M9GrLzmFnO9gFaRFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UfvmZ/5za1sAOs5ZSMB8MF3y2QWtflKginD44IQx8m9WvGMcylToD71HSwwfnUzBdg
         My11dxgOCNVetvtle5h86Y1FIT0Cw/ioN7d8gdtQBsNLmoS9ZrhcAPBOlkKDJMuOIJJd
         7jTszqbMbQ+iAKmxerThEhBw+cA5C9GLoSxPg=
Received: by 10.231.10.200 with SMTP id q8mr7780268ibq.83.1285528750173; Sun,
 26 Sep 2010 12:19:10 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 26 Sep 2010 12:19:10 -0700 (PDT)
In-Reply-To: <201009261924.06237.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157255>

2010/9/26 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>> + =C2=A0 =C2=A0 # Make gitweb show remotes too in the heads list
>
> Very minor nitpick: it should probably be (but I am not a native
> English speaker, so I migh be mistaken)
>
> =C2=A0+ =C2=A0 =C2=A0 # Make gitweb show also remotes in the heads li=
st

Maybe:

    # Configure the display of remotes in the heads list

or

    # Toggle the display of remotes in the heads list

?
