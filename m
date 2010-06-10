From: David Ripton <dripton@ripton.net>
Subject: Re: [PATCH next 2/2 v2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 08:41:14 -0700
Message-ID: <20100610154114.GC31213@vidar.dreamhost.com>
References: <201006100040.54375.johan@herland.net> <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil> <4C10B02F.9050107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, johan@herland.net,
	git@vger.kernel.org, srabbelier@gmail.com, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 18:04:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMkEn-0003jp-KT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 18:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab0FJQEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 12:04:08 -0400
Received: from judo.dreamhost.com ([66.33.216.100]:46591 "EHLO
	judo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0FJQEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 12:04:07 -0400
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2010 12:04:07 EDT
Received: from crusty.g.dreamhost.com (crusty.g.dreamhost.com [67.205.8.12])
	by judo.dreamhost.com (Postfix) with ESMTP id 0015B45436E
	for <git@vger.kernel.org>; Thu, 10 Jun 2010 08:41:57 -0700 (PDT)
Received: from vidar.dreamhost.com (vidar.dreamhost.com [208.113.223.211])
	by crusty.g.dreamhost.com (Postfix) with ESMTP id C47EB11DD38;
	Thu, 10 Jun 2010 08:41:14 -0700 (PDT)
Received: by vidar.dreamhost.com (Postfix, from userid 59956)
	id 5EC51984D5; Thu, 10 Jun 2010 08:41:14 -0700 (PDT)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	Brandon Casey <casey@nrlssc.navy.mil>, johan@herland.net,
	git@vger.kernel.org, srabbelier@gmail.com, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
Content-Disposition: inline
In-Reply-To: <4C10B02F.9050107@drmicha.warpmail.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148886>

On 2010.06.10 11:28:15 +0200, Michael J Gruber wrote:
> Doesn't P2.4 have
> 
> 	from hashlib import sha1 as _digest
> 
> etc.? I haven't checked for "as".

Hashlib was new in Python 2.5.  See the note at the top of:
http://docs.python.org/library/hashlib.html

You may have hashlib in your Python 2.4, but if so it's a third-party
module, not part of the standard library.  You shouldn't rely on
everyone having it, when it's so easy to fallback to the sha module.

"import foo as bar" was added in Python 2.0.  "as" became a reserved
word in Python 2.6.

-- 
David Ripton    dripton@ripton.net
