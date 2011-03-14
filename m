From: Joseph Huttner <jhuttner@appnexus.com>
Subject: Git workflow for beta/production
Date: Mon, 14 Mar 2011 15:27:22 -0700
Message-ID: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 23:37:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzGOM-00064u-T1
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 23:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab1CNWh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 18:37:28 -0400
Received: from exhub016-2.exch016.msoutlookonline.net ([207.5.72.164]:33702
	"EHLO EXHUB016-2.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593Ab1CNWh2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 18:37:28 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2011 18:37:28 EDT
Received: from EXVMBX016-5.exch016.msoutlookonline.net ([207.5.72.175]) by
 EXHUB016-2.exch016.msoutlookonline.net ([207.5.72.164]) with mapi; Mon, 14
 Mar 2011 15:27:23 -0700
Thread-Topic: Git workflow for beta/production
Thread-Index: Acvilv0C1Aty+o1MRRqMeI5mISHJpA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169032>

I am in search of a new Git workflow.  Previously, my team was essentially using using gitflow by Vincent Driessen (nvie).  It worked very well, but the needs of project have changed, so here are the new requirements:

1.  A "Beta" environment that contains stable code for all features being considered for "Production."
2.  A "Production" environment.  Rock-solid, well-tested code only.  

The catch is that after a feature has been stomped on in Beta, it **may** go to Production, but only if Product Managers still think it is an important feature.  In other words, there is no guarantee that a feature in Beta will ever make it to Production.  It may be axed completely, in which case it would never get to Production and would be taken out of Beta.  Also, there is no guarantee that features that do make it to Production will go in in the order that they went in to Beta.  

A few notes that may matter:

a) Six developers on team and growing.  Will be 9 by the summer.
b) Codebase is 110K in-house lines.
c) Typically, a feature is worked on by 1-3 developers at a time.  Total development work on a feature can be anywhere from two hours to two months.  The median is about two weeks.
d) Currently, per week, about 15 bug reports come in for today's equivalent of the Beta branch.

Ideally, using the new workflow, releases to Beta would be a few times per week.  Releases to Production would be once per month.  This is the same as our current release cycle.

I have been on the whiteboard trying to think about a Git workflow that suits my needs, but my head is spinning, which is a signal to me that I need help from more seasoned vets.  Any and all help is appreciated.

-Joseph