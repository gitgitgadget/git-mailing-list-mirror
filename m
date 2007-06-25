From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] config: Add --null/-z option for null-delimted output
Date: Tue, 26 Jun 2007 01:29:46 +0200
Message-ID: <200706260129.47518.jnareb@gmail.com>
References: <200706220156.01175.jnareb@gmail.com> <11827802382221-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 26 01:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2xuU-0001bP-Dh
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 01:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbXFYXXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Jun 2007 19:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXFYXXw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 19:23:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60392 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbXFYXXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 19:23:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1398501ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 16:23:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jsmBHNVeNpsa/8gfGqR7I7WFX4BO4Ybcj/J3F6HYNiyhn3omtQ7AasY+cKu+UdZ91aR2cM4x3uv3n3AicLRFNaaD8DdCzZ7NQocOwPwt+v+ZonsOlqPjyTJz+KSdqiW3+wGzcpHE2pIncp5g8DsXOg7MeLubVIvH8qbQD9zvt6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P4266AWtNbUy/QL/vmembERcbZwHTjBQTNy/0NawRYHyZSg5osTfCa5ViYeK6R9UF/GHx83uP7U3T7jHzow3tRQ4MkKCkJZ8mFqY3NG8MIF5pFTyH9XPQbsCRXba1gcDPMiSXfi7zuuINxLuByhUHvu3+3WyrTzbkzI0kda5zLA=
Received: by 10.67.103.16 with SMTP id f16mr5484146ugm.1182813830365;
        Mon, 25 Jun 2007 16:23:50 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w7sm12508872mue.2007.06.25.16.23.48
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2007 16:23:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11827802382221-git-send-email-frank@lichtenheld.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50937>

=46rank Lichtenheld wrote:

> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
printf("%s", key_);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
printf("%s",key_);
> =A0=A0=A0=A0=A0=A0=A0=A0}

That is a mistake, I think?

--=20
Jakub Narebski
Poland
