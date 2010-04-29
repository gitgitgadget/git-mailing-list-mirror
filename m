From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Multiblobs
Date: Thu, 29 Apr 2010 12:34:59 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1004291231410.16241@ds9.cixit.se>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com>  <loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 21:18:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vj3-00088s-1F
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108Ab0D3TPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:15:49 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:36880 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758098Ab0D3Q5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 12:57:31 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o3TBYxrE019486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 29 Apr 2010 13:34:59 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o3TBYxbf019483;
	Thu, 29 Apr 2010 13:34:59 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 29 Apr 2010 13:34:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146049>

Avery Pennarun:

> But why not use a .gitattributes filter to recompress the zip/odp file 
> with no compression, as I suggested?  Then you can just dump the whole 
> thing into git directly.

The advantage would be that you could look at the history of the individual 
components of the zip/openoffice file and follow changes. When looking at 
the entire zip file (even if using no compression), it is still a compound 
file.

The few times I need to version control zip or openoffice files, I only need 
to version control it *as* a zipped file, I don't need the version control 
to ensure that I get exactly the file out that I put in, just that it is 
zipped in both ends. If Git could do that by unzipping and storing the 
individual components itself, that would be great.

Or if someone could create a "zgit" that would allow me to version control 
such a file by internally unzipping it and storing it in git, and then 
zipping it up on checkout.

Having support for merging files inside the zip file would also be a 
wonderful feature to have, especially if the zip file holds mostly-text data.

-- 
\\// Peter - http://www.softwolves.pp.se/
