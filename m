From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH V5 16/17] Add tests for line history browser
Date: Thu, 12 Aug 2010 20:24:15 +0800
Message-ID: <AANLkTinYaOhNNBj9_6mFF3azaFAwUJgeLVkyax2ZbVOm@mail.gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
	<1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
	<AANLkTi=qvywaiwYpr7ZZ6Gf0i_curaLr0E8gRLD5WTK-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 14:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjWpe-0007Yt-PT
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 14:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759837Ab0HLMYW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 08:24:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63103 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0HLMYV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 08:24:21 -0400
Received: by qwh6 with SMTP id 6so1443315qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JBrg2hYbQRWs6ABn5FvvqyZ1I+gJKF/3OwUyySnfpyA=;
        b=meQplpmxzE4UDU24NAnvrZnomJ4XDVrp3m8V2Fy8BhvSWUDw9FWky2KTXzYFsaWJbu
         oWjcviTAW8QQtuDuu8jt2nEInazWA3Y13CmIL2xztwbueGj92ejcsuCR6tqQYFm4WG9k
         j2nLkcCihjTVgYg3zEDr6NGzaJjEz7d31mfTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xaxQ609a8tMh8G/ZCNJ1OaaoN4uTipQgE1Xka7ThzSlbaYfo/0jGJ6J1AzurqQos7A
         4u8Cz1Exg7SYJ41HAbAqZUmV+D9BhK9KnKicDWF8hfMHwSRjp7mqb+2JVRX6/NZqc2s2
         Vt+DC99auhBfIAkieqHd3/ecq/pHqnluhGyao=
Received: by 10.224.66.167 with SMTP id n39mr11849499qai.391.1281615856595; 
	Thu, 12 Aug 2010 05:24:16 -0700 (PDT)
Received: by 10.229.231.21 with HTTP; Thu, 12 Aug 2010 05:24:15 -0700 (PDT)
In-Reply-To: <AANLkTi=qvywaiwYpr7ZZ6Gf0i_curaLr0E8gRLD5WTK-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153368>

Hi =C6var,

   Seems this is the SP problem. Do you apply this series with
--whitespace=3Dfix ? This will erase some spaces in the diff files,
so...

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
