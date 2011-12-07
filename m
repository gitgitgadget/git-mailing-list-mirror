From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC PATCH] git-p4: introduce asciidoc documentation
Date: Wed, 07 Dec 2011 09:46:57 +0000
Message-ID: <4EDF3611.3000902@diamand.org>
References: <20111203235328.GA3866@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 10:46:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYE5F-0000OW-QR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 10:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab1LGJqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 04:46:32 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60027 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab1LGJqb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 04:46:31 -0500
Received: by eekd41 with SMTP id d41so272059eek.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 01:46:30 -0800 (PST)
Received: by 10.14.9.84 with SMTP id 60mr3396872ees.60.1323251189925;
        Wed, 07 Dec 2011 01:46:29 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fa8sm1471965bkc.14.2011.12.07.01.46.28
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 01:46:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111203235328.GA3866@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186451>

On 03/12/11 23:53, Pete Wyckoff wrote:
> Add proper documentation for git-p4.  Delete the old .txt
> documentation from contrib/fast-import.
> ---
>
> I'd appreciate review by git-p4 people to make sure I captured
> everything from the old documentation, and to catch any errors.
> There's a fair amount of new content in here, describing all
> the options and variables.  I left out some obscure commands
> on purpose.
>
> Comments from anyone else would be welcome too.  Especially
> in the area of generic asciidoc formatting or style in git
> command pages.

That looks good to me, I can't see anything of note, just one minor nit, 
below.

Luke


>
> Thanks,
> 		-- Pete
>
>   Documentation/git-p4.txt       |  456 ++++++++++++++++++++++++++++++++++++++++
>   contrib/fast-import/git-p4.txt |  289 -------------------------
>   2 files changed, 456 insertions(+), 289 deletions(-)
>   create mode 100644 Documentation/git-p4.txt
>   delete mode 100644 contrib/fast-import/git-p4.txt
> +
>
> +------------
> +$ cd project
> +$ vi foo.h

I think it works with other editors as well, although I've not tried it 
myself. Obviously with reduced functionality :-)


> +git-p4.allowSubmit::
> +	By default, any branch can be used as the source for a 'git p4
> +	submit' operation.  This configuration variable , if set, permits only

Spacing around comma in "variable , if set"

Luke
