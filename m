From: "David Jeske" <jeske@willowmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 20:51:41 -0000
Message-ID: <3886.93315112523$1214600400@news.gmane.org>
References: <g43jlg$54g$1@ger.gmane.org>
	<willow-jeske-01l7H4tHFEDjCgPV-01l7[1OFFEDjCYJV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:59:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCL2l-0005ta-29
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 22:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYF0U6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbYF0U6n
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:58:43 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33090 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751328AbYF0U6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:58:42 -0400
Received: (qmail 28588 invoked by uid 90); 27 Jun 2008 20:58:37 -0000
X-Mailer: Willow v0.02
Received: from 72.14.229.81 at Fri, 27 Jun 2008 20:51:41 -0000
In-Reply-To: <g43jlg$54g$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86633>

-- Jakub Narebski wrote:
> git rebase --interactive?
> Any patch management interface (StGIT, Guilt)?

Yes, as I said, that set of operations can be performed with git today.

What git can't do, is let me "supercede" the old DAG-subset, so people I shared
them with can get my new changes without hurting their world. Currently git
seems to rely on the idea that "if you accept changes into your tree that will
be later rebased, it's up to you to figure it out". I don't see why that is the
case.
