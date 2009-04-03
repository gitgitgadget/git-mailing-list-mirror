From: Josef Wolf <jw@raven.inka.de>
Subject: How to merge in different order?
Date: Fri, 3 Apr 2009 18:12:08 +0200
Message-ID: <20090403161208.GC28619@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 18:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpmAP-0001Tw-Hh
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 18:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935087AbZDCQUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935720AbZDCQUj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 12:20:39 -0400
Received: from quechua.inka.de ([193.197.184.2]:60065 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935787AbZDCQUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 12:20:38 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Lpm8A-00078F-Bo; Fri, 03 Apr 2009 18:20:34 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 7A43F2CBDB; Fri,  3 Apr 2009 18:12:08 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115542>

Hello,

Given a branch that looks like

  A1  A2  A3  A4  A5

I would like to merge into another branch in the order

  A1  A3  A4  A2  A5

When I merge A3, then A2 is merged also.  git-merge don't seem
to have an option to omit slurping older commits?
