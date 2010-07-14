From: "C. Michael Pilato" <cmpilato@collab.net>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 13:31:02 -0400
Organization: CollabNet, Inc.
Message-ID: <4C3DF456.20803@collab.net>
References: <20100709142910.GB20383@debian> <20100713201105.GN13310@ted.stsp.name> <20100714153206.GH25630@jack.stsp.name> <20100714160149.GA7561@debian> <20100714172429.GC25861@ted.stsp.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will P
X-From: git-owner@vger.kernel.org Wed Jul 14 19:31:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5nf-00031T-H4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab0GNRbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:31:08 -0400
Received: from sp-exchfea.sp.corp.collab.net ([204.16.106.198]:11218 "EHLO
	sp-exchfea.sp.corp.collab.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721Ab0GNRbH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 13:31:07 -0400
Received: from [204.11.125.142] ([204.11.125.142]) by sp-exchfea.sp.corp.collab.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jul 2010 10:31:05 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
In-Reply-To: <20100714172429.GC25861@ted.stsp.name>
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 14 Jul 2010 17:31:05.0209 (UTC) FILETIME=[565CB690:01CB237A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151019>

On 07/14/2010 01:24 PM, Stefan Sperling wrote:
> On Wed, Jul 14, 2010 at 06:01:49PM +0200, Ramkumar Ramachandra wrote:
>> Yeah, I forgot to ask about this: passing 0 as an argument to the
>> replay API doesn't seem to work. Why? How do I dump revision 0 then?
> 
> Indeed. This seems to be a problem in the replay API.

How so?  The replay API is for driving an editor with tree changes.  There
are by definition no tree changes in revision 0.  Therefore, it makes no
sense to accept revision 0 as valid.

Revprops aren't handled by the replay API for any revision.

-- 
C. Michael Pilato <cmpilato@collab.net>
CollabNet   <>   www.collab.net   <>   Distributed Development On Demand
