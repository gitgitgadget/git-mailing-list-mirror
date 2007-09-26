From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: grafts not appearing in manual pages
Date: Wed, 26 Sep 2007 17:01:02 -0400
Message-ID: <20070926210102.GF26099@fieldses.org>
References: <20070926202441.GA31848@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:01:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iae0r-0006AW-Cq
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 23:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761967AbXIZVBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 17:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762082AbXIZVBE
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 17:01:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43226 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762144AbXIZVBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 17:01:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Iae0E-0000Ra-4y; Wed, 26 Sep 2007 17:01:02 -0400
Content-Disposition: inline
In-Reply-To: <20070926202441.GA31848@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59247>

On Wed, Sep 26, 2007 at 10:24:41PM +0200, Mike Hommey wrote:
> Hi,
> 
> The only occurrence of grafts in the manual pages is in the
> git-filter-branch one. I somehow feel this is wrong not to see it
> described more "formally" in the manual pages.
> 
> I wouldn't mind writing a small something, except I have no idea what
> would be the most appropriate place to talk about it... Does anyone have
> such an idea ?

It could go in Documentation/user-manual.txt, but I don't know where.
Maybe at the end of the git-concepts chapter?  Patches welcomed.  I
guess what's needed (and currently missing) is an overview explaining
what they're actually for, plus some basic setup instructions.

And/or maybe a section 5 manual page documenting the format of the
"grafts" file?  Maybe that's overkill.  There's a paragraph in
Documentation/repository-layout.txt.  Maybe we need to make it easier to
find that file.

--b.
