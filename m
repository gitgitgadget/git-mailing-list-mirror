From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/4] Refactor git-mergetool--lib.sh
Date: Thu, 18 Aug 2011 09:57:50 +0200
Message-ID: <CAHGBnuOziicuWPhRhtmpva8pt5ybJTTDP-mU=1zcnNZBMbz3Pw@mail.gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:57:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtxUB-0002FX-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab1HRH5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:57:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37586 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1HRH5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:57:51 -0400
Received: by qwk3 with SMTP id 3so1139016qwk.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Na8DTOzffCjGih1UCrg/z6a8WUqgiz1mrK7JC+4bteI=;
        b=i5M+jm0XeeYpG6sJUX4yGzaCSL4VsWVehSjAE5fGz8mDC0DfWa8+bzu1xvm/e2AaFb
         K6dMlX9VwdJDPDS8L4ayr6cCGN016YSqbYoJxScgxLUFMpWdU+M8v3rkO7T6mGRhOjfj
         L6X49uhW8PeDXJDoYBzR0LoXawEfO4vxxwdtI=
Received: by 10.224.198.7 with SMTP id em7mr331346qab.330.1313654270523; Thu,
 18 Aug 2011 00:57:50 -0700 (PDT)
Received: by 10.229.182.11 with HTTP; Thu, 18 Aug 2011 00:57:50 -0700 (PDT)
In-Reply-To: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179579>

On Thu, Aug 18, 2011 at 09:23, David Aguilar <davvid@gmail.com> wrote:

> This series splits the git-mergetool--lib.sh file into separate
> tool scriptlets that define the commands for diff and merge.

Very nice as it simplifies adding new merge tools to adding a single
file with little code inside. Thanks!

-- 
Sebastian Schuberth
