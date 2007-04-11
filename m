From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/4] Don't use section 7 for main manpage.
Date: Wed, 11 Apr 2007 10:34:03 +0100
Message-ID: <b0943d9e0704110234qc23ef41ma0bb4eaac714c320@mail.gmail.com>
References: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
	 <20070407213658.13698.44552.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 13:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbZDR-0007Bw-1k
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 11:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbXDKJeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 05:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXDKJeG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 05:34:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:61919 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbXDKJeE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 05:34:04 -0400
Received: by ug-out-1314.google.com with SMTP id 44so77340uga
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 02:34:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ueK9FejgtF5Tll77GSCKWPgeoImSBIOJFol3uGnTqitEu28lT9CqplrQG1Z9bh7InAgRmU0hY3NnWqBKwfVMA2kW/60Oa6sGZdsAqnNxEX9XVy453AzLEQyLfEmGtFnzi0edea/vDliHeHeID4NH+KJxveJ8GONkS3/kNaAB+ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DHElICKm1ktEU/0wOIFH3c/LWuu87NMybHhpdHmk0Xel+8VekknHyQstic833BB1aNv5cVUC0wSd8lt3ZCkIPDqpNMHvUCnXLL3ZiLr5IYVaZ7A1zlTUDUq1mzVPVTXdd0XzNoR8CGocVErzlmyg2no/rvm21BC3EJeSsfQOZZg=
Received: by 10.67.11.15 with SMTP id o15mr323177ugi.1176284043262;
        Wed, 11 Apr 2007 02:34:03 -0700 (PDT)
Received: by 10.66.255.11 with HTTP; Wed, 11 Apr 2007 02:34:03 -0700 (PDT)
In-Reply-To: <20070407213658.13698.44552.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44209>

On 07/04/07, Yann Dirson <ydirson@altern.org> wrote:
> --- a/Documentation/stg.txt
> +++ b/Documentation/stg.txt
> @@ -1,4 +1,4 @@
> -stg(7)
> +stg(1)
>  ======

In error, I added commit 5906924135f886527c1e947d100073067783eaa2 that
was reverting this hunk. My reason was to be able to install the man
pages and the Makefile was still looking for stg.7. I'll revert my
commit tonight and change the Makefile.

-- 
Catalin
