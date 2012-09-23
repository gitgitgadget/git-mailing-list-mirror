From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Work around empty back and forward images when
 buttons are disabled
Date: Sun, 23 Sep 2012 17:00:15 +1000
Message-ID: <20120923070015.GC15889@bloggs.ozlabs.ibm.com>
References: <1348300008-90717-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Haller <stefan@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 23 09:01:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFgBa-0008UX-TM
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 09:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab2IWHAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 03:00:16 -0400
Received: from ozlabs.org ([203.10.76.45]:45668 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab2IWHAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 03:00:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9CF992C0094; Sun, 23 Sep 2012 17:00:11 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1348300008-90717-1-git-send-email-stefan@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206218>

On Sat, Sep 22, 2012 at 09:46:48AM +0200, Stefan Haller wrote:
> On Mac, the back and forward buttons show an empty rectange instead of
> a grayed-out arrow when they are disabled. The reason is a Tk bug on Mac
> that causes disabled images not to draw correctly (not to draw at all,
> that is); see
> <https://groups.google.com/forum/?fromgroups=#!topic/comp.lang.tcl/V-nW1JBq0eU>.
> 
> To work around this, we explicitly provide gray images for the disabled
> state; I think this looks better than the default stipple effect that you
> get on Windows as well, but that may be a matter of taste.
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>

Thanks, applied.

Paul.
