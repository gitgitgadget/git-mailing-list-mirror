From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb $export_ok question
Date: Wed, 31 Dec 2008 10:00:21 +0100
Message-ID: <200812311000.25818.jnareb@gmail.com>
References: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu> <m3sko5b84t.fsf@localhost.localdomain> <6db6bed70812302037w54fe5640of234cd611f5ab45e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Thomas Amsler" <tpamsler@ucdavis.edu>
X-From: git-owner@vger.kernel.org Wed Dec 31 10:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHwy4-0008M7-HA
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 10:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbYLaJAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 04:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756033AbYLaJAj
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 04:00:39 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:51362 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbYLaJAg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 04:00:36 -0500
Received: by ewy10 with SMTP id 10so5903843ewy.13
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 01:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DMnMFXamVWUM9r0s1hKny8BQrwsuveTIqHceZJKHb38=;
        b=ighBZNwOg3fFRErGgpLY8cw8bATYhfGStDxib9EqL+Inqj6RcwxQIcz2r8/8fSBzls
         U+PYOLDA0Cki7ewL0V9c9fjDeCeXz0XXI6hPBJZyraNqCC6PeENc9e/YUYApf01yfRIw
         YzD4XtR2BSaA3ozKDibf8LkCVdlvB5hV1Ei4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mZjhuh3Zt1xTlsBCye+kR4Pb/WoKTeX50PA+VwaX72+6V69twxwHIU/catODUK5Q3R
         nfh9jEtr+hhZGOiOFV3cOmpghntU5UaCTexlyoslB3Qtk8tX2Y0a6aOqW5SjUDeF8BtN
         Fd/L0JJTZa/VKKh/9ut+OGHOXWJzdfaroUZlI=
Received: by 10.210.109.10 with SMTP id h10mr18397430ebc.39.1230714034739;
        Wed, 31 Dec 2008 01:00:34 -0800 (PST)
Received: from ?192.168.1.11? (abwv44.neoplus.adsl.tpnet.pl [83.8.245.44])
        by mx.google.com with ESMTPS id 10sm25364eyz.19.2008.12.31.01.00.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Dec 2008 01:00:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <6db6bed70812302037w54fe5640of234cd611f5ab45e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104258>

Thomas Amsler wrote:

> Thank you for your information.
> 
> I have just tried that but the repository doesn't show up in gitweb
> 
> - added to /etc/gitweb.conf
> -- $export_ok = "gitweb-export-ok"
> - touched the "gitweb-export-ok" file in the repository
> -- touch /path-to-repo/repository/authz.git/gitweb-export-ok
> 
> Then gitweb reports:
> 
> 404 - No projects found
> 
> Does the gitweb-export-ok file need to be part of  the repo so that it is
> tracked?

No, gitweb-export-ok file has to be in $GIT_DIR (like description file),
not part of repo.

As to "No projects found" error: what is your $projectroot? Is it
either "/path-to-repo/repository" or "/path-to-repo"? Is repository
readable and searchable for the web server user (does it have correct
permissions)?
-- 
Jakub Narebski
Poland
