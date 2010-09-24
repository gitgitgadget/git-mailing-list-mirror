From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: git-svn error
Date: Fri, 24 Sep 2010 16:33:36 -0400
Message-ID: <AANLkTikMsXhAJUU6tgcjMGdq2FGmgW3dXY_SS8=iMu2v@mail.gmail.com>
References: <AANLkTi=5ficziLK8cfikotoxkgUDLfhAM_RLzCOcOv5U@mail.gmail.com>
 <AANLkTi=KGtBJ=6-YWUJCsbmBWfnr1Kh2i=LaZmgM=8t5@mail.gmail.com> <4C9C530D.3040206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:34:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzEy9-0000rY-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114Ab0IXUeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:34:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40775 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758106Ab0IXUeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:34:03 -0400
Received: by iwn5 with SMTP id 5so2641993iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=OY+YhJlBCcz+lGdFFEuhza3Pu4Sbi2I3pz1SuHMXiKI=;
        b=oQTIspCZNKFe1GZ1T438pw3TDtkfcQEnpnJH2Z6GysYre323zSdKd5PlP76iXFD06t
         o18nHakqVYdGou4ceisGZLmlpajzvnCEq7Ygu7rAlLjUOqtcV4w76szF8fL41EhQw8Bk
         k0aQYsmAF8QgYU4IVZP4l+G2TDzaOEWUwo9Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DD9WKK/HTGbKgNYU/n5dw2U3fdUowCHS1rrCBiYwN6MHf9kPCUjK8PDWgpZLrlVL0k
         QiQHww/7xmRQySa+CTdNuHnHffCWqe65KtCe0k6pt/MX3fz1oz5SKGIs6FSBT9YeTYja
         9mQoOUESau2inCyRcfHghOD3jBkD9liZ4nEoM=
Received: by 10.231.184.156 with SMTP id ck28mr2534350ibb.168.1285360438316;
 Fri, 24 Sep 2010 13:33:58 -0700 (PDT)
Received: by 10.231.113.141 with HTTP; Fri, 24 Sep 2010 13:33:36 -0700 (PDT)
In-Reply-To: <4C9C530D.3040206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157053>

On Fri, Sep 24, 2010 at 3:28 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> Nate Parsons venit, vidit, dixit 23.09.2010 21:45:
> > Hi all,
> >
> > I reproduced the problem on openSUSE, running git 1.7.3. I can't
> > provide access to the subversion repository, but I can do anything
> > else to help diagnose the problem.
>
> How about providing some context of that error message, i.e. a
> transaction log? Also: Is this from a fresh repo?

I'd be glad to do this, as long as nobody can use these logs to
recreate the contents of my repository. What commands do I run?

This is happening in a fresh repo, I do the 'git svn init' first, and
then 'git svn fetch $head' (where $head is actually a number). This is
to work around my other git issue that hasn't gotten a response.

I was able to fetch the entire repository using a combination of
TortoiseGit (for the initial init and fetch, until it died with a file
permissions error) and then fetch the rest of my history with msysgit,
so this isn't a show-stopping issue for me.

-Nate
