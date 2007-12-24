From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Mon, 24 Dec 2007 13:03:25 -0800
Message-ID: <20071224210325.GA7242@mail.oracle.com>
References: <1198216860-487-1-git-send-email-git@davidb.org> <1198522902-12117-1-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 22:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6uT4-0001nT-Bv
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 22:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXLXVDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXLXVDq
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 16:03:46 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:34723 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbXLXVDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 16:03:46 -0500
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id lBOL3b3F026456;
	Mon, 24 Dec 2007 14:03:38 -0700
Received: from acsmt354.oracle.com (acsmt354.oracle.com [141.146.40.154])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBO8PEHm023312;
	Mon, 24 Dec 2007 14:03:36 -0700
Received: from ca-server1.us.oracle.com by acsmt354.oracle.com
	with ESMTP id 6523260061198530207; Mon, 24 Dec 2007 13:03:27 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J6uSN-0003Qq-89; Mon, 24 Dec 2007 13:03:27 -0800
Content-Disposition: inline
In-Reply-To: <1198522902-12117-1-git-send-email-git@davidb.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69221>

On Mon, Dec 24, 2007 at 11:01:42AM -0800, David Brown wrote:
> There are a few options to git-send-email to suppress the automatic
> generation of 'Cc' fields: --suppress-from, and --signed-off-cc.  However,
> there are other times that git-send-email automatically includes Cc'd
> recipients.  This is not desirable for all development environments.
> 
> Add a new option --suppress-cc, which can be specified one or more times to
> list the categories of auto-cc fields that should be suppressed.  If not
> specified, it defaults to values to give the same behavior as specified
> by --suppress-from, and --signed-off-cc.  The categories are:
> 
>   self   - patch sender.  Same as --suppress-from.
>   author - patch author.
>   cc     - cc lines mentioned in the patch.
>   cccmd  - avoid running the cccmd.
>   sob    - signed off by lines.

+   all    - all of the above, thus only honoring '--to', '--cc', and
             '--bcc'

Joel

-- 

"The nice thing about egotists is that they don't talk about other
 people."
         - Lucille S. Harper

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
