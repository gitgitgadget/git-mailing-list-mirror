From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] tg.sh: Check for read permissions of help files
Date: Sat, 9 Aug 2008 10:24:36 +0200
Message-ID: <20080809082436.GU10151@machine.or.cz>
References: <1218009771-30358-1-git-send-email-bert.wesarg@googlemail.com> <36ca99e90808090035r6331a118k5a26486de1acf002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 10:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRjld-0000pn-RJ
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 10:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbYHIIYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 04:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYHIIYj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 04:24:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51318 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbYHIIYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 04:24:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1F0622C4C036; Sat,  9 Aug 2008 10:24:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <36ca99e90808090035r6331a118k5a26486de1acf002@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91753>

On Sat, Aug 09, 2008 at 09:35:19AM +0200, Bert Wesarg wrote:
> Petr,
> 
> On Wed, Aug 6, 2008 at 10:02, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > -       elif [ -f "@sharedir@/tg-$1.txt" ] ; then
> > +       elif [ -f "@sharedir@/tg-$1.txt" -a -r "@sharedir@/tg-$1.txt" ] ; then
> I saw your simplified commit for this, but you should know, that '-r'
> tests only for read permissions, not for a regular file, so this test
> succeed also for a pipe/socket for which do you have read permissions.

Is that a problem? :-)

				Petr "Pasky" Baudis
