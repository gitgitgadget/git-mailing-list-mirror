From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Dividing up a large merge.
Date: Wed, 15 Jul 2009 06:39:46 -0700 (PDT)
Message-ID: <m31voiuktb.fsf@localhost.localdomain>
References: <20090714233246.GA25390@huya.quicinc.com>
	<3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com>
	<20090715002926.GA26630@huya.quicinc.com>
	<20090715122828.GA6570@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davidb@quicinc.com, Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 15 15:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR4iC-00067L-LM
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 15:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbZGONjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 09:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbZGONjt
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 09:39:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8382 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbZGONjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 09:39:48 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1104683fga.17
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=WUCpoSgBo9etZkaPaojfLg0YxnYgFJWjUT5q41QADyE=;
        b=YbgbAbpYeUZLacTEtMomvI0W+zLBMKPsFTv+d2HQWPcHoHI/jTUhaqkJNU+Bkf4xcr
         J3lNsXmWnj1FMJDAPo3UgRCTCO2ZoyhKhWQW5Sun3oUmDlHlKd0GNXIIzNzvt9Z/3O3x
         qF+ONxEZMDOLWwl57Q8wG2i8BFIxGzgRD+DRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=giQvH8dHmE4M2NaemkiRwHFRvikSP/6cp4oOE9/IiOvF26gVnoDfkk9QnGgExQldFX
         F9aJm5VBt4YxL44bF325KtITkZ9Jl0rIBrtgMeWhLvow0ywFJ2WIUzmUK3v2YZsSMy3T
         hLLWWV5oJi3YDGQ7J7XTNoexnsfYzITiYOsAA=
Received: by 10.86.76.10 with SMTP id y10mr5025488fga.63.1247665187493;
        Wed, 15 Jul 2009 06:39:47 -0700 (PDT)
Received: from localhost.localdomain (abuz24.neoplus.adsl.tpnet.pl [83.8.197.24])
        by mx.google.com with ESMTPS id d6sm10134768fga.5.2009.07.15.06.39.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 06:39:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6FDdktC004915;
	Wed, 15 Jul 2009 15:39:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6FDdj2b004912;
	Wed, 15 Jul 2009 15:39:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090715122828.GA6570@mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123308>

Theodore Tso <tytso@mit.edu> writes:

> Yeah, that's another prime argument for maintaining your changes as a
> patch queue.  I use a combination of quilt plus git.

Why not StGit, or Guilt, or TopGit?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
