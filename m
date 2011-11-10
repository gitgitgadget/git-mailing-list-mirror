From: Nathan Broadbent <nathan.f77@gmail.com>
Subject: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Thu, 10 Nov 2011 10:46:06 +0800
Message-ID: <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
Reply-To: nathan.f77@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 03:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROKev-00044k-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 03:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab1KJCq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 21:46:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45601 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab1KJCq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 21:46:28 -0500
Received: by bke11 with SMTP id 11so1901345bke.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 18:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=Omy3+3YqIuBDITD9pRyZ76z18vEa7jXo4RLbQExczOU=;
        b=ijuwp6SrPeUBJ9tTpp3uC6ypwNs0oil+BXXqSCtHuD7nJwrMUvPzkoQKyEfyEd8tPs
         62uVl0rmASglQRwG8T04WhNTwWPsvTvSteWGitFBy9pbsXhHOsHvmr9CdtjmFHJYewDI
         nrG7HxU2G4IcqJ5cNzfId2GLRcFnlokj9NiSs=
Received: by 10.204.143.74 with SMTP id t10mr3579976bku.45.1320893187095; Wed,
 09 Nov 2011 18:46:27 -0800 (PST)
Received: by 10.204.40.74 with HTTP; Wed, 9 Nov 2011 18:46:06 -0800 (PST)
In-Reply-To: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185184>

Dear git mailing list,

I'm assigning the `_git_fetch` bash tab completion to the alias `gf`,
with the following command:

    complete -o default -o nospace -F _git_fetch gf

The tab completion then works fine in git 1.7.0.4, but breaks on git
1.7.7.1, with the following error:

    -bash: [: 2: unary operator expected


Here is the related issue on github (the project is a set of git shortcuts):
https://github.com/ndbroadbent/scm_breeze/issues/11


Thanks for your time, I'd really appreciate some help!


Regards,
Nathan B
