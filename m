From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Applying patches from a patch set
Date: Sun, 21 Dec 2008 10:53:21 -0800 (PST)
Message-ID: <m3abapcqck.fsf@localhost.localdomain>
References: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
	<slrngkrv22.knd.sitaramc@sitaramc.homelinux.net>
	<dac45060812211034w38691627scf2a36ed814353f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sitaram Chamarty" <sitaramc@gmail.com>, git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 19:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LETSE-0001m2-6V
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 19:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbYLUSxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 13:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYLUSxZ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 13:53:25 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:34310 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYLUSxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 13:53:25 -0500
Received: by ey-out-2122.google.com with SMTP id 22so178151eye.37
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Mzq4lY1Fim5tEg484JWaHFa6VM3ueOKrPWp11MgQ5LA=;
        b=t8VxjHUiZzeNQaqqLIUN5HEkk/Hi/71H9WSH69d49bNQtiuLyPRQnbqPg7TWtLciTX
         iLlRiN6QCw+IuFFCq/xDdXHIL4W7CTembV3iKnJ7gXoc9ZbAIVfXz92Z6vWhU3Lejyst
         cJLNYf+V600SmbkEqb4BdFHapuai+YoElbgN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=II0waSBn1TZVTQHKXyMZggyKFnCYXDlORDYKPcEmtOdYRRrYySFEeFiJ0R4Xqj2QGH
         HF1oGCtm4Coo/4nayVg6bfzVoZrm/Lcq+1HndNgY0m5uSDkeXjUvo2beMcKPdQJzijTc
         f6/Nc/nCflfJy3kbp42M3FRZ2xAtWPZUJwosI=
Received: by 10.210.126.18 with SMTP id y18mr6460410ebc.44.1229885603102;
        Sun, 21 Dec 2008 10:53:23 -0800 (PST)
Received: from localhost.localdomain (abww40.neoplus.adsl.tpnet.pl [83.8.246.40])
        by mx.google.com with ESMTPS id 7sm1323511eyb.11.2008.12.21.10.53.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Dec 2008 10:53:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBLIrKBa017049;
	Sun, 21 Dec 2008 19:53:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBLIrGdq017045;
	Sun, 21 Dec 2008 19:53:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <dac45060812211034w38691627scf2a36ed814353f9@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103706>

"Mark Ryden" <markryde@gmail.com> writes:

> However, after I tried:
> setenv NNTPSERVER gmane.linux.kernel.wireless.general

This is not a _NNTP server_; this is _news group_ name.
You should use news.gmane.org for NNTPSERVER.

> I assume that this is some silly mistake I had done,.Any ideas?

setenv NNTPSERVER news.gmane.org

-- 
Jakub Narebski
Poland
ShadeHawk on #git
