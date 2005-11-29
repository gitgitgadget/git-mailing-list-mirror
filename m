From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] git-clone --shared should imply --local
Date: Tue, 29 Nov 2005 02:17:31 -0500
Message-ID: <1133248651.27750.82.camel@dv>
References: <1133245249.27750.77.camel@dv>
	 <7viruclymo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 08:58:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgzkO-0000pQ-4Q
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 08:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVK2HRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 02:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVK2HRg
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 02:17:36 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:32932 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751340AbVK2HRf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 02:17:35 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Egzk6-0001qK-J3
	for git@vger.kernel.org; Tue, 29 Nov 2005 02:17:34 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Egzk3-0006FG-VS; Tue, 29 Nov 2005 02:17:31 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viruclymo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12927>

On Mon, 2005-11-28 at 23:08 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > The "--shared" option to git-clone is silently ignored if "--local" is
> > not specified.  The manual doesn't mention such dependency.  Make
> > "--shared" imply "--local".
> >
> > Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> Hmph, then probably the manual should say it implies it...

Actually, from the user point of view --local and --shared are
alternatives to each other and to the default behavior.  --local copies
files, --shared makes a reference.

Saying that --shared implies --local could sound like git-clone would
still copy all objects.

My description was from the implementation point of view.

-- 
Regards,
Pavel Roskin
