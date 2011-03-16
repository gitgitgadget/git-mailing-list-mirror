From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
	CGI script
Date: Wed, 16 Mar 2011 10:44:10 -0400
Message-ID: <1300286650.28805.29.camel@drew-northup.unet.maine.edu>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
	 <20110316143420.GA15371@elie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:44:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzrxx-0003NL-9R
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab1CPOog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 10:44:36 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:49980 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1CPOo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 10:44:27 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p2GEiDw5024539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Mar 2011 10:44:14 -0400
In-Reply-To: <20110316143420.GA15371@elie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p2GEiDw5024539
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1300891455.7392@K2GlyZHNU766p537//+jgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169159>


On Wed, 2011-03-16 at 09:34 -0500, Jonathan Nieder wrote:
> Hi,
> 
> Drew Northup wrote:
> 
> > I just upgraded my Gitweb package (I'm testing the EPEL RHEL5 latest;
> > I'm not too happy with them tweaking the paths) and as I should have
> > expected all of my Gitweb configuration is now gone.
> 
> In gitweb/README, I see:
> 
> | You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
> | (defaults to 'gitweb_config.perl' in the same directory as the CGI), and
> | as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).
> 
> Hope that helps,
> Jonathan

I apparently missed that. Alas, I didn't see it in the code when I was
setting my values so I assumed that it wasn't available. Perhaps we can
make this a little more obvious? I'll go try that out and see if I can
make it break--putting it in the same directory definitely wouldn't have
helped this time.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
