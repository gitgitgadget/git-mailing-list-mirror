From: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <nudrema@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 14:20:08 +0200
Message-ID: <f35478f50805110520n444402a5u86c498d91f82941c@mail.gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>
	 <4826DF6A.2070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Dima Kagan" <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvAY0-0000kW-60
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbYEKMUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYEKMUL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:20:11 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:32719 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbYEKMUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:20:10 -0400
Received: by an-out-0708.google.com with SMTP id d40so393851and.103
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=858rQRCntPob9FUAHUUra8peR29jcxDpmxo7RDT9V7k=;
        b=jmdzcEt5wTMNUmPl7RAEPlOWz7zMchmiIOLNqh1sy6AD3x6omst7ZjbQOHTThaYS0Tzp6O3VnCXmZXCSmV3cyrG9tEc9xqaEvipt1qXIicajZKngnM5yyGJFRb/ZO9H9xPpUWb6GqxeywAqL+VZhhuaNWl21jIZu8EZ1LV8NPLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Npu7X4UcBnVZORGzDbmCTrfSLaK5uG2Rjidfni1MBLFwpcO8o8KWET8Jozn39qpqTwm4dBBDBNld4uc07D6Ca3lpvJb0DKjD0/wlKZF2fSyYzNeO7nkuFAzlwsw4GQYTeK3ugTjsSmeBIBdYVLTmEZAnYfOfZM9z/E1iXUyfgTw=
Received: by 10.100.172.16 with SMTP id u16mr7467678ane.9.1210508408407;
        Sun, 11 May 2008 05:20:08 -0700 (PDT)
Received: by 10.100.42.10 with HTTP; Sun, 11 May 2008 05:20:08 -0700 (PDT)
In-Reply-To: <4826DF6A.2070306@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81765>

On Sun, May 11, 2008 at 1:58 PM, Dima Kagan <dima.kagan@gmail.com> wrote:

 >  >> Basically I see that the same file I edited on the 'test_branch'
 >  >> branch appears to be modified on the 'master' branch as well. This
 >  >> behavior is unwanted, of course.
 >  >>
 >  >> Can someone please tell me, what am doing wrong? Or is this git's
 >  >> normal behavior?
 >  >
 >  > This is normal, and wanted, behavior.
 >  >
 >
 >  That's a subjective point of view :) I'm coming from the SVN world
and uncommitted changes on one branch don't affect other branches. Is
there a way I can achieve this behavior with git?

 There are several ways, actually.

 The one I prefer to use is to commit the modifications. Then, you can
 use git-reset HEAD^ to drop that temporary commit when you come back
 to this branch, or git-commit --amend to modify it.

 Always keep in mind that in git's world, history is not set in stone,
 you can always modify previous commits, reorder them or merge them, as
 long as you have not pushed them to your public repository (in your
 case, the SVN one).
