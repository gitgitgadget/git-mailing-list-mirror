From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: interrupting "git rebase" (Re: git rebase +)
Date: Fri, 14 Oct 2011 00:29:04 -0500
Message-ID: <20111014052904.GB401@elie.hsd1.il.comcast.net>
References: <loom.20111013T134405-495@post.gmane.org>
 <4E96E5E1.7010103@viscovery.net>
 <20111014052653.GA5052@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Piatyszek <ediap@wp.pl>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 07:29:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REaKl-0001Km-Oc
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 07:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268Ab1JNF3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 01:29:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36007 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236Ab1JNF3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 01:29:13 -0400
Received: by gyb13 with SMTP id 13so771142gyb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yV206fLHE4TFAc2Ft6lPrWm8ahzHjvucWF9WsEURNvw=;
        b=kjPR/bLF0hYJPs3CpPdUsxMJ20iSAVpVcmLSMk3Ssm9U+eQparDnXOy1eZPsX9bPuq
         LxXM2OG9CHUKEH7uOP4i8fypyt+o9Lo5UJo+0sTpgjYoSYxTIPXmXaGmN6grtpgrBVlS
         4QHjqQM32KnUW5Lbwb2D6ZdJZuRDVfDWwdmUQ=
Received: by 10.236.138.161 with SMTP id a21mr9147394yhj.87.1318570153173;
        Thu, 13 Oct 2011 22:29:13 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z28sm3225377yhl.4.2011.10.13.22.29.11
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 22:29:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111014052653.GA5052@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183539>

Jonathan Nieder wrote:

> By the way, what happened to the "git rebase --abort-softly" synonym
> for "rm -fr .git/rebase-apply" discussed a while ago?

(Here's a pointer I should have included[1].  Sorry for the noise.)

[1] http://thread.gmane.org/gmane.comp.version-control.git/174655
