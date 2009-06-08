From: David Aguilar <davvid@gmail.com>
Subject: Re: mkstemps compat issue
Date: Sun, 7 Jun 2009 18:13:35 -0700
Message-ID: <20090608011334.GA5974@gmail.com>
References: <ED882BBA-E0E7-4CCC-9C6B-72FEBED1C9E0@web.de> <DAD17464-336A-451A-AEFE-26481D6B39B2@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	HaikuPorts developers discussion list 
	<haikuports-devs@ports.haiku-files.org>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 03:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDTQs-0002yi-4p
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 03:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbZFHBNm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbZFHBNl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 21:13:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:40990 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbZFHBNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 21:13:40 -0400
Received: by wa-out-1112.google.com with SMTP id j5so579868wah.21
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 18:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=A5BfMgItJU8eezyDtQer52DYrCZHQKsWL3EnqomPsLw=;
        b=jfAyn6ybtUB325wc/2q0fECPVS1u4A6eoJ6RCd3tIeuKMVlVEWvMpvxXNXGYJ9ATC9
         U8A1oEklUht705itTRic8dU+PUrlcgtWQgJgB8A7JQVlCsqBG5qWO6xtEcaR4XxC+o7+
         1tqSQTvou3pUd/ko0VaubegeTq+82Xq3J38KM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=om17vOXPpg/ZwI4icqXLyfmwzXIP7q4aApUE0UFDViv2hstLpgrye5aIddaaVyn7Jh
         ftAbbPv/cvzCSVxLwaDrPVqDBILccMECj9qyLNQNYmhzw++ixGHlJolwS9Wit/RSo5Ty
         tGLsVE7Zlh65yWCje9mB5SKWJhKHX0I8hGefI=
Received: by 10.114.205.8 with SMTP id c8mr10142103wag.31.1244423622452;
        Sun, 07 Jun 2009 18:13:42 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j15sm4687781waf.16.2009.06.07.18.13.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 18:13:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DAD17464-336A-451A-AEFE-26481D6B39B2@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121027>

On Sun, Jun 07, 2009 at 02:49:16PM +0200, Andreas F=C3=A4rber wrote:
>
> Am 07.06.2009 um 14:32 schrieb Andreas F=C3=A4rber:
>
>> The merge commit b11cf09043f18b368ec0d988f064ea21247c843d introduced=
 a=20
>> git_mkstemps function in path.c, using mkstemps for the =20
>> implementation. Unlike mkstemp that function is not part of POSIX, s=
o=20
>> we seem to need a NO_MKSTEMPS option and corresponding alternative c=
ode=20
>> path.
>>
>> Any suggestions how to best replace mkstemps?
>
> Sorry for the noise... NO_MKSTEMPS=3DYesPlease does work correctly if=
 =20
> typed correctly. (Thanks for the hint!)

Thanks for keeping an eye on it.

I'm still keeping my eye on the patch that introduced the
basename() compat function to see if we missed any Makefile
settings for the non-linux platforms.  We support a lot of
platforms! =3D)


--=20

	David
