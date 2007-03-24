From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Sat, 24 Mar 2007 12:16:35 +0000
Message-ID: <200703241216.48177.andyparkins@gmail.com>
References: <874poc88ix.fsf@rho.meyering.net> <200703231615.28350.andyparkins@gmail.com> <87wt1651bj.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 13:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV5Du-0003xJ-5e
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 13:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbXCXMTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 08:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXCXMTl
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 08:19:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:65431 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbXCXMTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 08:19:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1233127uga
        for <git@vger.kernel.org>; Sat, 24 Mar 2007 05:19:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qwy31wxr40bYiNCR34pePzHHpcRiny9UTLuTd2ehWKm1hhHcYGugjFu+4YMshn8nJrh6drGMLRpj00lscqYeestcmB6rbFHJcezPz07XAlIxCRQAvR0KPzTJt3oHDQ3K+c3KyrKXYT4kOr1PhhgsOmvERUTGvbMYglrYse+2dxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aqdMM8Mti0JhOuVKv8ZbOCZl7LUa0GHWdSGFrqcln7RzNMmEKtrLOckiOZkIHS0E1nZlTnVBrQwZg+GT/iF1EHqDQsPRutvyvhqjcl3Ep69IbRe4YTo9RdCpNtkUh5ELF0bteAD1PYBmSmgZn39nHxa9+NOMJd8TepX05l+UpVE=
Received: by 10.67.119.13 with SMTP id w13mr8504471ugm.1174738779654;
        Sat, 24 Mar 2007 05:19:39 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 30sm5653790ugf.2007.03.24.05.19.38;
        Sat, 24 Mar 2007 05:19:39 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <87wt1651bj.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42996>

On Saturday 2007, March 24, Jim Meyering wrote:

> There is a legitimate need for this functionality, and -f does
> usually work, so how about a compromise:
>
>   Include support for using sendmail's "-f envelope-sender" option
>   in the default hook, but enable it only if/when
> hooks.envelopesender is set in the config file.

Perfect.  Now that I can't think of any objection to.  


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
