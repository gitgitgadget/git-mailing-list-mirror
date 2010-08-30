From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sun, 29 Aug 2010 21:22:25 -0500
Message-ID: <20100830022225.GK2305@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
 <20100828215956.GB5515@burratino>
 <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
 <20100828221655.GB5777@burratino>
 <AANLkTimKQO1MQASvQCz=gpz8FTs3h6FSvm12oFUe7WFD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opu2u-0008Aj-1T
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab0H3CYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 22:24:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60569 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab0H3CYJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 22:24:09 -0400
Received: by gwj17 with SMTP id 17so1825095gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GuPScMCIcAiNVW6jySUHCtuCVB5siyHLPEnmrxWuGgw=;
        b=IrpJ5beLluvQbvvwwSWEMZufgAoKogkoGnMuX4mXCZX5e4OC/lOKoOv+ycpd7+sNP2
         Hk+kEOvwBv8XhiUD/AwE+sbxAI3hc8QGVneq9X/PAxX9XvXF5czOMD87edlDo/XKoqNB
         pqnEqb8wUo15Hv140d7tGrZYcCAoIU2ogJkEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SFmN1VzMS1LxTrCPv+gqn1JFt/jIIsf6EDG8V6UaX/0AlPpq9wTFLiJEdRpY9JVhDU
         r53Os74E37eJeL57X+ngJeWGvg8OrAK6rZnX3I05CyM9ZEIsx8p+n8dIXPfpaOUWMMHz
         i6p+Sm4v7cMGDziYoM+bNbk10sAwhZqu0H304=
Received: by 10.150.181.8 with SMTP id d8mr4599735ybf.440.1283135048660;
        Sun, 29 Aug 2010 19:24:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m11sm7025630ybn.16.2010.08.29.19.24.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:24:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimKQO1MQASvQCz=gpz8FTs3h6FSvm12oFUe7WFD@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154752>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We also have another bug, compiling git with
> SNPRINTF_RETURNS_BOGUS=3DYesGNuIsBuggy and running "git show v0.99.6~=
1"
> on our own repository causes a segfault

That's because the glibc bug is not the bug SNPRINTF_RETURNS_BOGUS is
meant to guard against.  Hopefully no printf implementation has both
bugs. :)
