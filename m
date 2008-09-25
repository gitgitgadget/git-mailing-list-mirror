From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] Some suggestion
Date: Thu, 25 Sep 2008 13:51:57 +0200
Message-ID: <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 13:53:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KipPA-0005ZH-RB
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYIYLwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYIYLwA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:52:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:47977 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbYIYLv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 07:51:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so276919fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AfJH5H5EZ13bDdYKyZfNWgeCsilNiCoJhugvUgI32kQ=;
        b=b1hua9B9niNo6JKJ/uhEBKfX9Q0kkccDAxREX5kdxF/O7np4hmE/H/hnoeMSJWd2mM
         fw3A2snbBX0Y90uzMmh6dtyn3DXLqkiDEOSp2jJftbH/Zo/vCRhYL13lA7esM0obUpfi
         0Vqm5WuyGdKLCwa8hkHrZ0M4v4eTi/a170dWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QssQ0MG97pGo13eJ5EjFbe8lYDWOhSQ6Jo/+Drj1h7S08tT88MgRe0q3jhGbQxCZ7U
         rT1SbYXRaBG45fEuG2D7IsdDygzV18Yd7LZO58mMsLrHuwgw5+ZiAZekTFTV9yiyjB8h
         lVHAvBGOe6DbdWamP1mlO9NTaS3YVksR05j24=
Received: by 10.180.216.16 with SMTP id o16mr379129bkg.13.1222343517253;
        Thu, 25 Sep 2008 04:51:57 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Thu, 25 Sep 2008 04:51:57 -0700 (PDT)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96753>

On Thu, Sep 25, 2008 at 7:24 AM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
> Can add below function at qgit?
> ===Difference other version===
>        1. user choose a commit,
>        2. right click
>                Check working dir
>                View patch
>                ....
>                [Diff with other commit]
>
>        3. change icon +
>        4. user choose other commit
>
>        QGit show list of changed files.
>        click one files, call extern diff tool show difference.
>
> === file view ===
>        Can use different color to high light current commit change.
>

You can _already_ do this.

 1. user choose a commit

 2. user choose other commit with CTRL + RIGHT CLICK


One of the problems of qgit is that the features are not immediately
visible. This is a conscious choice to avoid cluttering the GUI.

Currently the _best_ way to have a  complete idea of qgit is to read
the handbook (press F1 key): it takes only 5 minutes and you can find
interesting features otherwise very difficult to find by accident.

Marco
