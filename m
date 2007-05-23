From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb.perl - Optionally send archives as .zip files
Date: Wed, 23 May 2007 15:09:16 -0700
Message-ID: <7v3b1n19bn.fsf@assigned-by-dhcp.cox.net>
References: <11796760064103-git-send-email-mdl123@verizon.net>
	<20070522122828.GJ4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 24 00:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqz1H-0000PV-2o
	for gcvg-git@gmane.org; Thu, 24 May 2007 00:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbXEWWJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755986AbXEWWJT
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 18:09:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63204 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbXEWWJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 18:09:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523220918.PBHZ13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 18:09:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2m9G1X00e1kojtg0000000; Wed, 23 May 2007 18:09:17 -0400
In-Reply-To: <20070522122828.GJ4489@pasky.or.cz> (Petr Baudis's message of
	"Tue, 22 May 2007 14:28:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48184>

Petr Baudis <pasky@suse.cz> writes:

>  Hi,
>
> On Sun, May 20, 2007 at 05:46:46PM CEST, Mark Levedahl wrote:
>> git-archive already knows how to generate an archive as a tar or a zip
>> file, but gitweb did not. zip archvies are much more usable in a Windows
>> environment due to native support and this patch allows a site admin the
>> option to deliver zip rather than tar files. The selection is done by
>> inserting
>> 
>> $feature{'snapshot'}{'default'} = ['x-zip', 'zip', ''];
>> 
>> in gitweb_config.perl.
>> 
>> Tar files remain the default option.
>> 
>> Signed-off-by: Mark Levedahl <mdl123@verizon.net>
>
> Acked-by: Petr Baudis <pasky@suse.cz>

Ok, will apply to 'master'.
