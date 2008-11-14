From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: getting started with git
Date: Fri, 14 Nov 2008 13:56:14 +0100
Message-ID: <1a6be5fa0811140456j10fd8703w74e485571e3c70af@mail.gmail.com>
References: <20497802.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ivan Senji" <ivan.senji@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0yLU-0000hQ-7V
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbYKNM4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 07:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYKNM4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 07:56:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:40556 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYKNM4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 07:56:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1122220fgg.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E0xhl0sGl2DgsoXz0B3wpndJs3Yn+wucOWZqyWCjVEM=;
        b=nG9ombCov/M0Lmn+L10FArKsi8nJm30YluAw45V3Odox3Ys9/jadFuULerKWe+2khr
         KNeGjMaLByt8IVbgSIiyR6ADv1KMKmCeIy4i1aMjTnsIIM5EFUBMId6UE729kueSENjD
         djhuL5l3tBmw2n6paI+jB3F6Ee4Pe5fu5Leoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=diVC/pNHfoZU/0TK7AkVuwY8x+6dSqZIcQFewM7Z3+dF+MKA+yIu81PhjNGymGT36n
         H5UPzsdJl1Y0ogoGGmbRnqZvM8M36rh1+ywI//BF4c4rNt7zZ7NW0OWt26+qVefpenYh
         sVlbU9oqWh518BtaRJwQcw5J0jWhppNBkIkUM=
Received: by 10.86.9.8 with SMTP id 8mr572189fgi.48.1226667374131;
        Fri, 14 Nov 2008 04:56:14 -0800 (PST)
Received: by 10.86.9.6 with HTTP; Fri, 14 Nov 2008 04:56:14 -0800 (PST)
In-Reply-To: <20497802.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100968>

On Fri, Nov 14, 2008 at 11:16 AM, Ivan Senji <ivan.senji@gmail.com> wrote:
> On each location that i develop some project and configuration files are
> different. But i would like them to be in the repository as a starting point
> when checking out a project (example: opening a project on a dfferent OS in
> eclipse... eclipse will find an error in the path to jdk and ask me to fix
> that error by selecting a different jdk).
>
> How to achieve that these files are in the repository but that any further
> changes to them are not commited (or are commited localy but not pushed to a
> remote repository)?

Hi,

Well, if it were me, I think I would commit that eclipse config file
under a different name... Say, ".classpath.defaults" instead of
".classpath". Then your README file could tell your users to start by
copying the .classpath.defaults to .classpath, and update its contents
as necessary. Put .classpath in your .gitignore file, so it won't be
committed to the repository.

-Tor Arvid-
