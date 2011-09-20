From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] contrib/hooks: adapt default Debian install location
	for contrib hooks
Date: Tue, 20 Sep 2011 15:38:12 -0400
Message-ID: <1316547492.14618.10.camel@ddn-tmpdesk.its.maine.edu>
References: <20110920111914.17913.qmail@d29ca435be5a3d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:40:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66BV-0006kJ-FP
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab1ITTko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:40:44 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:41619 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1ITTko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:40:44 -0400
Received: from [130.111.39.171] (ddn-tmpdesk.its.maine.edu [130.111.39.171])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p8KJcCEx027139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Sep 2011 15:38:17 -0400
In-Reply-To: <20110920111914.17913.qmail@d29ca435be5a3d.315fe32.mid.smarden.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p8KJcCEx027139
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1317152375.54331@x32vdNTOgjVVFPq46ycFGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181783>


On Tue, 2011-09-20 at 11:19 +0000, Gerrit Pape wrote:
> Placing the contrib hooks into /usr/share/doc/ wasn't a good idea in the
> first place.  According to the Debian policy they should be located in
> /usr/share/git-core/, so let's put them there.
> 
> Thanks to Bill Allombert for reporting this through
>  http://bugs.debian.org/640949
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  contrib/hooks/post-receive-email     |    4 ++--
>  templates/hooks--post-receive.sample |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

What is the rationale for applying this outside of the land of Debian? I
understand the EPEL/Fedora crew are putting those example hooks
into /usr/share/git-gore, but I want to know why that should become the
standard in git.git.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
