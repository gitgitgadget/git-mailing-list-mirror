From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 22:11:07 +0100
Message-ID: <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	 <m3hbtrdu1r.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 23:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14wG-0001PO-Uo
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbZJVVLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756568AbZJVVLF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:11:05 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:59453 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbZJVVLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 17:11:04 -0400
Received: by ewy4 with SMTP id 4so1048107ewy.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=JVaTasRflongKsn7E2BRkCj4/ld6oTS7PU73w/4tct4=;
        b=LtHQ3iZPNepsE1Q8lGNP5sqIsZhD94+w3+5ScOOA+DMEe4xOqisQHYeitoSwntTWZ6
         QR5ApnSt7UfJXtQG56XalG/Uua7SvdUOoFYPm8ETpbAVYTBJ2WAox+/nhoIBJRa7O272
         TivZT1obe/gOV2CclNgj/UlVjuGCjUv3RPr38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=maA8MvfMVmdIJFQuWdIVWVlIDjsZEAgjJ9fDODlhtAjxTR23IuL9DeoSeoK38wSlFl
         uzqJax8k83itV1JBXHpwwJr2GY0UhAQd9zZbDQBGiG/vJwSszt5e4OX+VPWKnrLzgeGG
         sejDZ/cNKLgphUusbtJdtCEbgso1y6y0/LDwA=
Received: by 10.216.93.69 with SMTP id k47mr632965wef.179.1256245867784; Thu, 
	22 Oct 2009 14:11:07 -0700 (PDT)
In-Reply-To: <m3hbtrdu1r.fsf@localhost.localdomain>
X-Google-Sender-Auth: 2d7bc15db3bfd7fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131061>

> You can use either "git merge --squash" or "git rebase --interactive"
> (changing 'pick' to 'squash').
>

Actually thinking some more.... I don't understand something about
this. I don't actually want to merge or rebase with anything. I just
want to say "make those commits a series of commits on a branch into
just one commit with a new message". I seriously suspect I'm missing
the point somewhere but what has that got to do with merging or
rebasing?

Thanks again
