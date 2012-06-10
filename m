From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] t0020: make sure the test file is lf to start
 with
Date: Sun, 10 Jun 2012 11:47:46 +0100 (IST)
Message-ID: <alpine.DEB.1.00.1206101145550.16012@bonsai2>
References: <1339324352-7376-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 12:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdfgX-000582-8D
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 12:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab2FJKrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 06:47:49 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:39663 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751387Ab2FJKrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 06:47:49 -0400
Received: (qmail invoked by alias); 10 Jun 2012 10:47:47 -0000
Received: from 88-104-209-118.dynamic.dsl.as9105.com (EHLO bonsai2.local) [88.104.209.118]
  by mail.gmx.net (mp034) with SMTP; 10 Jun 2012 12:47:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19X4tIDjk1X2vJB+8gUvCt3j5WcKx7w3i2+zZVAi9
	N/fqBI0kuYzWOC
X-X-Sender: gene099@bonsai2
In-Reply-To: <1339324352-7376-1-git-send-email-vfr@lyx.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199585>

Hi Vincent,

On Sun, 10 Jun 2012, vfr@lyx.org wrote:

> On Windows, the perl interpreter used by q_to_nul also converts the
> eol-style to crlf.

First: thanks for working on this, and thanks also for Cc:ing the msysgit
list.

> Because the eol-style is now wrong from the beginning, the later tests
> '.gitattributes says two is binary' and 'checkout with existing
> .gitattributes' fail.

I wonder why it does not fail here:

	https://qa.nest-initiative.org/job/msysgit-test/24/console

IOW I think there is a difference between the msysGit setup and your
setup...

Ciao,
Johannes
