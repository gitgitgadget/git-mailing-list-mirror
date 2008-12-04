From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Thu, 4 Dec 2008 09:05:36 -0700
Message-ID: <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Peter Krefting" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Dec 04 17:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Gj9-0007x3-0F
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 17:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbYLDQFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 11:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYLDQFi
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 11:05:38 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:40787 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYLDQFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 11:05:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1953968wah.21
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IGqAezyWklCskWN+AYLNKQ0PMYcmC1ZfFYAz836VlP0=;
        b=V/04cuYNMe1t057FRnt+52fDqDAzGrP7QlOTyt1JSPvXdt1eUANRuGj0B2e58XdSLw
         5c3q+0zCVpzz217g8+xGgLSfoC5hEGyCTdFTfq9+GEQgN2NpjW+X81HkeXUQpS4KTJAE
         g+8zk8TOuu0sM3MRxtMc1gLJftbzbyX0GMXL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XD/a65Mm8FWMJaVyKiRpu8uML5fsw8dYsX/oajpqxzmqltG4K4RVZzJstmV5b5xJqe
         FTDIW3R+KaFZf0lUkU9H9UbdodYL+8CjYkLimr+rpuUVjkbgBsWNBxc7FN6165yb9cJR
         crOjJBZb0PaYU9Yl7R1IQrb+vFoe5iv4uxTFI=
Received: by 10.114.24.5 with SMTP id 5mr9104032wax.106.1228406736730;
        Thu, 04 Dec 2008 08:05:36 -0800 (PST)
Received: by 10.114.57.17 with HTTP; Thu, 4 Dec 2008 08:05:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102345>

On Thu, Dec 4, 2008 at 3:43 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Hi!
>
> When using Git on Windows, it doesn't pick up a user name from the
> environment, which leads to commits made by git gui (and probably by
> git itself) to show up as being made by "unknown <username@.(none)>"
> (where "username" is the Windows account name).

That's strange. I am using git 1.6.0.4 on cygwin and I get a warning
message every time I start git gui.  I actually find this really
annoying and would like a way to turn this warning message off.

>
> Is it possible to add a warning to git-gui the first time a commit is
> attempted if the e-mail address is not configured, and have the user
> open the configuration dialogue to set up the name properly?
>
> --
> \\// Peter - http://www.softwolves.pp.se/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
