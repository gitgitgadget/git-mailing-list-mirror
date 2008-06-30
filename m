From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Mon, 30 Jun 2008 20:51:39 +0400
Message-ID: <37fcd2780806300951sd164870ib09bfc5e47dcaa57@mail.gmail.com>
References: <20080630151113.GO5737@dpotapov.dyndns.org>
	 <alpine.DEB.1.10.0806300858380.25384@alchemy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDMcI-0004Ci-BI
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbYF3Qvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 12:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbYF3Qvl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 12:51:41 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:52691 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYF3Qvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 12:51:40 -0400
Received: by yx-out-2324.google.com with SMTP id 31so293740yxl.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OmsoJ84dPj8cqhVn4nosYiO2TXcry6PD/gdx3IDpD08=;
        b=LWlll9FuMsYXIxPXxKEQVl+ZktmUHE4R714Qn+HM0SXtvNKQl103R9Xq2OHaGlBtqX
         Ln416RQ4nU27A/YOzEm1A7e7s0ZDaG5VJMWQ/RZSeeu4Xsjo1Ib6+xbula9wpQM1Ycwn
         YaITvTi7EPSpET5+sblvln/j61zb6HRUjpkDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TodIjKF+cRz1o5gSI36xNhIUP7GYqbNaka6Jg0HO/qUSLuPZAEcqn7fAbvagh973yu
         D6BloHk1gJp9ab1GAbaQwfmOqisyWqrRqDZwspx3d1M+2WGdFnmSGqR+p0kUl3S+Bg3N
         plTXBcfgvEs8vI4Bpq53PZzqGMH7VvQnJUz1A=
Received: by 10.142.223.4 with SMTP id v4mr1982449wfg.172.1214844699186;
        Mon, 30 Jun 2008 09:51:39 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Mon, 30 Jun 2008 09:51:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0806300858380.25384@alchemy.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86921>

On Mon, Jun 30, 2008 at 7:59 PM, Asheesh Laroia <asheesh@asheesh.org> wrote:
>
> I seem to recall that gitosis works with git-shell.  Maybe I'm
> mis-remembering, though.

I don't see how it is possible for gitosis to work with git-shell.
Besides, in the article (which also is mentioned in Gitosis FAQ in the
section:  Creating new repositories and adding users") clearly state:

"The next thing to do is to create a user that will own the repositories
you want to manage. This user is usually called git, but any name will
work, and you can have more than one per system if you really want to.
The user does not need a password, but does need a valid shell
(otherwise, SSH will refuse to work)."

Source: http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way

So, I think you misread something.

Dmitry
