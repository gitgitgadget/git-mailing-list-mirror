From: Tim Chase <git@tim.thechases.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 08:06:05 -0500
Message-ID: <20130627080605.067af4ae@bigbox.christie.dr>
References: <20130627124656.GA2620@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 16:16:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCzN-0006eN-1X
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 16:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3F0OPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 10:15:52 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:44566 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663Ab3F0OPw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 10:15:52 -0400
X-Greylist: delayed 4292 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2013 10:15:52 EDT
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:45882 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1UsBs3-000Bpx-JE; Thu, 27 Jun 2013 08:04:19 -0500
In-Reply-To: <20130627124656.GA2620@zuhnb712>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229107>

On 2013-06-27 20:46, Woody Wu wrote:
> I have a colleague who has to left our office for three month, but
> still need to work on the project which is hosted on our in-office
> git repository. Problem is that our company has firewall, it's not
> possible or not allowed to access the company LAN outside the
> building.  So I want to ask you expert, can you suggest a best
> practice of git workflow that suitable to my situation?

It would help to know a little more about the information flow and
the starting conditions.

- Was a clone of code made before leaving your office or does your
  colleague need to obtain the initial copy too?

- How securely do you need to transfer matters?  (email?  shared
  external service like Dropbox/Box.com/etc)

- How frequently do updates need to be made?

- In which direction do commits flow?  Just from your colleague back
  to the office, or are there other updates happening in the office
  that your colleague needs to pull down to keep in sync?

Without such answers, it's a little hard to suggest more than
transmitting either patch files or bundles using any of the following:
email, a shared cloud drive, a shared host out accessible on the net,
or sneakernet media (flash-drive or CD/DVD, perhaps via the postal
system), or possibly other means.

You may want to read more at

  git help format-patch
  git help am
  git help bundle

-tkc
