From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: git-svn clone on a central server
Date: Sat, 15 Mar 2008 19:45:38 -0400
Message-ID: <eaa105840803151645j5e8ec443v991b9117df343b8f@mail.gmail.com>
References: <frh8k1$lc8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bruno Harbulot" <Bruno.Harbulot@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Sun Mar 16 00:46:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jag5M-0002o5-2J
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 00:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYCOXpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 19:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbYCOXpl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 19:45:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:40288 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYCOXpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 19:45:40 -0400
Received: by fk-out-0910.google.com with SMTP id 19so921467fkr.5
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=yQNIitg856wnX17SWbTOa8VPqyELgmtGVdrYHOiv5co=;
        b=AYb1s/wTLghfZee/5uCDWabTmfGK6iYOv//8S+8dsb6pPr8sV5NJvUTvddBz18goO9dt2KFjKf0SCWCNTYTk7uvDehArDeQQO8g2Yuw/x7405TmXlvVEqS44DUrLceXTflxgonCrwS40lnIAduVe/vAPTUfO/UVM+3J0nbLRrC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nJTTDQSuGGyXjkH2Kmi8Aq0m5MYckrSfx74ojiE1ArodrRFcjKSg0U3L8Cd8053/2miiQrILqcRzUOA5bnS9+LUklNQ7+78xORxHfS6M+M2DUbwvQtzrjRJ1PU/w3tAW2J6dRuVT014pd7d65L+HoNuEmpvipRi0gav7IMkbZD4=
Received: by 10.78.205.7 with SMTP id c7mr37071237hug.27.1205624738358;
        Sat, 15 Mar 2008 16:45:38 -0700 (PDT)
Received: by 10.78.107.13 with HTTP; Sat, 15 Mar 2008 16:45:38 -0700 (PDT)
In-Reply-To: <frh8k1$lc8$1@ger.gmane.org>
Content-Disposition: inline
X-Google-Sender-Auth: df1369e5bd155fa3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77343>

On Sat, Mar 15, 2008 at 3:38 PM, Bruno Harbulot
<Bruno.Harbulot@manchester.ac.uk> wrote:
>  I'm trying to follow example 3 of the git-svn manpage, since I'd like to
>  keep a "central" clone of a subversion repository (and rebase it
>  regularly) on a server and work on local git repositories based on that
>  server's git repository.
...
>  I get this error:
>
>  $ git-svn rebase
>  fatal: ambiguous argument 'HEAD': unknown revision or path not in the
>  working tree.

You have to git reset --hard <branch> to create 'master' based on a
particular svn branch, or git-svn won't know what to rebase.

I sent a documentation patch to this list back in February, but it
appears to have been dropped. I should probably re-send it...

http://article.gmane.org/gmane.comp.version-control.git/72954

Peter Harris
