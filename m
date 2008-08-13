From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: your mail
Date: Wed, 13 Aug 2008 20:46:13 +0530
Message-ID: <20080813151613.GA6448@skywalker>
References: <1218639268-12267-1-git-send-email-aneesh.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, git@vger.kernel.org
To: aneesh.kumar@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 13 17:17:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTI6U-0005z3-3B
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYHMPQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYHMPQb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:16:31 -0400
Received: from E23SMTP01.au.ibm.com ([202.81.18.162]:49718 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbYHMPQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:16:30 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m7DFGnGr001479
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 01:16:49 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7DFGSfi255904
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 01:16:28 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7DFGRPT026708
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 01:16:28 +1000
Received: from skywalker ([9.77.121.107])
	by d23av03.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7DFGDeP026560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 01:16:24 +1000
Content-Disposition: inline
In-Reply-To: <1218639268-12267-1-git-send-email-aneesh.kumar@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92229>

On Wed, Aug 13, 2008 at 08:24:28PM +0530, aneesh.kumar@gmail.com wrote:
> From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> 
> topgit: Implement tg-import
> 
> This can be used to import a set of commits
> between range specified by range1..range2
> This should help us to convert an already
> existing quilt, stgit branches to topgit
> managed one
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> 
> ---
>  Makefile     |    2 +-
>  README       |    7 ++++++
>  tg-create.sh |   22 ++++++++----------
>  tg-export.sh |    2 +-
>  tg-import.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 87 insertions(+), 14 deletions(-)
> 

tg-create.sh and tg-export.sh should not be part of this patch. I will
send a new version.

-aneesh
