From: <4jxDQ6FQee2H@dyweni.com>
Subject: Assertion Failed when importing svn into Git
Date: Fri, 9 Jan 2009 13:32:34 -0600
Message-ID: <20090109133234.345dacb9@family.dyweni.com>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 20:43:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLNGv-0006iT-TG
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbZAITmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZAITme
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:42:34 -0500
Received: from pl1.haspere.com ([208.111.35.220]:35457 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZAITme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:42:34 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jan 2009 14:42:33 EST
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id 1DE13C800E;
	Fri,  9 Jan 2009 13:32:36 -0600 (CST)
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105034>

Hi,


I'm trying to import my SVN repository into GIT and its throwing an
Assertion Failed error message in text_delta.c  Can someone help me?

The assertion failed error occurs when running 'svn diff -r 288:289'
which contains only one change - a change made to a binary file. That
binary file is the Eclipse dataModel file, both revs (288, 289) have
the file marked as application/octet-stream using the svn:mime-type
property


subversion - 1.5.4
git        - 1.6.0.6

The SVN repository was started using 1.4.6, if that matters

Here's the exact error message:

-------
$ svn diff -r 288:289
svn: subversion/libsvn_delta/text_delta.c:609: apply_window: Assertion
`window->sview_len == 0 || (window->sview_offset >= ab->sbuf_offset &&
(window->sview_offset + window->sview_len >= ab->sbuf_offset +
ab->sbuf_len))' failed.
Aborted
-------


Thanks!
