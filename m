From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 04:53:17 -0800
Message-ID: <86fy9udmf6.fsf@blue.stonehenge.com>
References: <45BDABB5.4070301@fs.ei.tum.de>
	<86zm82dpql.fsf@blue.stonehenge.com>
	<dbfc82860701290438y4e00cc05s5f8c8acdc8022768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: "Nikolai Weibull" <now@bitwi.se>
X-From: git-owner@vger.kernel.org Mon Jan 29 13:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBW0g-00074Q-B9
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 13:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXA2MxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 07:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbXA2MxT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 07:53:19 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:49108 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbXA2MxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 07:53:18 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 051371DE4D0; Mon, 29 Jan 2007 04:53:18 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.7; tzolkin = 9 Manik; haab = 0 Pax
In-Reply-To: <dbfc82860701290438y4e00cc05s5f8c8acdc8022768@mail.gmail.com> (Nikolai Weibull's message of "Mon, 29 Jan 2007 13:38:31 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38077>

>>>>> "Nikolai" == Nikolai Weibull <now@bitwi.se> writes:

Nikolai> We do require a POSIX-compliant version of sh already, right?

OK, sorry for raising the flag.  I just know that writing portable shell
is far trickier than writing portable Perl, so I get overly cautious
on anything that wasn't in Unix V7.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
