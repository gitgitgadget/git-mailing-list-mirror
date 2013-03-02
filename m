From: <git-users@io7m.com>
Subject: Re: Debugging a bizarre problem: What can influence 'git fetch'?
Date: Sat, 2 Mar 2013 12:59:50 +0000
Message-ID: <20130302125950.7724564e@copperhead.int.arc7.info>
References: <20130301143940.7e31f0c2@copperhead.int.arc7.info>
	<CALUzUxoFwpi6J3TKTaxuCjLumOkyhWFLqz6k_23X4P0xpwD26A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 14:02:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBm5I-0004Du-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 14:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab3CBM7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 07:59:55 -0500
Received: from bs3-dallas.accountservergroup.com ([50.22.11.58]:39809 "EHLO
	bs3-dallas.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab3CBM7z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Mar 2013 07:59:55 -0500
Received: from dsl78-143-199-137.in-addr.fast.co.uk ([78.143.199.137]:55462 helo=copperhead.int.arc7.info)
	by bs3-dallas.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git-users@io7m.com>)
	id 1UBm2c-00028A-0X; Sat, 02 Mar 2013 06:59:54 -0600
In-Reply-To: <CALUzUxoFwpi6J3TKTaxuCjLumOkyhWFLqz6k_23X4P0xpwD26A@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bs3-dallas.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - io7m.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217327>

On Sat, 2 Mar 2013 18:32:17 +0800
Tay Ray Chuan <rctay89@gmail.com> wrote:
> 
> It seems that the remote is running the 'dumb' http protocol, you
> might want to try setting the GIT_CURL_VERBOSE environment variable
> for more verbosity.
> 
> Have you tried running git-update-server-info on the remote side?
> Perhaps a push/fetch led to packs being created so the f981a2b object
> isn't available as a loose object but in a pack but the remote still
> indicates otherwise.

Hi.

Yes, git-update-server-info has been used on the remote but to no avail.

I'll try GIT_CURL_VERBOSE. Thanks!

M
