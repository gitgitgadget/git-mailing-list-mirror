From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Best practice question
Date: Thu, 19 Jun 2008 16:54:13 +0200
Message-ID: <20080619145413.GA18563@diana.vm.bytemark.co.uk>
References: <485A6E03.6090509@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
X-From: git-owner@vger.kernel.org Thu Jun 19 16:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9LXw-0007vx-Ie
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYFSOyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 10:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYFSOyZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:54:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4265 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbYFSOyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 10:54:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K9LWf-0004wk-00; Thu, 19 Jun 2008 15:54:13 +0100
Content-Disposition: inline
In-Reply-To: <485A6E03.6090509@et.gatech.edu>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85481>

On 2008-06-19 10:32:35 -0400, D. Stuart Freeman wrote:

> My project has an "about" page that lists the version. I understand
> why git doesn't do keyword expansion, but I'm wondering if there's a
> recommended best practice for keeping that up to date.

Usually when people ask this question on this list, the recommendation
is to have the build system generate a suitable version string. Look
at how git's own built-in version string is generated, for example.
(The GIT-VERSION-GEN script.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
