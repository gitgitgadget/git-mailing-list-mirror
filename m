From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: "git svn fetch" slow
Date: Sat, 31 Jan 2009 17:23:34 +0100
Message-ID: <bd6139dc0901310823lcced62frd61445cb80d56fca@mail.gmail.com>
References: <200901311414.58205.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 17:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTIeW-0005zu-J4
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 17:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZAaQXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 11:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbZAaQXg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 11:23:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:41317 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZAaQXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 11:23:36 -0500
Received: by fg-out-1718.google.com with SMTP id 16so251213fgg.17
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=unjN9+2tF6dWcQAl+lbw51W+eA35oV4do+/b5trBL0M=;
        b=ZyAuDBpcHQK2ET291BPbfij+EXmoL1Wa64dAwyFOkVQc7MYaJtB+RfqHOj6wGrLOpX
         1VyaHScxqn4g191HzyAm9yFeZToh2aR8YIxm+bdaH2UurtPRVmsM4k3nH3JKKkJSUpGW
         EnGaPGfvSIzZgNxfvc1dKIYwm6pNk3ofLCREE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VVgku2R4v4ZW19J0RX6EEf4i2bFjjPufX4TTWtQyKpla1TDtnaSgxbh7N9XTTBk/cY
         xjLKla/KJVCnFE647/KI7MChG5gQKkuIIRHrDMjszVnUZeBilZuk2BXGA7caAt4lD6Wm
         6DmXwFN2PSbtEghGP+0DulyzP9/JTX937rNg8=
Received: by 10.86.92.9 with SMTP id p9mr1289897fgb.15.1233419014156; Sat, 31 
	Jan 2009 08:23:34 -0800 (PST)
In-Reply-To: <200901311414.58205.markus.heidelberg@web.de>
X-Google-Sender-Auth: cb969f18dc1d399d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107930>

On Sat, Jan 31, 2009 at 14:14, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> since several days "git svn fetch" didn't seem to work any more. I
> bisected it down to

I noticed it too, it's horribly slow; I can't really revert the patch
since it conflicts, and I'm not familiar with the code, so I don't
know how to resolve the conflict :(.

-- 
Cheers,

Sverre Rabbelier
