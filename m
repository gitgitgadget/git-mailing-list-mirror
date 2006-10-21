From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 12:34:31 +0200
Message-ID: <200610211234.31967.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610211036.44679.jnareb@gmail.com> <vpq64eeyo8v.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 12:34:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbEBU-0001FA-MY
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 12:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992920AbWJUKeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 06:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992917AbWJUKeZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 06:34:25 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:19388 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992920AbWJUKeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 06:34:25 -0400
Received: by hu-out-0506.google.com with SMTP id 28so523439hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 03:34:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jlizp7Sj2qfCR6t89A9E2IQfN5bNur9kLIt2hzGvjLM3uuBYyLLjH7u1fgsvuScAHesEFSSH9ITOZPhg/Z6M/SVD0t13TSOA+I0DJTiRjnuOIwiqcmlKEvrhUuV2xp0EQJWAV0LnX+qH2eUxgs6Zl4dfyYcqLjWfZq53Fa8M5xU=
Received: by 10.66.224.3 with SMTP id w3mr3615628ugg;
        Sat, 21 Oct 2006 03:34:23 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 28sm2355068ugc.2006.10.21.03.34.22;
        Sat, 21 Oct 2006 03:34:23 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <vpq64eeyo8v.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29601>

Matthieu Moy wrote:

> Another relevant difference between a patch and a bundle is that the
> bundles knows its ancestor, so, when you apply the bundle, it builds
> the new revision with exact patching. If you need a merge, then it
> will happen exactly in the same way as a merge between two branches
> (ie. three-way merge for example).

By the way, if patch send via email is git enchanced patch, with
[shortened] sha1 of blobs (file contents), and our repository has
the blob the patch is supposedly to apply to (but for example line
of development moved forwards) we can request via --3way command
option to git-am to fall back on 3-way merge if the patch doesn't
apply cleanly.

It is not as powerfull as merge of branches, but it is sufficient
in most cases. And in other cases you have to resolve conflict by
hand, anyway; git-rerere (which records resolving of conflicts and
reuses them) can help there.
-- 
Jakub Narebski
Poland
