From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Mon, 15 Nov 2010 14:48:31 -0800
Message-ID: <EDBF4929-2ECF-4CDD-9F0B-0EE3B6BA68A7@sb.org>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 23:48:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI7qq-0003M8-CN
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 23:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866Ab0KOWsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 17:48:35 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59739 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab0KOWsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 17:48:35 -0500
Received: by pzk28 with SMTP id 28so1032706pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 14:48:34 -0800 (PST)
Received: by 10.142.223.2 with SMTP id v2mr1683594wfg.240.1289861314848;
        Mon, 15 Nov 2010 14:48:34 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x35sm530606wfd.13.2010.11.15.14.48.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 14:48:33 -0800 (PST)
In-Reply-To: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161519>

On Nov 12, 2010, at 12:55 PM, Martin von Zweigbergk wrote:

> With 'git pull --rebase', the user can configure the upstream repository
> to fetch from and reference to rebase against if none is specified on
> the command line.
> 
> However, if, instead of 'git pull --rebase', the user were to do 'git
> fetch' followed by 'git rebase', the upstream branch would need to be
> specified on the command line. This patch teaches 'git rebase' to
> default to the same configured upstream ref as 'git pull --rebase'
> uses.

What happens if one were to do `git fetch origin some_other_branch`
followed by `git rebase`?

-Kevin Ballard
