From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: JGit vs. Git
Date: Tue, 6 Jan 2009 14:55:39 -0500
Message-ID: <p06240805c589657fd75a@[192.168.1.114]>
References: <a55cfe9d0901052249v1461c70cp1d89e184cfc05eb9@mail.gmail.com>
 <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com> <200901061212.07240.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Vagmi Mudumbai" <vagmi.mudumbai@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIHl-0000wI-Kt
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbZAFUK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbZAFUK5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:10:57 -0500
Received: from deanbrook.org ([72.52.70.192]:46571 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbZAFUK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:10:56 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2009 15:10:56 EST
Received: from ::ffff:71.161.144.33 ([71.161.144.33]) by deanbrook.org for <git@vger.kernel.org>; Tue, 6 Jan 2009 11:55:51 -0800
In-Reply-To: <200901061212.07240.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104716>

At 12:12 PM +0100 1/6/09, Robin Rosenberg wrote:
>tisdag 06 januari 2009 07:50:11 skrev Vagmi Mudumbai:
>  > I am working on Windows with msysGit behind a HTTP Proxy. (Life cant
>>  get worse, I guess.) . I planned on using grit via JRuby but grit uses
>>  fork which is not available on funny platforms like windows. And JRuby
>>  guys do not have any plan on supporting fork even on platforms on
>>  which for is supported. If JGit is a pure Java based implementation of
>fork isn't really supported on Windows. Cygwin goes to great lengths to
>emulate it. Trying to do that within the context of an arbitrary JVM seems
>like a daunting task. Consider submitting patches to make grit not use fork...
>just kidding.., please help us improve JGit instead :)

Or think about extending the Ruby gem grit to also use JGit.  Which 
would certainly improve grit and  probably help improve JGit also.

I've thought about this a bit -- but it hasn't gotten to the top of 
my list yet ...

There are some examples of Ruby Gems which use Java libraries when 
run in JRuby and native C libraries when used from MRI.

   hpricot:   http://github.com/why/hpricot/tree
   redcloth:  http://github.com/jgarber/redcloth/tree/master
