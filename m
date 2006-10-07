From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 7 Oct 2006 10:30:46 +0200
Message-ID: <20061007083046.GB12900@lumumba.uhasselt.be>
References: <20061006212616.GA5175@lumumba.uhasselt.be> <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE> <20061006220401.a4485d67.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 07 10:31:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW7ap-0007YB-La
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 10:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWJGIat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 04:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWJGIat
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 04:30:49 -0400
Received: from student.uhasselt.be ([193.190.2.1]:47113 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP
	id S1750723AbWJGIas (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 04:30:48 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by student.uhasselt.be (Postfix) with ESMTP id B604111E7
	for <git@vger.kernel.org>; Sat,  7 Oct 2006 10:30:46 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from lumumba.uhasselt.be (lumumba.uhasselt.be [193.190.9.252])
	by student.uhasselt.be (Postfix) with ESMTP id 98EDD13AE
	for <git@vger.kernel.org>; Sat,  7 Oct 2006 10:30:46 +0200 (CEST)
Received: by lumumba.uhasselt.be (Postfix, from userid 1000)
	id 8CE99EDB0F; Sat,  7 Oct 2006 10:30:46 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061006220401.a4485d67.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28457>

Hi,

Thanks for your quick reply!

On Fri, Oct 06, 2006 at 10:04:01PM -0400 or thereabouts, Sean wrote:
> If a server is having problems delivering the Git repo over WEBDAV,
> timeout after two minutes so that a regular http transfer can
> be tried.
> [...]
> Maybe the real solution is just to figure out and fix whatever is
> going on with the WEBDAV server and forget this patch.
I had a quick glance at the Apache2 config on this server:
grep -i dav /etc/apache2/apache2.conf
# redirects for folders with DAV methods.
BrowserMatch "^WebDAVFS/1.[012]" redirect-carefully

Google showed me some bugs occurring on other software where they said
the problems were happening because the redirect weren't handled
correctly. I haven't got a clue about this, but thought mentioning it
might ring someone's bell :)

With friendly regards,
Takis
-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
