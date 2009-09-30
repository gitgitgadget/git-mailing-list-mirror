From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: search branches which contain a blob id
Date: Wed, 30 Sep 2009 15:43:12 +0200
Message-ID: <1164C259-0573-4F27-990C-743C6710EA59@dbservice.com>
References: <8a906e45ab8e0252a0be11e4d4e9389e@blinkeye.ch>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Reto Glauser <linux@blinkeye.ch>
X-From: git-owner@vger.kernel.org Wed Sep 30 15:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MszTC-0001vI-Qa
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 15:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbZI3Nnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 09:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZI3Nnl
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 09:43:41 -0400
Received: from office.neopsis.com ([78.46.209.98]:53623 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZI3Nnk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 09:43:40 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Wed, 30 Sep 2009 15:43:38 +0200
In-Reply-To: <8a906e45ab8e0252a0be11e4d4e9389e@blinkeye.ch>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129342>


On Sep 30, 2009, at 2:38 PM, Reto Glauser wrote:

> To get a list of branches which contain a specific commit we use:
>
> $ git branch --contains <commit id>
>
> Is there a similar way to get a list of branches with respect to a
> specific blob (e.g. the actual code change a commit introduces)?

Blob == contents of a file. To see what code changed you need to  
compare two blobs (or trees).

> Obvious use-case: One isn't interested in the commit information  
> (author,
> parent, date) but merely in the set of changes a commit introduces.

git log -S'string to search for'

searches the history for commits which introduced or removed that  
string from a file.

Or 'git log -p', if you want to see the diff alongside the other  
information that log gives you.

tom
