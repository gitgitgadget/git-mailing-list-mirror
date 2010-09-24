From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 12:39:30 -0700
Message-ID: <07D0999B-558C-46BE-A44A-3BB4CDE31B65@gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com> <AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com> <4C9CE212.3090507@obry.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Fri Sep 24 21:39:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzE7X-0000KW-0c
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab0IXTjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 15:39:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41143 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab0IXTjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 15:39:35 -0400
Received: by pvg2 with SMTP id 2so774299pvg.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=GA4bXsGQYwa/dw4A/zEVtfvfLikTcY88EEsMuxZbtpo=;
        b=n39+qLkC0HkQaRPO7U1aXxfpvUw7WGl89/+cAibYmefPKYFmMjOSEM2auU5YtoaNA5
         E6Rkv2J0P/St+/AHMDGeqomgNdF3AzYdhxwSUE0zm0FJ+6XUzflhq7U49PC8BIJKSmNP
         P+jim7mCC63sSQ0qG51euGniiHP4Y/ywDZz58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=J+uGQJkT6bo1gN0fWDoxHwam+KmWIe3mGjyOR0YHe2sA76wHbBIS5hbex1YbAq3sia
         kLQuhHlTG1BpRav2gGtHC2lVoqBRkFPtdFhqFmEdiDYoHTzjeQ8YTeN6VHOvTNk0J1JF
         nxC3v4eSEbBEi2WsY5q1u2W7KF8ahLbc/YnaQ=
Received: by 10.142.142.8 with SMTP id p8mr3142009wfd.316.1285357174658;
        Fri, 24 Sep 2010 12:39:34 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id o16sm2694443wfh.7.2010.09.24.12.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 12:39:33 -0700 (PDT)
In-Reply-To: <4C9CE212.3090507@obry.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157045>

On Sep 24, 2010, at 10:38 AM, Pascal Obry wrote:

> Le 24/09/2010 15:08, Tor Arntsen a =E9crit :
>> 5.8 as minimum is probably for the best. It's not that just you can
>> compile a newer version (5.8), more importantly, Perl 5.8 is =20
>> available
>> as a package from those semi-official 3party repositories for most
>> systems (at least the *nix systems I have access to), except for =20
>> those
>> like Irix 6.2 where it's hopeless anyway (perl 5.0). But I only have
>> access to irix/aix/solaris/tru64 in addition to Linux.
>
> 5.10 is available on Cygwin.

Lamp doesn't have 5.8 (only 5.6.1), but it doesn't have svn, either.

Josh
