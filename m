From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: How to achieve "git tag --merged"?
Date: Tue, 27 Apr 2010 13:26:01 +0200
Message-ID: <t2i8c5c35581004270426mf5cb8d2dp81e84506d088108d@mail.gmail.com>
References: <alpine.DEB.2.00.1004270846280.4769@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Apr 27 13:26:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6ivY-0007ox-VL
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 13:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919Ab0D0L0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 07:26:04 -0400
Received: from mail-qy0-f195.google.com ([209.85.221.195]:57674 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648Ab0D0L0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 07:26:03 -0400
Received: by qyk33 with SMTP id 33so13194118qyk.24
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fMOqXNsJZJU4agH4GX1L6nt819D3Xxkv1MvWLYDqjCw=;
        b=kFZE0ACCMrg6PEvo7aWYQ6LzUqeZKipZNpWbJZNGeyWy1n9X8R9912aRZ8k0iV1gvR
         jQp8U+qiVx7ziyzgD9GV4qSU7EkK83Y8S8HlOPLpjp4CEHFbEMQUlRr//a/ICzjAwuP9
         ly4wTOdT+VZVDPFs6szk9o5bbygqYUwKcHl/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eXcjG2B0f3lvlsqytfQ8px3NABnty8PQBfLCLvBYFWjLmh1aPpqVVVZaLn50lyjFE0
         ML4hbDm/lcUabVIA0agzBFIFsJ3dhi/mS34FslqjZcefq28sDu+AlYvicpGUV7lEuoMN
         xqzPAr7+lfJ3NRUAe8etiu+kJsLQnjEHPyqEs=
Received: by 10.229.212.213 with SMTP id gt21mr2830060qcb.2.1272367562023; 
	Tue, 27 Apr 2010 04:26:02 -0700 (PDT)
Received: by 10.229.28.211 with HTTP; Tue, 27 Apr 2010 04:26:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1004270846280.4769@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145898>

On Tue, Apr 27, 2010 at 09:59, Peter Krefting <peter@softwolves.pp.se> wrote:
> I wish to list all tags that are set on commits that are ancestors of
> the current commit

Try `git log --decorate --simplify-by-decoration --pretty=%d`

--
larsh
