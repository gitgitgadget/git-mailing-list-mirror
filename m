From: Steven Grimm <koreth@midwinter.com>
Subject: Re: rename directory weirdness
Date: Thu, 26 Jul 2007 16:54:31 +0800
Message-ID: <46A86147.4010403@midwinter.com>
References: <46A8519D.5050801@tplogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bert Douglas <bertd@tplogic.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDz7R-0000mj-BT
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 10:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbXGZIyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 04:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbXGZIyh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 04:54:37 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:57267
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1753606AbXGZIyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 04:54:36 -0400
Received: (qmail 8585 invoked from network); 26 Jul 2007 08:54:36 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=h7p/Vvf4EComipvEZU/YlGThe9FIN8R8VzzueNEYvqXuPL1texykn691H7hDHtK8  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 26 Jul 2007 08:54:36 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <46A8519D.5050801@tplogic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53809>

Bert Douglas wrote:
> $ mv dir1 dir2
> $ git add dir2
> $ git commit -a
>
> It popped up my editor with long list of files that it recognized as 
> 'renamed'.
> But one file it listed as 'copied' and further down as 'deleted'.
>
> Why this one file out of thousands not recognized as 'renamed' ?
> Is this a sign of a problem ?

Are the contents of the file in question identical to those of some 
other file in your directory tree? I've seen that happen too. There were 
some proposed improvements to address this last time it came up on the 
list, but I'm not sure if any of them actually made it into the code base.

-Steve
