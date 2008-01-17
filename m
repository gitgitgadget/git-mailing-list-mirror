From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 23:59:53 -0500
Message-ID: <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 06:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFMrZ-0001gC-7P
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 06:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYAQE75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 23:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYAQE75
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 23:59:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:53549 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbYAQE74 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 23:59:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so848293wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 20:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ulWm1UvbMq4M8k2NwgGvoIXkiq52+dv0Pfy+APHshaU=;
        b=CLjyar0gp/UdCXeNy/hlXI3Gy4THPt2xX+Ga98atR29f0uKdTH8d5kbK3my3qyifnzQPugL3z/DEefT2lSyRGT3BaLvSdb1TCfiVGdzhzzSXOEo/uZQQic6V/I0HGedG8VVhHYJpLSkxUy5oNDpJbYkiCeKPumvZAeMP+fLHVgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=wVe6FWwChUXLdJXDmoUn3iti0wP6jZwiazilkrYTvnTtJumP8hsFkJgrJsA5QfUWqsRFFes+twTxiEkXNR77AttBtJDdJiizxkITyAK6K7IdltrvIOE59I7lekMp5Uoo44fVzppOCGtUyGzvesRVoAqit8XmDylghGaR/zaLGqA=
Received: by 10.115.88.1 with SMTP id q1mr1915468wal.64.1200545993792;
        Wed, 16 Jan 2008 20:59:53 -0800 (PST)
Received: by 10.114.14.17 with HTTP; Wed, 16 Jan 2008 20:59:53 -0800 (PST)
In-Reply-To: <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: dbb338badfb3e136
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70826>

So here's what I can see as being useful additions to git:

* Allowing a repo to be *optionally* configured to disallow two files
in a directory that can cause aliasing problems, with options for
unicode normalization aliasing and/or case-insensitivity aliasing. Can
this already be done via hooks and someone just needs to write the
appropriate hooks?

* Having git warn during checkout if there are files which alias in
the working copy filesystem. I guess it might be interesting if there
were a mechanism in this situation for telling git which of the
aliases you want checked out, though that doesn't seem like a very
good feature.

Thoughts (besides "patches welcomed")?

j.
