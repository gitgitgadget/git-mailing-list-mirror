From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Tracking the untracked
Date: Thu, 7 May 2009 20:24:30 +0930
Message-ID: <93c3eada0905070354v2b8ff258m8db7b1d4968eb2ce@mail.gmail.com>
References: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
	 <200905061522.56981.trast@student.ethz.ch>
	 <93c3eada0905070058g7f619a56jfb9b49f02bb92f9b@mail.gmail.com>
	 <200905071117.00162.trast@student.ethz.ch>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 07 12:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M21FP-0006B6-UE
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 12:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbZEGKyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 06:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbZEGKyb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 06:54:31 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:15218 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZEGKya (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 06:54:30 -0400
Received: by qw-out-2122.google.com with SMTP id 5so512886qwd.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ldHkqvPgdByzuP3AKOiPDw727tSFSCDmtJSCV7uyGmQ=;
        b=eR6BgWUz2QOyZ39Pph47CH213yEydzQ/gJ0qbLnP/7YbVAnPMcFvXqu0ZrSIIAG4cn
         WWpjECFRLkBrfARI5OtM0W5NEAx1I+9XHR3vwkfMsgzkcY6+plmxm2PPfIld74Qadefg
         Xt2T154XUSfxKZW2y1uZEFQpkC4+iH8eYA/TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=EE+fnS7BtT2GQFBXSDv6iMgXCvp5zoVEKstCxyuPfxxoUhF6xTiNxZ/kl+4mgPq9K9
         4ZvSziw/B0bBCGIWSmH0TjvuEh93xKEIcPg7weZocZCWK33GPvwrOQfAy2WdFcebRJjc
         4j5FqQltGdSRWLKDQlNcwtZM2ifpAuqnvzF+w=
Received: by 10.220.85.199 with SMTP id p7mr5033368vcl.104.1241693670927; Thu, 
	07 May 2009 03:54:30 -0700 (PDT)
In-Reply-To: <200905071117.00162.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118461>

On 5/7/09, Thomas Rast <trast@student.ethz.ch> wrote:
> Geoff Russell wrote:
> [...]
>  - Consider what happens if you were to recompile at this point, so
>   that you again have the _untracked_ (w.r.t. the 'master' branch)
>   build products, and then check out B1 again.  Git faces the choice
>   of either overwriting your worktree files (and losing them) or not
>   overwriting (and not doing the checkout right), so it will abort.
>   This is a corollary of what Jakub pointed out, Git will not lose
>   information unless told to.

Understood. Upon reflection, I can't think of a better alternative.

Cheers and thanks for the help,

Geoff.
