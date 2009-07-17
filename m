From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: encrypted repositories?
Date: Fri, 17 Jul 2009 13:22:15 -0700 (PDT)
Message-ID: <m3skgvt5zi.fsf@localhost.localdomain>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
	<4A60A168.2060105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 22:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRtx5-0005Eg-Rp
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 22:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbZGQUWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 16:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbZGQUWV
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 16:22:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:1050 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282AbZGQUWT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 16:22:19 -0400
Received: by fg-out-1718.google.com with SMTP id e21so323554fga.17
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=sE8QpqlUHXF/Lsaj0GIztKlsJ8XhPEOeemy5PuKOV1o=;
        b=dM8XFXh6pvhLbH59I4dKQqBCZySm3tJsv5HCiSf7skUaa0OaMP4sr2gawAkkm82SCT
         RTAn0jrchpnWtAf7f/NBXe/OhYiODYQAen3Rvzv5+Ur9CftV/jEoWwH9ctHTWE5SvKkW
         MRF0BbO+ZJ8ZLTemRD1Xw40bIeuraoqnLtOdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jgqxjmEsM673Ay9c0JHZUelF3F9lz3jyEfps9/FHJqkTBWdzZiYP8dE4ln4nYEQDom
         gHo2DK81ztPidDd2TrYEiwIY7yYVehnhWu2EvtHP+8MYgVyQ8D4I9YT7IaNePZkXRtld
         mOblfPzAa8OwNSbxYRTyL33J6yVhiQLgnmrZA=
Received: by 10.86.96.17 with SMTP id t17mr1164572fgb.20.1247862137468;
        Fri, 17 Jul 2009 13:22:17 -0700 (PDT)
Received: from localhost.localdomain (abvs148.neoplus.adsl.tpnet.pl [83.8.216.148])
        by mx.google.com with ESMTPS id e11sm1886309fga.21.2009.07.17.13.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Jul 2009 13:22:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6HKMFxv015472;
	Fri, 17 Jul 2009 22:22:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6HKM97K015468;
	Fri, 17 Jul 2009 22:22:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A60A168.2060105@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123485>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Matthias Andree venit, vidit, dixit 17.07.2009 17:14:
> > 
> > I have a rather special usage scenario.
> > 
> > Assume you have a repository where you want to work on embargoed  
> > information, so that not even system administrators of the server you're  
> > pushing to can get a hold of the cleartext data.
> > 
> > "Server" would be a central reference repository that I can push to.
> > "Client" would by my working computer that has a clone of the crypted  
> > repo, and an unencrypted checkout of it. Perhaps the client would also  
> > need an unencrypted copy of the repo (for performance reasons, I'm not  
> > sure about that) that gets encrypted on the fly when pushing and decrypted  
> > when fetching.
> > 
> > Examples of use might be press releases of upcoming products, written  
> > exams for students, whatever.
 
> If the server can not decrypt anything then it can not serve anything,
> at least not as a git server. Note that if you're really fussy about
> security then you should not allow the server to see even the DAG (which
> would be the case if you encrypt blobs only), which makes it impossible
> to do any smart serving.

There was shown here on git mailing list script which was meant to
help in situation where you have repository with sensitive deta,
discovered repository corruption or bug in git, and cannot be
reproduced otherwise.  But I think it didn't encrypt repositry, but
just emulate it's structure.

As to encrypting repository: you can encrypt blobs (content of files),
you can encrypt filenames (but the structure remains) or you can put
files in a flat encrypted structure, and you can encrypt commit
messages and comitter and author info, and encrypt / rename branch
names.  Still some DAG structure will be visible, and need be visible
for "smart" git server (access via ssh and git protocols) to work.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
