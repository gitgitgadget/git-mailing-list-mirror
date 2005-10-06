From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: use UTF-8 encoding
Date: Thu, 06 Oct 2005 01:34:55 -0400
Message-ID: <1128576895.31571.8.camel@dv>
References: <1128564768.32103.18.camel@dv>
	 <7vvf0b9t0d.fsf@assigned-by-dhcp.cox.net>  <4344AF8A.1040504@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 07:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENOPX-0002En-LI
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 07:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVJFFfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 01:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVJFFfA
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 01:35:00 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:3818 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750730AbVJFFfA
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 01:35:00 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ENOPC-0000gS-Qa
	for git@vger.kernel.org; Thu, 06 Oct 2005 01:34:58 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1ENOP9-0008Ea-AU; Thu, 06 Oct 2005 01:34:55 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4344AF8A.1040504@zytor.com>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9763>

On Wed, 2005-10-05 at 22:00 -0700, H. Peter Anvin wrote:
> Junio C Hamano wrote:
> > Pavel Roskin <proski@gnu.org> writes:
> > 
> >>gitk should try to use UTF-8 encoding for system operations, such as
> >>reading and writing files and git output.
> > 
> > I agree about commit messages, but I am not so sure about the
> > file contents (aka user data).  Is it possible to control them
> > separately?

Yes.  "encoding convertfrom" should do the trick.  In some projects, 
there may be files written in different encodings, such as gettext *.po
files.  A patch updating several *.po files would have different parts
in different encodings.

I think gitk could have a submenu in the popup menu with the encodings
to chose from.

> git needs to be able to treat user data as arbitrary binary blobs. 
> However, if interpreting as text, UTF-8 is the right default, at least.

I agree.

-- 
Regards,
Pavel Roskin
