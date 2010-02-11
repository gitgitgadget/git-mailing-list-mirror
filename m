From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-mailsplit: add `mailsplit.keep-cr` configuration variable.
Date: Thu, 11 Feb 2010 10:35:54 -0800 (PST)
Message-ID: <m3k4uj8vts.fsf@localhost.localdomain>
References: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
	<20100211181354.GC15028@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Thu Feb 11 19:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfdth-0006KC-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab0BKSgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 13:36:12 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45629 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0BKSgI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 13:36:08 -0500
Received: by ewy28 with SMTP id 28so232585ewy.28
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2S7wGj0TZChM/YmXGF6blQjo3r0JjEGH9pf1wrKtbGY=;
        b=DMqeRSywxQKkVgfjhcpdpnB+6oaL1KLvLyyqwea8efXZZRNILzI5+bII9/aBJoepWX
         YUlxGWuuwb8mGCh9QLwUCZnIDgPeRLvWVvwR7qViOW+VDw9WHE/m0bFYXWLsu6pn/SLs
         WwgdezSnjY+GHfURhiadP9r5d7an9+e1tQhtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GEnbWPpFcH0ZRwMaLjxstgy9DFISh2UvzQoTGTIBM5W9QVs/nlAG6u8n/jZHGn4D5v
         fiku132J2rvWmBAWAHwdC1AJiIPur+F1P1KGC0H6TK8pOymDlpvjBItGe6QZbYq4qJTx
         fFCQk13bTregJuSLeWz49bwQqr7+joxchqj2Y=
Received: by 10.213.44.18 with SMTP id y18mr946621ebe.69.1265913357232;
        Thu, 11 Feb 2010 10:35:57 -0800 (PST)
Received: from localhost.localdomain (abwf229.neoplus.adsl.tpnet.pl [83.8.229.229])
        by mx.google.com with ESMTPS id 14sm1722212ewy.7.2010.02.11.10.35.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 10:35:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1BIZSC2004799;
	Thu, 11 Feb 2010 19:35:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1BIZCar004795;
	Thu, 11 Feb 2010 19:35:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100211181354.GC15028@scotty.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139615>

Subject should read start with '[PATCH 2/4] '.

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> If using git-mailsplit in environments where files with dos and unix
> line ending stay in one repository mbox patches must be split with
> additional parameter '--keep-cr', because the behaviour of
> git-mailsplit have been changed in commit c2ca1d79.
> 
> With this patch the behaviour of git-mailsplit can be set via
> configuration file.
> 
> Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
> ---
[...]

> +mailsplit.keep-cr::
> +	If true git-mailsplit will not remove `\r` from lines ending
> +	with `\r\n`. See linkgit:git-mailsplit[1].
> +

The convention use by config variables is to have camelCase or
allsmallcase name (variable name and section name are case
insensitive), e.g.:

  transfer.unpackLimit::
  status.showUntrackedFiles::
  sendemail.aliasfiletype::
  repack.usedeltabaseoffset::

etc., with the only outlier being add.ignore-errors.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
