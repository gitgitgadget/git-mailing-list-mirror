From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: git svn dcommit does not cleanup after errors
Date: Fri, 14 Mar 2008 18:49:10 +0300
Message-ID: <c6c947f60803140849n7116a58cp77e10217f2d97a38@mail.gmail.com>
References: <c6c947f60803090636m3c656d35x5a924d093f68628e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 16:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCAJ-00031A-6x
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYCNPtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754101AbYCNPtM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:49:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:38769 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbYCNPtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:49:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4608806wah.23
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OjECsB4IVvscT0UwsdQjtuGwuxk9kNvN0Ym2NOHk3js=;
        b=NopdaOAMExDuI9e/Govu47ZdMzGI3hZn2Ygtr0SH/ujQ/ZXkiK+3d2Cd+crvuAz0rYZB2Z2O2otfKHqqNAe/u/b4uuTGWs0XM8L5KeXxLpv6MxsiS3Mlq6hzSQQIRrcugD661/MPK+CSq+KDAeCxZzMLes0MkvGGOU4UwMsyQ7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hmVh8U0MRry5HCwU+K2y+Zf59D3KAKCzOabysAJ3xRAZ/icZ8MiHU6Rl1ugRN40XVB4TTxibdbKbUQroXIzFGIZi9RNQSlkXEBHZ6sul30Ppycg/YHyipHdMLnYxcKt5w+djlYfRdYxNyphbz2peacxuKCnFdqy7CZW+loDiM3k=
Received: by 10.114.135.1 with SMTP id i1mr12088179wad.115.1205509750528;
        Fri, 14 Mar 2008 08:49:10 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Fri, 14 Mar 2008 08:49:10 -0700 (PDT)
In-Reply-To: <c6c947f60803090636m3c656d35x5a924d093f68628e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77247>

Hi, list!

>  (GIT v1.5.4.4)
>
>  When I'm doing git svn dcommit and it fails in the middle (due to SVN
>  pre-commit hooks or connection errors or whatever), it leaves my HEAD
>  rewound to the last commit it attempted to upload. I have to manually
>  do git reset HEAD@{whatever}. Is this behaviour intended? Is there a
>  more convenient way to restore my HEAD state?

Is this a RTFM question? Or is it a feature? I have not found any
solutions to this problem so far, and this issue is quite annoying on
bad network. :-(

Thanks in advance,
Alexander.
