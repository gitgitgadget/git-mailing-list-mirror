From: David Brown <git@davidb.org>
Subject: Re: Help breaking up a large merge.
Date: Thu, 18 Sep 2008 10:47:05 -0700
Message-ID: <20080918174705.GA8055@linode.davidb.org>
References: <20080918152154.GA27019@linode.davidb.org> <32541b130809181040p4785f877s7502c578e46745d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNcH-0005CL-Ha
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbYIRRrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbYIRRrH
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:47:07 -0400
Received: from linode.davidb.org ([72.14.176.16]:50058 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122AbYIRRrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:47:06 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KgNar-0002A7-JF; Thu, 18 Sep 2008 10:47:05 -0700
Content-Disposition: inline
In-Reply-To: <32541b130809181040p4785f877s7502c578e46745d8@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96228>

On Thu, Sep 18, 2008 at 01:40:55PM -0400, Avery Pennarun wrote:

>1) Generate a giant patch file using 'git diff X..A'.  Call the patch P.
>
>2) Using an editor, divide up the patch by files/subdirs based on how
>you want to subdivide the work.  Or alternatively, do that with 'git
>diff' itself, but beware of accidentally forgetting to ask for some
>files if you do it that way.  Call these n individual patches P1..Pn.

The is fairly close to the approach I've been taking, but somehow I
didn't think of using the output of diff itself and hacking that up.
I like this because it makes it easier to not forget some files.

It is likely there will be makefiles to cleanup and such, but
otherwise I like this idea.

Thanks,
David
