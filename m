From: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 10:26:02 +0200
Message-ID: <4458691A.4010007@lumumba.uhasselt.be>
References: <445865A5.5030700@lumumba.uhasselt.be> <4458670A.4080205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 10:26:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCgZ-00026D-Mn
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWECI0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWECI0E
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:26:04 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:3045 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S965115AbWECI0D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:26:03 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id ACDEE1AB18B;
	Wed,  3 May 2006 10:26:02 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 0C0E51AB179;
	Wed,  3 May 2006 10:26:02 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4458670A.4080205@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19459>

Hi,

Andreas Ericsson wrote:

> [...]
>
> Drop -z3 from command-line. git-cvsserver has no compression support.

Thanks!

Ahum, painful. That should have been obvious :), but I'm kinda programmed
to use "-z3 -PAd" whenever I do a cvs update. I didn't even notice the 
z3 in
my own typing :->


Without the z3, it gives the same error/warning as on checkout:
takis@issaris:/tmp/a/b/project-master$ cvs update -PAd
takis@localhost's password:
closing dbh with active statement handles
takis@issaris:/tmp/a/b/project-master$


With friendly regards,
Takis
