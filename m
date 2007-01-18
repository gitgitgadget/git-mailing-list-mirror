From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 01:10:38 -0800
Message-ID: <7vps9cn1ip.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<87ps9d7j6t.fsf@morpheus.local>
	<7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	<625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	<7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	<7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	<20070118080613.GE23124@spearce.org>
	<81b0412b0701180018i208e4158k2dd3e9ecdfa79b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 10:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7TIY-0004Bn-B9
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 10:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbXARJKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 04:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXARJKm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 04:10:42 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44255 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbXARJKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 04:10:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118091039.PZGW3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jan 2007 04:10:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CZ9l1W0041kojtg0000000; Thu, 18 Jan 2007 04:09:45 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701180018i208e4158k2dd3e9ecdfa79b13@mail.gmail.com>
	(Alex Riesen's message of "Thu, 18 Jan 2007 09:18:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37070>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 1/18/07, Shawn O. Pearce <spearce@spearce.org> wrote:

>> Thus the file extension has no impact on how the mail client should
>> treat it.
>
> He will attach it. It's typical for outlook users.

If that is the case, I highly suspect that it is one more reason
not to mark the file with .txt; Outlook may say "Hey, it's TEXT,
so let's linewrap it, quote-balance it and add all sorts of nice
frills to make it easier to read for human consumption".  

Assuming that it does not understand what a .patch is, we would
have a better chance to force it not to look at nor touch the
contents, and not getting our patches corrupted.
