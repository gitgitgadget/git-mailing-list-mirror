From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Sat, 20 May 2006 18:36:53 -0600
Message-ID: <m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
References: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
	<m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
	<20060519235825.GA3289@kroah.com>
	<m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
	<20060520213257.GH24672@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 02:37:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhbwz-0001yd-JW
	for gcvg-git@gmane.org; Sun, 21 May 2006 02:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEUAhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 20:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWEUAhi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 20:37:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45254 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932249AbWEUAhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 20:37:38 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4L0asZt004013;
	Sat, 20 May 2006 18:36:54 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4L0arWj004011;
	Sat, 20 May 2006 18:36:53 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060520213257.GH24672@kroah.com> (Greg KH's message of "Sat,
 20 May 2006 14:32:57 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20411>

Greg KH <greg@kroah.com> writes:

> On Fri, May 19, 2006 at 08:42:38PM -0600, Eric W. Biederman wrote:
>
>> If it is one patch per file but with mbox headers, it is relatively
>> simple to teach git-mailinfo to parse things in a slightly more intelligent
>> way.  I played with that but I didn't have any patches that helped with.
>
> Hm, I'll try playing with that.
>
> If you want, just grab my quilt trees from kernel.org and play with
> them, they should all be in mbox format for the individual patches (with
> some exceptions as noted above, just kick me about them to get me to fix
> them...)

So I just grabbed the gregkh-2.6 set of patches and with an unmodified
git-mailinfo I only have problems with the following patches:
	gregkh/gkh-version.patch
	gregkh/sysfs-test.patch
	gregkh/gregkh-usb-minors.patch
	gregkh/gregkh-debugfs_example.patch
	gregkh/gpl_future-test.patch
	usb/usb-gotemp.patch

None of which actually have from headers.

Currently git-mailinfo distinguishes headers and non-headers by the
presence of the first blank line.  So it seems to work just fine on
mbox format patches.

Eric
