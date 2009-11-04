From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Accessing the reflog remotely
Date: Wed, 4 Nov 2009 11:58:20 +0100
Message-ID: <684BAF22-EBF5-47F0-9363-3E1B60B4A328@dbservice.com>
References: <vpqljimpr95.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 04 11:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dZw-0007ZM-AJ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbZKDK6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 05:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbZKDK6x
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:58:53 -0500
Received: from office.neopsis.com ([78.46.209.98]:33271 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbZKDK6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 05:58:53 -0500
Received: from [10.9.5.29] ([147.88.200.144])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Wed, 4 Nov 2009 11:58:46 +0100
In-Reply-To: <vpqljimpr95.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132075>


On Nov 4, 2009, at 10:35 AM, Matthieu Moy wrote:

> Hi,
>
> I guess the answer is "no", but I'll still ask in case ...
>
> Is it possible to access the reflog of a remote repository other than
> logging into this repository?
>
> My use-case is the following: I want to checkout "the last revision
> pushed in master on ssh://host/repo/ on day D at midnight" (to fetch
> the project of my students ;-) ). If it were locally, I'd do
>
>  git checkout 'origin/master@{Nov 3 00:00:00}'
>
> But this tells me where _my_ local master was on that date (i.e. the
> last revision I had pulled).


Keep in mind that bare repos don't have reflogs by default, so unless  
you enabled the reflog manually there is none.

tom
