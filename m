From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 7/8] detached-stash: tests of git stash with stash-like arguments
Date: Thu, 19 Aug 2010 21:57:59 +0200
Message-ID: <201008192157.59773.j6t@kdbg.org>
References: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com> <1282139333-5150-4-git-send-email-jon.seymour@gmail.com> <AANLkTi=tuX9CPagi=j9gMt9Kr3P0G4Mpb+43w+NPbfvu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 21:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmBFX-0005Cj-I5
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 21:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab0HST6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 15:58:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:26501 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab0HST6B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 15:58:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 13637CDF90;
	Thu, 19 Aug 2010 21:58:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D4ADB19F5BF;
	Thu, 19 Aug 2010 21:57:59 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=tuX9CPagi=j9gMt9Kr3P0G4Mpb+43w+NPbfvu@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153953>

On Donnerstag, 19. August 2010, Jon Seymour wrote:
> I'll need to re-issue this patch. The later tests execute
> 'successfully', but don't properly implement the intent. In
> particular, the condition:
>
> ! git stash stash@{0}
>
> should really be:
>
> ! git stash drop stash@{0}.

Better write this as

  test_must_fail git stash drop stash@{0}

-- Hannes
