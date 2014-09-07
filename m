From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH v2 2/2] headers: include dependent headers
Date: Sun, 07 Sep 2014 21:54:18 +0200
Message-ID: <540CB7EA.1000303@kdbg.org>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com> <1410049821-49861-2-git-send-email-davvid@gmail.com> <20140907194917.GB1611@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Ren=E9?= =?ISO-8859-1?Q?_Scharfe?= <l.s.r@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQiXd-0003EJ-Mn
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 21:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaIGTyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 15:54:23 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56860 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbaIGTyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 15:54:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 607B71000B;
	Sun,  7 Sep 2014 21:54:20 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5C05019F49C;
	Sun,  7 Sep 2014 21:54:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <20140907194917.GB1611@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256625>

Am 07.09.2014 21:49, schrieb Jonathan Nieder:
> +enum object_type;

Enum forward declarations are a relatively new C feature. They certainly
don't exist pre-C99.

-- Hannes
