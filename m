From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Re: Honoring a checked out gitattributes file
Date: Fri, 30 Jan 2009 14:00:12 +0100
Message-ID: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
References: <498094F9.5070201@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 14:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSt0G-0001e5-K4
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbZA3NAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbZA3NAV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:00:21 -0500
Received: from hoat.troll.no ([62.70.27.150]:46800 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbZA3NAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 08:00:20 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 034F92111B
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:00:15 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id EC2C0210CF
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:00:14 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0UD0E0o025784
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:00:14 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 30 Jan 2009 14:00:14 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id E8F8436182DE; Fri, 30 Jan 2009 14:00:13 +0100 (CET)
In-Reply-To: <498094F9.5070201@trolltech.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.1.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107808>

I have now created a test case which demonstrates the problem.

I want to create a patch for it too, but I am unfortunately not so
familiar with the Git source code.

To put it short, I want to make sure that when checking out a tree,
.gitattributes will be checked out before all other files, so that
files that are affected by it will be guaranteed to get the correct
attributes. Maybe someone from this list could point me in the right
direction in the source code for something like this?

--
Kristian Amlie
