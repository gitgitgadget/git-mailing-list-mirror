From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 21 Oct 2010 14:31:25 +0200
Message-ID: <968F09BD-2B2D-44C4-9C0F-BF7BD20041F0@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <m3ocar5fmo.fsf@localhost.localdomain>  <4CBFFD79.1010808@alum.mit.edu> <1287660007.24161.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Oct 21 14:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8uIz-0002Ak-Us
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838Ab0JUMbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 08:31:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43383 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757812Ab0JUMba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 08:31:30 -0400
Received: by eyx24 with SMTP id 24so1991795eyx.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=ZoI9PuMsgbqBWIE+MrFE7KwVxS9tIdVNqAIcbwDdxjM=;
        b=a/DPs88eBhjrVwVWtmjQOf125xNwuMWOwbKxUthaU0DjCXW8Hw/xBMz4xfpuYb8ib3
         aO3HQpkDvvX2J4elJYXts+hd0st8v9I/KS6M0PNHLimWQJW93Bnqx4g4XxfiUqt7CiiR
         It0AfgVYPssipFuIjKLx2jlvXdNXIFjSDQiGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=qL4R9pKoBXNB9Z5mPTS+7bssrjyDF8CL4G6I88cyvAScE3V870vswm/b0oVC2+Wvpd
         Dqge/22oHlvKbLxpS6ikr2iF1iIWCwFCrOsVtkxG/lwpx/TOzEsUq6hDMuFUc5Br8iwY
         ryCDMGRo0D61El1w1lCtesrSfmCcBhafjI0CI=
Received: by 10.213.22.66 with SMTP id m2mr1582454ebb.56.1287664288948;
        Thu, 21 Oct 2010 05:31:28 -0700 (PDT)
Received: from thoremba.cs.lth.se (thoremba.cs.lth.se [130.235.16.114])
        by mx.google.com with ESMTPS id w20sm1731916eeh.0.2010.10.21.05.31.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 05:31:27 -0700 (PDT)
In-Reply-To: <1287660007.24161.10.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159495>


On 21 Oct 2010, at 13:20, Drew Northup wrote:

> Ok, so what will "git stage" do when a change of a file is already
> staged and it is executed again (on new changes)?

Presumably what it already does: nothing. But one could argue that the =
more public-relations minded command =93git stage=94 should give better=
 feedback. Like so:

> $ git commit=20
> $ ... edit A.txt ...
> $ git stage B.txt
> git stage: Did nothing. No uncommitted changes to stage in B.txt.
> $ git stage A.txt
> $ git stage A.txt
> git stage: Did nothing. Changes in A.txt already staged. Use `git dif=
f --staged A.txt` to see them.
