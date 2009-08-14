From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: trailling whitespace with git am ?
Date: Fri, 14 Aug 2009 23:43:02 +0200
Message-ID: <81b0412b0908141443vc54c009o9ec39b3f617311dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?PICCA_Fr=C3=A9d=C3=A9ric=2DEmmanuel?= 
	<frederic-emmanuel.picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc4YI-00050o-9p
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 23:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbZHNVnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 17:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbZHNVnE
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 17:43:04 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:43338 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZHNVnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 17:43:02 -0400
Received: by bwz22 with SMTP id 22so1371676bwz.18
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=5klxKEvA+wtLVoTDvUtOkXCni2nbRbrF7g4Lff2b3uo=;
        b=CGnxhMFvJEZ7lkNEJsjj2bNy0/Ia9vDa4zqjsMkc7IiaRD1wv8ys/0SFstVrAOK0qn
         uy+qHPFCt704LAlnbQp6/W6K3jLfUuTcsZM+b96IwNhi9wrt9Fp6OkPMiHSRcgBFMgCK
         Ynk/80KgZoYjwpQKHHn7suX+RX96R7MdHLSZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AEoMwnQbn7T1w14ZOXPHdqGKYE6BFbrnOk3w283ILBkwpj6vRs6TK6gIvQrYN6NNHO
         d7m1t6kmCG7SFAQ0WcUeMBkHnpiqdrAoZJpHf288KIigjK1vY4tel6UzooQKrYbkRiHS
         PsS7oCNqbziPE98oK4t5kTjmpnzEQuEse2Bg4=
Received: by 10.204.160.70 with SMTP id m6mr1358785bkx.212.1250286182863; Fri, 
	14 Aug 2009 14:43:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125960>

On Fri, Aug 14, 2009 at 22:50, PICCA
=46r=C3=A9d=C3=A9ric-Emmanuel<frederic-emmanuel.picca@synchrotron-solei=
l.fr>
wrote:
>>=C2=A0> git am --whitespace=3Dfix was sufficient to apply the patch
>
>> Depending on your situation it can be an overkill: it'll remove _all=
_ trailing
>> white space. Not just \r (CR).
>
> so /s /t and /r are the same things for git ?
>

almost. For git-apply's whitespace fixing code. Why?
