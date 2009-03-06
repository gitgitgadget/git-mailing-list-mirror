From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: how to have --no-ff be the default for all branch
Date: Fri, 6 Mar 2009 12:01:25 -0500
Message-ID: <76718490903060901j26308d42wfc288e522abee369@mail.gmail.com>
References: <1de9d39c0903060244t2d39e9c8kd5791d097c84bbeb@mail.gmail.com>
	 <1de9d39c0903060245u45373b8cq10d52f353c2214e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 18:03:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfdRl-0002uS-5P
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 18:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbZCFRB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 12:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbZCFRB2
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 12:01:28 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:10275 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbZCFRB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 12:01:27 -0500
Received: by rv-out-0506.google.com with SMTP id g37so580643rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 09:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YmXjOhE2ENflxmzqzl05sDxgVFErHs5Zjqxhk8tVcRE=;
        b=bvHUDNevFC9o9cdbS6K1jJ35KpfQtXBhlLPiFGb0ypNvTisAaMBMfhxToaRjZ7F0Ex
         6mMwBABKdaHdLwMXvMdJ4WK/qsR1yD3vt8islZomkwS5KT16epc5aacu4Yzj4FKK5G7F
         0fBu4ozFXQwgWzGiB9t/ZmEr8Zlqdswo3iqkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T3aqiTMYKtq5miUBikakcpUariwDs8+K7qX+fgeSNN2UWiGHf6FSnUo+Sdg8FCgaZk
         BQlT/fEE4lZtMwELeE/PSf2/YaVTP1GYOcsCEm/jkdT1ql7mDb0XnIf95/vrLxJWDdkx
         2H37djxH7SxKXgZ0mo23Iw7i9NR+c8oYaCEIQ=
Received: by 10.141.176.6 with SMTP id d6mr1364093rvp.233.1236358885163; Fri, 
	06 Mar 2009 09:01:25 -0800 (PST)
In-Reply-To: <1de9d39c0903060245u45373b8cq10d52f353c2214e2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112468>

2009/3/6 jean-luc malet <jeanluc.malet@gmail.com>:
> I would like that it is the default for all branch and that I use --ff
> when I want to do fast forward merge
> I know that I can set it up for one branch
> git config add branch.master.mergeoption --no-ff
> but I want it to be the default no just for one branch but for all branch
> git config add branch.*.mergeoption --no-ff
> don't work....
>
> how can I do that?

Not currently possible. The best you can do currently is to make an alias.

It would be a fairly trivial patch though to support merge.options. :-)

j.
