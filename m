From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 1 Oct 2008 01:40:09 -0700
Message-ID: <1D35F972-DA47-4445-A667-B03F841CABC6@develooper.com>
References: <200809251230.11342.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 10:41:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkxGu-0007O3-Hz
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 10:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYJAIkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 04:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYJAIkN
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 04:40:13 -0400
Received: from x8.develooper.com ([216.52.237.208]:59503 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbYJAIkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 04:40:12 -0400
Received: (qmail 13984 invoked from network); 1 Oct 2008 08:40:10 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 1 Oct 2008 08:40:10 -0000
In-Reply-To: <200809251230.11342.jnareb@gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97212>


On Sep 25, 2008, at 3:30, Jakub Narebski wrote:

> * Optional information about load stats
>
>  Add an option to display information about how much time it took to  
> generate page, how many git commands were called, and possibly other  
> metric; if page was cached, write when it was generated, and how  
> much time till timeout.  This probably would require additional perl  
> modules, and it should be conditional on those modules.

Before spending too much time on this, be sure to have a look a  
Devel::NYTProf.

http://search.cpan.org/~timb/Devel-NYTProf-2.03/lib/Devel/NYTProf.pm

http://blog.timbunce.org/2008/07/15/nytprof-v2-a-major-advance-in-perl-profilers/

-- 
http://develooper.com/ - http://askask.com/
