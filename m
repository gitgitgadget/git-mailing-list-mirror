From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Mon, 25 Jan 2010 12:48:45 -0800
Message-ID: <4B5E03AD.1020404@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net> <m3ljfydgmt.fsf@localhost.localdomain> <20100124221444.GB9553@machine.or.cz> <201001250247.13101.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZVsQ-0006ox-4u
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0AYUte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 15:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563Ab0AYUte
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:49:34 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42132 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab0AYUtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 15:49:33 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0PKmjv6028104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 25 Jan 2010 12:48:45 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <201001250247.13101.jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 25 Jan 2010 12:48:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137992>

> So there is a bit of rule of preservation of difficulty at work.  Either
> we have large patch adding explicit filehandle to all print statements
> 'print <sth> -> print $out <sth>' but simple code, or have smaller patch
> but complicated *STDOUT manipulation, or have small patch but rely on 
> non-core CPAN modules present.

I think depending in non-core CPAN modules is a really bad idea, and
will cause some concern and consternation with mainline distributions,
besides making it more complicated for users to get this up and running
quickly and easily.  While I agree there are other ways of handling this
I think just adding the filehandle to the print statements provides the
easiest cross section of usability and functionality for everything
involved.

- John 'Warthog9' Hawley
