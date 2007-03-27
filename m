From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [PATCH] contrib/workdir: add a simple script to create a
	working directory
Date: Mon, 26 Mar 2007 19:42:30 -0700
Message-ID: <1174963350.6018.3.camel@localhost>
References: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
	 <20070327003033.4226.8413.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 27 04:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW1e8-0003Rz-Jx
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 04:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXC0Cmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 22:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXC0Cmr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 22:42:47 -0400
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:38490 "EHLO
	smtp-1.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbXC0Cmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 22:42:46 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.47.145])
	by smtp-1.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2R2gg9Z024490;
	Mon, 26 Mar 2007 19:42:42 -0700
Received: from [192.168.1.7] (adsl-75-26-200-82.dsl.scrm01.sbcglobal.net [75.26.200.82])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2R2gf4v017127
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 26 Mar 2007 19:42:41 -0700
In-Reply-To: <20070327003033.4226.8413.julian@quantumfyre.co.uk>
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.46.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43223>

On Tue, 2007-03-27 at 00:15 +0100, Julian Phillips wrote:
> +# want to make sure that what is pointed to has a .git directory ...
> +test -d ${orig_git}/.git || die "${original_git} is not a git repository!";
> +

Shouldn't this be made to work with bare repositories as well?

-Eric
