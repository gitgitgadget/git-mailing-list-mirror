From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH RFC3.5 03/12] send-email: Interpret --smtp-server "" as "use a default".
Date: Sat, 18 Apr 2009 17:35:50 -0600
Organization: icecavern.net
Message-ID: <200904181735.51696.wjl@icecavern.net>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com> <1240074128-16132-3-git-send-email-mfwitten@gmail.com> <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 01:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvK6N-000805-Lh
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 01:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbZDRXgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 19:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbZDRXgD
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 19:36:03 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:52949 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753816AbZDRXgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 19:36:03 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 555943655D;
	Sat, 18 Apr 2009 17:35:57 -0600 (MDT)
User-Agent: KMail/1.11.0 (Linux/2.6.27-14-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116871>

On Saturday 18 April 2009 11:01:59 Michael Witten wrote:
>  	`/usr/lib/sendmail` if such a program is available, or
> -	`localhost` otherwise.
> +	`localhost` otherwise. Also, a built-in default is used if

I think you may have meant:
+	`localhost` otherwise. Also, the built-in default is used if

> +	`<host>` or 'sendemail.smtpserver' is the empty string (for
> +	example, if '--smtp-server ""' is specified on the command line).
