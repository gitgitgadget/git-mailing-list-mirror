From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] gitk: Synchronize highlighting in file view when
 scrolling diff
Date: Sun, 23 Sep 2012 16:58:25 +1000
Message-ID: <20120923065825.GA15889@bloggs.ozlabs.ibm.com>
References: <20120918234611.GA5544@bloggs.ozlabs.ibm.com>
 <1348078647-22516-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 23 09:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFgBZ-0008UX-V6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 09:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab2IWHAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 03:00:15 -0400
Received: from ozlabs.org ([203.10.76.45]:54905 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2IWHAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 03:00:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 92A8B2C0081; Sun, 23 Sep 2012 17:00:11 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1348078647-22516-1-git-send-email-stefan@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206220>

On Wed, Sep 19, 2012 at 08:17:27PM +0200, Stefan Haller wrote:
> Here's one way how to address your concern. When pressing the search button
> it will highlight the file that contains the current search hit; if you then
> scroll from there though, the normal mechanism kicks in again and might
> highlight the previous file. The same happens now if you select the last file
> in the list, but it's diff is smaller than a screenful. In the previous
> patch versions it would select a different file than you clicked on, which
> is probably also confusing.
> 
> Is this what you had in mind?

Yes, it is, and I applied your patch.  I wonder though if it might
work better to highlight all the files that are visible?

Paul.
