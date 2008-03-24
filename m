From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: [PATCH] git-cherry-pick -x works with conflicting commits
Date: Mon, 24 Mar 2008 14:55:28 +0100
Message-ID: <ae63f8b50803240655k5d6413e5s8d6ceebca462370f@mail.gmail.com>
References: <1206355274-6052-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdn9z-0003aG-Eg
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438AbYCXNzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758452AbYCXNzm
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:55:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:58659 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758438AbYCXNzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:55:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so805027nfb.21
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 06:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=kexYuIid3bK8JSaT6b7U5Xq/5jZx5CwJhN3KwKmpwJs=;
        b=DTgGBDXwldXoWLW2J2tLNTc77fcP8hVb2PLw0lOTn97skdVNmRW5wG8SwJp33/qRPjtA7By1RHn5ixdUiDJmKgda1Vw40V7ke7pMnGHLQHCMyFLVdx2XGUPv56GNWuVjNRyeAgG04P/APUaxqsnhD4HToXoYavnDRz4g+URW3y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QVOqXm4WcdMCgPzh11b/zQtw0QIrE2D+861XwKE4kRBgHBXSpFIKF3DNKHma2kLKUqLqhLxi+McpqsLIx7Q8JktOPnj4o2ei91I133AMzemwj1cj+vGdXAVDjxKtEHfpg9qMaWrHu6GpoIt3RV7rHK+8VEkPEjBg7i5vWvOw+O4=
Received: by 10.78.146.11 with SMTP id t11mr20590583hud.70.1206366928282;
        Mon, 24 Mar 2008 06:55:28 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Mon, 24 Mar 2008 06:55:28 -0700 (PDT)
In-Reply-To: <1206355274-6052-1-git-send-email-rgarciasuarez@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b99a8e8962d22097
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78036>

When I'm using "git commit -c <id>" as suggested by git-cherry-pick
upon conflict, I do not get the mention "(cherry picked from commit
<id>)", at least with version 1.5.4.1.  How did you get it?

Cheers,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
