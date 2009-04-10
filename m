From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] send-email: Add config option for sender address
Date: Fri, 10 Apr 2009 09:34:32 +0900
Message-ID: <20090410093432.6117@nanako3.lavabit.com>
References: <1235005238-15500-1-git-send-email-xyzzy@speakeasy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Trent Piepho <xyzzy@speakeasy.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kV-0007hz-Qy
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764050AbZDJAfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbZDJAfS
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:18 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56636 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763318AbZDJAfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:17 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 02CE011B8B8;
	Thu,  9 Apr 2009 19:35:16 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id RDZGEJ853BCT; Thu, 09 Apr 2009 19:35:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=STLqCwIQz+ZmLhkpB3aQuWlyY93NjS1ZrB4PwnFT7QHcHCYuLdI9ZrfClUJNSi38D4PVkKlM71kscoGsobGuBSRLkj7Y0POPuAyM2ZHxp7oAjIoILSi6g4bmijfou82T9dk09/NVcQcqK530d0V5yQGwYVFG83X9BwhemtFqahw=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1235005238-15500-1-git-send-email-xyzzy@speakeasy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116225>

Quoting Trent Piepho:

> The sender address, as specified with the '--from' command line option,
> couldn't be set in the config file.  So add a new config option,
> 'sendemail.from', which sets it.  One can use 'sendemail.<identity>.from'
> as well of course, which is likely the more useful case.
> 
> The sender address would default to GIT_AUTHOR_IDENT, which is usually the
> right thing, but this doesn't allow switching based on the identity
> selected.  It's possible to switch the SMTP server and envelope sender by
> using the '--identity' option, in which case one probably wants to use a
> different from address as well, but this had to be manually specified.
> 
> The docs are also fixed up somewhat.  If '--from' is specified (or the new
> sendemail.from option is used) then the user isn't prompted.  The default
> with no '--from' option (or sendemail.from option) is GIT_AUTHOR_IDENT
> first then GIT_COMMITTER_IDENT, not just GIT_COMMITTER_IDENT.
> 
> Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>

Junio, may I ask what happened to this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
