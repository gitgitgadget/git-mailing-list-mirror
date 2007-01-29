From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Replace perl code with pure shell code
Date: Mon, 29 Jan 2007 03:41:38 -0800
Message-ID: <86zm82dpql.fsf@blue.stonehenge.com>
References: <45BDABB5.4070301@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Mon Jan 29 12:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBUtK-0001qN-Tq
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 12:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXA2Llk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 06:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXA2Llk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 06:41:40 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:33401 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbXA2Llj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 06:41:39 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D4B851DEC39; Mon, 29 Jan 2007 03:41:38 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.7; tzolkin = 9 Manik; haab = 0 Pax
In-Reply-To: <45BDABB5.4070301@fs.ei.tum.de> (Simon Schubert's message of "Mon, 29 Jan 2007 09:09:25 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38074>

>>>>> "Simon" == Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

Simon> +			destname="refs/$branch_top/${name#refs/heads/}" ;;

I don't think this is portable shell.  At least Perl is the same everywhere.
Ignore me if this is a shell syntax on something other than bash.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
