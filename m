From: "Eugine Kosenko" <eugine.kosenko@gmail.com>
Subject: Merging commits together into a super-commit
Date: Fri, 11 May 2007 15:41:45 +0300
Message-ID: <9909dee80705110541m13c4035tc8338e179d6bec9b@mail.gmail.com>
References: <20070510215515.3084.qmail@science.horizon.com>
	 <81b0412b0705110454w5b18c267x17e82453e736f0b8@mail.gmail.com>
	 <9909dee80705110537j7e6d1426p7723c110c0a2c667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 14:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmURU-00027E-P3
	for gcvg-git@gmane.org; Fri, 11 May 2007 14:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758353AbXEKMlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 08:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755939AbXEKMlq
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 08:41:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:10405 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758353AbXEKMlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 08:41:46 -0400
Received: by nz-out-0506.google.com with SMTP id o1so975642nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 05:41:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bgG8Gxpl2Xgv1La5Wl4SqaKzqGgK8n7wm0x3RQeXGqk44QfnzHhTQIRj8dLHIjY3iNS3jZp+3CvaXwhvaO7W4z1iHtiUCBnnWLrLutZZJg2csnHsbJGIWKlrQWH/4sFPBh+8kywzmOueWwjjlxFXMvniT8AceJe8ce0df9q0Ekk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVM+Hn7lDE4eKWYNi5PpIOOuoq2Ibaw+nzdFlQpIai5nGbrBtlem653pHdldlN8tW1pcI+ElC90HZhoyAiJxsHnudpA8hfgix7VUzSigxGFLpuXi5++jk47chKUaZ3/cOt1Oduu5ltQgzj8ULe5FF80RfYgq70jtvadDJ11W0/s=
Received: by 10.114.75.1 with SMTP id x1mr938285waa.1178887305129;
        Fri, 11 May 2007 05:41:45 -0700 (PDT)
Received: by 10.114.210.5 with HTTP; Fri, 11 May 2007 05:41:45 -0700 (PDT)
In-Reply-To: <9909dee80705110537j7e6d1426p7723c110c0a2c667@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46956>

2007/5/11, Alex Riesen <raa.lkml@gmail.com>:
> And it is not enough. Authorship information is lost.

If one dare to make such super-commit, he would be the author of the
whole couple of changes.

> And you have to be damn sure the "branch" starts directly at HEAD,
> otherwise everything HEAD..branch is lost. It is complex
> if you want it right.

I used to make git-rebase to add extra commits after this.
