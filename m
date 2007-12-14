From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/5] New version of pre-commit hook
Date: Fri, 14 Dec 2007 11:23:19 +0100
Message-ID: <200712141123.27519.jnareb@gmail.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com> <fjsi37$7ji$1@ger.gmane.org> <06C937AD-24B3-496B-AE76-B63CA007BEBB@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 11:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J37i3-0005Uh-B6
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbXLNKXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbXLNKXh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:23:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:7548 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbXLNKXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:23:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so875086nfb.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 02:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=kKwaZ0H80+tPRLqY4N47RJcqiDvw3Rv4EBVAwj1AI+c=;
        b=gK5+nNcx2mBWkb9ZBFfgx4NywzX2MviX71WzG/V3QKIXYo+hrnjTuT2sr7GsvkxWOZjpc1m2eSN3He/eiPWy1hci/Wkybq1+1UQXpyVOzfpGk6u/3oSgGC4rV2FaBUsR6b8Yz+Aiwe3nE+bEYU4q1xR/GtGPrXbmZMXfoFeBg8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JBlI53qaUVlNACRJb1+lVXLWZ/bB+27T6RVKqAb+MJqWOjJTbZpvjgmqaNnQwcNkm9NH0rz847qaK1mJ1a7hJZ2+wFaPF5Y3VU7ehUXAPikzxzUp0WfrDttlx7LzTFaLSckNOuvImXXkRtSiD1ksCAPhit8+R1rG9Sjsk7lswW0=
Received: by 10.86.30.9 with SMTP id d9mr2849593fgd.52.1197627814805;
        Fri, 14 Dec 2007 02:23:34 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.245.165])
        by mx.google.com with ESMTPS id d4sm6020296fga.2007.12.14.02.23.32
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 02:23:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <06C937AD-24B3-496B-AE76-B63CA007BEBB@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68273>

Dnia pi=B1tek 14. grudnia 2007 08:24, Wincent Colaiuta napisa=B3:
> El 14/12/2007, a las 1:17, Jakub Narebski escribi=F3:
>=20
>> Wincent Colaiuta wrote:
>>
>>> Now that "git diff --check" indicates problems with its exit code t=
he
>>> pre-commit hook becomes a trivial one-liner.
>>
>>> -         if (/^(?:[<>=3D]){7}/) {
>>> -             bad_line("unresolved merge conflict", $_);
>>> -         }
>>
>> Aren't you losing this check with rewrite?
>=20
> Yes. If that's a problem then this is definitely a "no-goer".

Well, this only means that it wouldn't be one-liner, but replacing
all whitespace damage checks by "git diff --check" is still a good
idea.

Perhaps we could add 'merge conflict' check to git diff/git applyt too.=
=2E.
--=20
Jakub Narebski
Poland
