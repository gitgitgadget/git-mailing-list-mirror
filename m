From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Howto install git-cheetah manually
Date: Wed, 17 Mar 2010 17:18:10 +0100
Message-ID: <20100317161810.GB12994@book.hvoigt.net>
References: <90D77DC1A40945F0B57A3932304061FC@c1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tima fourie <timafourie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:21:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrvzL-0003Q7-LO
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab0CQQSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 12:18:14 -0400
Received: from darksea.de ([83.133.111.250]:49512 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754320Ab0CQQSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 12:18:11 -0400
Received: (qmail 5145 invoked from network); 17 Mar 2010 17:18:09 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Mar 2010 17:18:09 +0100
Content-Disposition: inline
In-Reply-To: <90D77DC1A40945F0B57A3932304061FC@c1>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142408>

On Mon, Mar 15, 2010 at 11:06:02AM +0200, tima fourie wrote:
> How can I manually install Git-cheetah that comes with the windows portable download?
> 
> Or perhaps there is a script or something available?
> 
> (Git version 1.7.0.2)

git clone git://repo.or.cz/git-cheetah.git
make install

BTW, this should also work for Gnome on Linux and Mac OS X up to 10.5.

Is there anything missing? If you just want to register the built dll
use the correct mailing list (http://groups.google.com/group/msysgit)
and

  regsvr32 -s <dll_name>

to register git_shell_ext.dll.

cheers Heiko
