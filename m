From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 12:24:27 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806251219480.5755@sys-0.hiltweb.site>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com> <alpine.LFD.1.10.0806251154180.5755@sys-0.hiltweb.site> <17C0F998-66C0-4DFC-90EB-B85FF6E07844@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXo4-0007iU-3M
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbYFYQYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYFYQYU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:24:20 -0400
Received: from mail.gmx.com ([74.208.5.67]:39535 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751250AbYFYQYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:24:19 -0400
Received: (qmail invoked by alias); 25 Jun 2008 16:24:18 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us003) with SMTP; 25 Jun 2008 12:24:18 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18o4TdxOegoZYc3SYxV2vn2ifypQZtDwy10/DCqpy
	goJdXFWVFOmeVW
In-Reply-To: <17C0F998-66C0-4DFC-90EB-B85FF6E07844@gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86301>

On Wed, 25 Jun 2008 at 12:01pm -0400, Rhodes, Kate wrote:

> yeah, but i was hoping for plumbing, not porcelain, that showed just what i
> wanted so that i didn't have to parse status' output.

I wasn't able to make "git ls-files" do what you want.  However, "git
diff --name-only --cached" did.  It's still porcelain, but it does what
you want :)


-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
