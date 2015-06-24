From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 21:31:11 +0300
Message-ID: <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: BGaudreault Brian <BGaudreault@edrnet.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 20:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7pSK-0003L0-2M
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 20:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbFXSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 14:31:22 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:32910 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbFXSbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 14:31:21 -0400
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t5OIVBZ5031673;
	Wed, 24 Jun 2015 21:31:12 +0300
In-Reply-To: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272575>

On Wed, 24 Jun 2015 18:18:00 +0000
BGaudreault Brian <BGaudreault@edrnet.com> wrote:

> If someone downloads code to their notebook PC and leaves the
> company, what protection do we have against them not being able to
> access the local code copy anymore?

What do you mean by "local code"?
That one which is on the notebook?
Then you can do literally nothing except for not allowing cloning your
Git repositories onto random computers in the first place.

If you instead mean the copy of code available in the repositories
hosted in your enterprise then all you need to do is to somehow
terminate the access of that employee who's left to those repositories.
(This assumes they're accessible from the outside; if they aren't, the
problem simply do not exist.)
