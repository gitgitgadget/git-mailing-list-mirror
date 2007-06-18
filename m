From: Sergey Yanovich <ynvich@gmail.com>
Subject: git tool to keep a subversion mirror
Date: Mon, 18 Jun 2007 17:47:31 +0300
Message-ID: <11821780511231-git-send-email-ynvich@gmail.com>
To: git@vger.kernel.org, J.Sixt@eudaptics.com
X-From: git-owner@vger.kernel.org Mon Jun 18 16:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0IVW-0007bK-0A
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 16:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763316AbXFROqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 10:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763332AbXFROqb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 10:46:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:12879 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760717AbXFROq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 10:46:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1433091ugf
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 07:46:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rFGCx8xt55oS8pnlQE2d+f1A9aTdzCuY5epgWjZ6U6KU/v3OZOpGCVz/h75ISNldr8V1m6gAwYaRjr2I/bzPsnvkUDJ48d1xjfS9EtuII4Mcbt9XCnriWCL96WwHW8V8vFta30CDFHLj51+A3/SQHbKWmouV1bWgHN5zFf8b5us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OJOzdC1D+4nPy723LO6hLzSBXhP+BueQzlsQVeulnHCLxg/oshr1E8UNTSRxObVRjqX6+L6v4MyLYoIfIzFztY+JjkXpbfP7MTI63hVPgHjC6IfYfIaVTTv6nqJ09v9do/x/1HGuHeglRhoGAlR8W2wiBJ+/hjLwPu/liLDYowA=
Received: by 10.67.121.18 with SMTP id y18mr2895068ugm.1182177988306;
        Mon, 18 Jun 2007 07:46:28 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id j1sm12967275ugf.2007.06.18.07.46.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 07:46:27 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0IVv-0002zl-Ke; Mon, 18 Jun 2007 17:47:31 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 467686AB.504C619A@eudaptics.com
References: 467686AB.504C619A@eudaptics.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50398>

Johannes Sixt wrote:
> It is extremely difficult to tell whether the patch makes sense or is
> correct, if there is _no_ explanation what it is good for.

I agree 100%. I sent a fore-letter using git-send-email, but all parts got split. 

Pasting it manually:

> I am actively using git for my project. Thanks everyone envolved.
> 
> However, I got tired of administering own web server and registered my
> project at sourceforge. Unlike repo.or.cz (thanks again for everyone
> envolved), they do not provide git hosting. But a project without a
> source repository is non-sence.
> 
> I am not in any way going to use Subversion after I tried git, but I
> need to be able to export to a Subversion repository. I found an
> excellent tool called 'git-svn'. However, the flawed nature of
> Subversion put shackles on normal git usage after you do 'git-svn init'.
> 
> Since git is the best scm system, my situation is probably quite common.
> So I am filing these patches.
> 
> There is a 'git-svn' command which does want I need, so I created a
> simple wrapper around it. I also found that 'git-svn commit-diff' is
> having a small trouble dealing with root <tree-ish>, which is corrected
> by an attached patch.
