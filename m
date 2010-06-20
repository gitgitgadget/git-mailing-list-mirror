From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Sun, 20 Jun 2010 14:33:15 +0200
Message-ID: <AANLkTikjOuTWQv7hrT1gQTXTG2igVeI7kWBzX7cCauMt@mail.gmail.com>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 14:33:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQJiZ-0002c9-20
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 14:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab0FTMdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jun 2010 08:33:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35042 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0FTMdg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jun 2010 08:33:36 -0400
Received: by vws9 with SMTP id 9so68858vws.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PCDAiCH2PZM7RoscqXWLBLmOzwipOYmEH/TqkV0T6co=;
        b=YY7oQ+7xgCqVxzO3U0Chixupvq1V2hh/dRVo0ogH+AuUDXMRnW1XJ2RSRYqp+JrgEc
         ONnDpH+ndvYIcMlvSQgSZ/FWBQDPecMgaC6gHayD+i3Gf2Y2/+yl+qI5Z1re5/4d7Yf2
         6XXM3ZGe/IDUAEx5SyaxR0hMQKiQy3+U3hHCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lMM9o/9SBDc1LEdMoPTplSU4yN0BfEt/0rzsUoc5cbmj9+P1FW5+8NEmWUWztezydD
         lSGIjdu0op0+XgIk0OJ9c2fcLVzMLaRvawWj11U9EpsomdSHm0yee1WU20T5ncJXJzjM
         0SygC8NHrBK9019Bn5kUICRJDotGfMl/yEiZI=
Received: by 10.229.38.147 with SMTP id b19mr1827923qce.253.1277037215168; 
	Sun, 20 Jun 2010 05:33:35 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sun, 20 Jun 2010 05:33:15 -0700 (PDT)
In-Reply-To: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149395>

Hi Junio,

Junio C Hamano wrote:
> * rr/svn-export (2010-06-10) 7 commits
> =C2=A0- Add LICENSE
> =C2=A0- Add SVN dump parser
> =C2=A0- Add infrastructure to write revisions in fast-export format
> =C2=A0- Add stream helper library
> =C2=A0- Add library for string-specific memory pool
> =C2=A0- Add cpp macro implementation of treaps
> =C2=A0- Add memory pool library
>
> I recall there was another round of re-roll planned for this one.

Right. I'm currently busy working on svnclient_ra with Daniel while
David is currently working on simplifying the underlying data
structures. The series for a standalone svn-fe in contrib/ is still
pending; it was suggested by Jonathan, but I haven't seen him around
this week, so I'll also try to finish that off within the next few
days. When we get that series merged into `pu`, people will actually
be able to test this series.

-- Ram
