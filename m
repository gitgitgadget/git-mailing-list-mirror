From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] Fix sed usage in tests to work around broken xpg4/sed
 on Solaris
Date: Sun, 19 Jul 2015 22:22:51 +0200
Message-ID: <55AC071B.9040800@kdbg.org>
References: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
 <1437328836-19156-4-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	johannes.schindelin@gmx.de
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 22:23:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGv6x-0008Bz-1l
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 22:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbGSUWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 16:22:55 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:22762 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753662AbbGSUWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 16:22:54 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mZHgH5w1nz5tlG;
	Sun, 19 Jul 2015 22:22:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 56BE852CB;
	Sun, 19 Jul 2015 22:22:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1437328836-19156-4-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274295>

Am 19.07.2015 um 20:00 schrieb Ben Walton:
> -	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
> +	perl -pne "s/CHANGE_ME/change_me/" file >file+ &&

Did you mean '-lpe' or better '-pe' here?

-- Hannes
