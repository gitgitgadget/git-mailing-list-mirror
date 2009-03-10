From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Tue, 10 Mar 2009 10:33:49 -0500
Message-ID: <49B6885D.9020702@gmail.com>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903100143550.6358@intel-tinevez-2-302> <49B5DDA6.8070108@gmail.com> <alpine.DEB.1.00.0903101132360.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 16:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3yw-0004eR-JK
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 16:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbZCJPdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbZCJPdh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 11:33:37 -0400
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:42193 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755120AbZCJPdg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 11:33:36 -0400
Received: from nat.asynchrony.com ([66.236.120.131] helo=[192.168.11.131])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mr.gaffo@gmail.com>)
	id 1Lh3vb-0002sg-8I; Tue, 10 Mar 2009 09:31:35 -0600
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903101132360.14295@intel-tinevez-2-302>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112827>

Johannes,
	Your points make sense, thank you for clarifying, it helps 
me understand what the underlying concerns are. The attitude doesn't really 
help.
	Does Junio's counter solution where git would prompt for the
password if the username contained a url solve your concerns with unsecure
config variables? The patch would be just a bugfix to current functionality.
	Also, libcurl does not warn you that you have an insecure netrc file.
Just tried it with 7.19.4 on cygwin and FC9.

Thanks for the feedback,
	Mike
