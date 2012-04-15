From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Sun, 15 Apr 2012 13:10:27 +0200
Message-ID: <20120415111027.GF6263@ecki>
References: <7v8vi04los.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:12:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJNNV-0002uR-QT
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab2DOLLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:11:45 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:58788 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751233Ab2DOLLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:11:44 -0400
Received: (qmail 31239 invoked from network); 15 Apr 2012 11:11:40 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL504.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub76.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <gitster@pobox.com>; 15 Apr 2012 11:11:40 -0000
Content-Disposition: inline
In-Reply-To: <7v8vi04los.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195558>

On Thu, Apr 12, 2012 at 03:41:55PM -0700, Junio C Hamano wrote:
> 
> * cb/http-multi-curl-auth (2012-04-10) 2 commits
>  - fix http auth with multiple curl handles
>  - http auth fails with multiple curl handles
> 
> Fixes http authentication breakage when we keep multiple HTTP requests in
> flight using curl-multi.
> 
> I haven't looked at Peff's follow-up deeply yet.  Perhaps a reroll is
> coming?

I think Peff's follow-up is based on the commits you already have in
cb/http-multi-curl-auth.
