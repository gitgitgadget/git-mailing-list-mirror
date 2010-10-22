From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Fri, 22 Oct 2010 17:17:54 +0200
Message-ID: <201010221717.55818.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JNq-0005jj-69
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab0JVPSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 11:18:13 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62781 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab0JVPSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:18:12 -0400
Received: by pvb32 with SMTP id 32so132567pvb.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1Ie1eOrLjeR+VQCh+jC/WCQdugaD+Dt2C/us5CoRt8M=;
        b=t/LQlFcuF6N4zBnVz7gXyCoSCdGMexJbad7iy9NEQ70D47bc7hG20Wes03UpKUC/T/
         Jgg34CTIVLwswmXxd/ggI0lIRP6k6hia+a8xGhKClZ0A0HZo8JGE8Jur5hL6k3ykRsOd
         w67/+z8O/YVprJm5tR76AWZ3V/1o7/vt1rqnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K9knZiTKtEzrPHtVkg24SUS7okl23mBu1e6zVV7Hbi52Q9ju9vk3VoLwcFjZRbvtGg
         H0W4hrrk5V7QDu6QZ4QcS0ybVF0gAIYUcV+JZKpGls01Ni+tEMmu4Lu0Ea0W4msmcO6+
         lm5QiCzGRmsqa3UvxDwY53XxVf8Nus7zTQuvs=
Received: by 10.103.192.13 with SMTP id u13mr2970126mup.97.1287760691775;
        Fri, 22 Oct 2010 08:18:11 -0700 (PDT)
Received: from [192.168.1.13] (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id a25sm1488721fab.37.2010.10.22.08.18.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 08:18:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cover.1287690696.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159698>

On Fri, 22 Oct 2010, Thomas Rast wrote:

> Thomas Rast (3):
> =A0 Documentation: Move variables from config.txt to separate file
> =A0 Documentation: complete config list from other manpages
> =A0 Documentation: move format.* documentation to format-patch

Note that patches 1/3 and 2/3 didn't made it to git mailing list
beause they were too large for vger anti-SPAM filter.  The 2/3
can use rename detection (-M) to be much smaller.

--=20
Jakub Narebski
Poland
