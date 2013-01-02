From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk tag delete/rename support
Date: Wed, 2 Jan 2013 18:11:53 +1100
Message-ID: <20130102071153.GF20724@iris.ozlabs.ibm.com>
References: <CAOrOd9woDs16as+t-EReQ8NtXfYm9mpd0XaFFs-XL=pg+JK1Lw@mail.gmail.com>
 <1353870345-3054-1-git-send-email-leon.kukovec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leon KUKOVEC <leon.kukovec@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqIUu-0002Ro-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 08:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916Ab3ABHMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 02:12:01 -0500
Received: from ozlabs.org ([203.10.76.45]:40301 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3ABHMA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 02:12:00 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id CC9762C008D; Wed,  2 Jan 2013 18:11:59 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1353870345-3054-1-git-send-email-leon.kukovec@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212494>

On Sun, Nov 25, 2012 at 08:05:45PM +0100, Leon KUKOVEC wrote:

> Right clicking on a tag pops up a menu, which allows
> tag to be renamed or deleted.

Nice idea, but I am concerned that renaming a tag that refers to a tag
object will turn it into a lightweight tag, which would be surprising
for users.  I think that needs to be fixed before I apply the patch.
Also, when renaming a tag it would be good to check for the cases
where the new name is the same as the old (in which case nothing needs
to be done) and where the new name already exists.

Thanks,
Paul.
