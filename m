From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable output
Date: Mon, 21 May 2007 14:18:12 -0700
Message-ID: <7vbqgddgff.fsf@assigned-by-dhcp.cox.net>
References: <20070520225953.GK4085@planck.djpig.de>
	<11797696193384-git-send-email-frank@lichtenheld.de>
	<7vejladpfr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705211945470.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 21 23:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqFGt-0003nk-TE
	for gcvg-git@gmane.org; Mon, 21 May 2007 23:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbXEUVSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 17:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756132AbXEUVSV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 17:18:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37924 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975AbXEUVSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 17:18:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521211820.UPFJ13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 17:18:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1xJH1X01W1kojtg0000000; Mon, 21 May 2007 17:18:19 -0400
In-Reply-To: <Pine.LNX.4.64.0705211945470.6410@racer.site> (Johannes
	Schindelin's message of "Mon, 21 May 2007 19:46:54 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48053>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Git.pm could simply do:
>> 
>> 	my $eval = `git config --perl --get-regexp 'gitcvs\..*'`;
>> 	my $cfg = eval "$eval";
>> 
>> if you code your "perl" notation to produce:
>> 
>> 	+{
>> 		'gitcvs.ext.enabled' => 'false',
>>                 'gitcvs.logfile' => '/var/log/gitcvs.log',
>> 	}
>> 
>> in order to read things in.
>> 
>> Hmm?
>
> IOW, something like 
> http://article.gmane.org/gmane.comp.version-control.git/36922

Indeed (perhaps except fixing minor details like not hijacking
the variable name).  Care to resubmit with docs and tests?
