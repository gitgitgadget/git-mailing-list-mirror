From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Purpose of "struct object_entry *oe = oe;"?
Date: Tue, 29 Jun 2010 13:28:19 +0100
Message-ID: <8039w681lo.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 14:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTZva-0004ni-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 14:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab0F2M2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 08:28:31 -0400
Received: from rufus.isode.com ([62.3.217.251]:53711 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab0F2M2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 08:28:31 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <TCnm7AB1H3X5@rufus.isode.com> for <git@vger.kernel.org>;
          Tue, 29 Jun 2010 13:28:28 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 29 Jun 2010 13:28:19 +0100
X-Hashcash: 1:20:100629:git@vger.kernel.org::gLsjD4yTHrQj1tis:0000000000000000000000000000000000000000004vIS
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149901>

Out of curiousity, where did this convention/idiom come from, and what's
it for?

I presume it's to remove a warning ("oe might be used uninitialised") on
a compiler (or something) that's clever enough to attempt such analysis
but too stupid to notice that the supposed initialisation is using
something uninitialised (or perhaps the compiler's deliberately
recognising the convention?).  Is that right, or does it actually do
something more?

I'm mostly surprised that it surprises me.  Is it used commonly in other
projects?  (It appears not to be mentioned in CodingGuidelines; should
it be?)

(First instance in git that I can see is
67affd5173da059ca60aab7896985331acacd9b4, 2006.)
