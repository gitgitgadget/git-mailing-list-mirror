From: Junio C Hamano <junkio@cox.net>
Subject: Re: Collecting cvsps patches
Date: Fri, 16 Jun 2006 22:50:38 -0700
Message-ID: <7v4pykbaa9.fsf@assigned-by-dhcp.cox.net>
References: <20060611122746.GB7766@nowhere.earth>
	<46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com>
	<20060611224205.GF1297@nowhere.earth> <e6jj39$6ua$1@sea.gmane.org>
	<20060616212334.GN7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 07:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrThj-0008NA-SX
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 07:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWFQFuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 01:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWFQFuk
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 01:50:40 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41898 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751151AbWFQFuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 01:50:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617055039.QCKZ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 01:50:39 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060616212334.GN7766@nowhere.earth> (Yann Dirson's message of
	"Fri, 16 Jun 2006 23:23:34 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22003>

Yann Dirson <ydirson@altern.org> writes:

> On Mon, Jun 12, 2006 at 11:27:37AM +0000, Anand Kumria wrote:
>> On Mon, 12 Jun 2006 00:42:05 +0200, Yann Dirson wrote:
>> 
>> > http://ydirson.free.fr/soft/git/cvsps.git
>> 
>> I think you need to chmod +x hooks/post-update
>> 
>> and then run 'git-update-server-info'.
>
> Unfortunately, I only have FTP access to push to this site, so I have
> to run git-update-server-info myself, and occasionally forget.  I'll
> have to bring up-to-date my old cg-ftppush script some day :)

When I only had "serving HTTP, published via FTP" ISP accounts,
I essentially ended up having a bare repository on my local
machine, update it with real git-push (with the post-update hook
there), and copied that to the ISP via lftp batch.
