From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Mon, 28 Nov 2005 16:55:58 -0500
Message-ID: <1133214958.27750.8.camel@dv>
References: <1132719301.12227.5.camel@dv>
	 <7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
	 <20051123235315.oht0zjidc4ccg8gs@webmail.spamcop.net>
	 <7v1x16y36r.fsf@assigned-by-dhcp.cox.net>
	 <20051124021231.nrg8448gk8w4owk8@webmail.spamcop.net>
	 <7vr7917hq4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 22:57:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgqzH-0007X3-7D
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 22:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVK1V4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 16:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVK1V4g
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 16:56:36 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:29058 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751327AbVK1V4f
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 16:56:35 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Egqz9-0002KO-B2
	for git@vger.kernel.org; Mon, 28 Nov 2005 16:56:31 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Egqyc-0001u6-UH; Mon, 28 Nov 2005 16:55:58 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7917hq4.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12907>

On Sun, 2005-11-27 at 16:12 -0800, Junio C Hamano wrote:
> The following patch on top of your patch has seen only very
> light testing, but it seems to do the right thing for my
> repository with utf-8 commit messages and another with euc-jp
> commit messages.  For the latter, I needed to do:
> 
> 	$ git-repo-config i18n.commitencoding euc-jp

Thank you!  I'm glad my code was actually useful.

Now we may want to make git recode commit data to the repository
encoding.  Lots of iconv/glibc/portability fun on the horizon.  At very
least git should protest if both i18n.commitencoding and the locale
encoding are set to different values.

Another issue is support for non-ASCII characters in the filenames.

-- 
Regards,
Pavel Roskin
