From: "Gustavo Sverzut Barbieri" <barbieri@profusion.mobi>
Subject: Re: [PATCH 0/2] gitweb use sections
Date: Thu, 31 Jul 2008 16:43:35 -0300
Message-ID: <b1f2b8c40807311243i5689683avcc3c3c91e4e6a900@mail.gmail.com>
References: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 21:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOe4l-0005BX-NN
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbYGaTni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbYGaTni
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:43:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:3009 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbYGaTnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 15:43:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so358344fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 12:43:35 -0700 (PDT)
Received: by 10.86.60.14 with SMTP id i14mr6444854fga.75.1217533415360;
        Thu, 31 Jul 2008 12:43:35 -0700 (PDT)
Received: by 10.86.90.15 with HTTP; Thu, 31 Jul 2008 12:43:35 -0700 (PDT)
In-Reply-To: <1217298868-16513-1-git-send-email-barbieri@profusion.mobi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90974>

Since nobody replied and I missed some gitweb guys in CC, I'm adding
Petr and Jakub, as some guys said on IRC.

Have anyone tried this patch, any problems?


On Mon, Jul 28, 2008 at 11:34 PM, Gustavo Sverzut Barbieri
<barbieri@profusion.mobi> wrote:
> The following two patches will add sections to gitweb so usability is
> improved for large project listing. It looks like:
>
>    http://staff.get-e.org/
>
> but it's a new code that also supports owner sort.
>
> Patches orverview:
>
>  * [PATCH 1/2] gitweb: sort projects by path.
>   This one is required to fix project sort. Since we use paths, we
>   should compare individual components to make it look like a
>   tree. Since we now can enable sections this error will be more
>   evident, so there is the fix.
>
>  * [PATCH 2/2] gitweb: add section support to gitweb project listing.
>   The real section work. This will add use_sections variable and if
>   it evaluates to true sections will be enabled. Just project and
>   owner sections are implemented.
>
> I hope it looks good for inclusion. Last time I did perl was about 8
> years ago, please point any problems and I'll fix them.
>
>
> --
> Gustavo Sverzut Barbieri
> http://profusion.mobi embedded systems
> --------------------------------------
> MSN: barbieri@gmail.com
> Skype: gsbarbieri
> Mobile: +55 (19) 9225-2202
>
>



-- 
Gustavo Sverzut Barbieri
http://profusion.mobi embedded systems
--------------------------------------
MSN: barbieri@gmail.com
Skype: gsbarbieri
Mobile: +55 (19) 9225-2202
