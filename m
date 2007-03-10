From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git's is_inside_git_dir too strict?
Date: Sat, 10 Mar 2007 18:49:50 +0700
Message-ID: <fcaeb9bf0703100349h329bbc1dn41e65531a8d1e5b9@mail.gmail.com>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com>
	 <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
	 <20070309120001.GA32300@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Matthias Lederhofer" <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 12:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ05P-0001Vj-KT
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 12:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbXCJLtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 06:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbXCJLtx
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 06:49:53 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:46161 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbXCJLtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 06:49:51 -0500
Received: by an-out-0708.google.com with SMTP id b33so1008119ana
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 03:49:51 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mi3F73+E5X8qYQqDrgK8cQ6LeBobZZHzJfGubVgfAHTTY6IoOJmJ7T8Rc+flD6DH6+sbNl/qcNm/nESDpjMEdO79StmmHuXK7COIg1q4kgdrnBuoOtEMVqiWoV8iGzKWLCZM1GIt5ps+4id5vZPmgEZioyk/BKX27RV4Q4kn6e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=taaQRv72RHZwRU1KW2OA6dgwpd/n3SgQLNG0vRzUK5VLmVlAHZkAG4KusVx0uIusC4nlbV1QaYbHNk933ZqeCXgnnSwv1V9T+COlRA0ayftkilbwxtfeEvDRzhXMrbSFUlK7UpwrnvAb7s+mNOAT5axygDK3dqzcZkxiUwAl7D4=
Received: by 10.114.131.2 with SMTP id e2mr168170wad.1173527390832;
        Sat, 10 Mar 2007 03:49:50 -0800 (PST)
Received: by 10.115.19.15 with HTTP; Sat, 10 Mar 2007 03:49:50 -0800 (PST)
In-Reply-To: <20070309120001.GA32300@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41864>

On 3/9/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > By the way, is it plausible to add --git-workdir option to specify
> > working directory? With that option, I won't need to chdir to the
> > working directory, run git commands and chdir back.
>
> http://article.gmane.org/gmane.comp.version-control.git/38382
> Since I did not need this feature that much and no one replied that
> there is any interest I did not look any further into it.
>

You obviously have a fan now :) Are you going to rework the patch? I
think I could finish it if you don't have time for it. FYI, the patch
seems not working ("Not below specified working directory")

-- 
Duy
