From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 11:29:43 -0000
Message-ID: <28156.2147582465$1214307807@news.gmane.org>
References: <200806241322.14224.jnareb@gmail.com>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5p7eVFEDjCZRD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB6vf-0007Y8-L2
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 13:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759705AbYFXLmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 07:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759655AbYFXLmV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:42:21 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60122 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759620AbYFXLmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:42:20 -0400
Received: (qmail 12644 invoked by uid 90); 24 Jun 2008 11:42:18 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 11:29:43 -0000
In-Reply-To: <200806241322.14224.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86036>

-- Jakub Narebski wrote:
> If they are using '-f', i.e. force, they should know and be sure what
> they are doing; it is not much different from 'rm -f *'.

Sure, no problem. I don't want the ability to "rm -f *". I'm raising my hand
and saying "I don't want the power to do these things, so just turn off all the
git commands that could be destructive and give me an alternate way to do the
workflows I need to do". Just like a normal user on a unix machine doesn't run
around with the power to rm -f /etc all the time, even though they may be able
to su to root.

Let me guess, you're always running euid==0. :)
