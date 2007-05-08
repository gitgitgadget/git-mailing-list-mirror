From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-clean fails to remove a file whose name contains \\, ",  or  \n, TAB, etc.
Date: Tue, 08 May 2007 16:18:40 -0700
Message-ID: <86wszi9a5r.fsf@blue.stonehenge.com>
References: <87ps5bhx8t.fsf@rho.meyering.net>
	<86k5vj9gzu.fsf@blue.stonehenge.com>
	<20070508231115.GA14900@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 09 01:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlYxC-0005rq-3W
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967871AbXEHXSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 19:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032196AbXEHXSl
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:18:41 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:16498 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967871AbXEHXSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 19:18:40 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1A17F1DE6D3; Tue,  8 May 2007 16:18:40 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.5.6; tzolkin = 4 Cimi; haab = 14 Uo
In-Reply-To: <20070508231115.GA14900@efreet.light.src> (Jan Hudec's message of "Wed, 9 May 2007 01:11:15 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46634>

>>>>> "Jan" == Jan Hudec <bulb@ucw.cz> writes:

Jan> Than I can't think of anything other than xargs -0.

git-ls-files -z .... |
perl -0lne '
   $_ is each name here
'

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
