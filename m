From: Seth Falcon <seth@userprimary.net>
Subject: Re: git and peer review
Date: Sat, 17 May 2008 14:30:39 -0700
Message-ID: <20080517213039.GR396@ziti.local>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com> <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Toby Allsopp <Toby.Allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Sat May 17 23:32:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxU0s-0006wl-Ss
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 23:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759604AbYEQVb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759577AbYEQVbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 17:31:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:10181 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758459AbYEQVbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 17:31:25 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1010315waf.23
        for <git@vger.kernel.org>; Sat, 17 May 2008 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=5XU7XgUc9Cqv9S5sNl+IhHlDFCOcHmqsbLFHNUmdKUw=;
        b=YWT7WAHYhwUmhZ3dsb9XR1tyygVVtLypOTSyKTP7EmdFVebaW5ZIU0ocKtoTF2t+g9lkBlEc/sYKfKfrWdnvW45o2SEteJ5PI+duwIerlEDB9VlFABcOYD5K4r5l4C3O0dVnK5rhOcB1vc7HoATqNpCFsy3smLXgOZfJslyA1BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=YpUgGD1Jt2ftzBjBYSofYvQk5zqcyuwJ0PN7vNTpzzQJ//qCttcBmwEj8Sdixv3qM/8bTWw6GmQziJQvbUqOnSfZU67E0cMbVS30Nev0hma1/FEu9C1doRhsfT32E6GCN7J20qnoTsdf9xesccXiIYoxGrhjp9VSGLKPYZIaZ3U=
Received: by 10.114.66.2 with SMTP id o2mr5472100waa.102.1211059883760;
        Sat, 17 May 2008 14:31:23 -0700 (PDT)
Received: from localhost ( [71.197.245.84])
        by mx.google.com with ESMTPS id a8sm9693915poa.12.2008.05.17.14.31.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 May 2008 14:31:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82366>

* On 2008-05-05 at 08:21 +1200 Toby Allsopp wrote:
> I do something similar using git filter-branch --msg-filter.  I have a
> little shell script call git-add-checked (our convention is to have a
> "checked: " line in the commit message):

That's a useful script, thanks for posting it.  I'd like to make it a
bit safer to use -- the first time I tried it I didn't give any branch
limiting args and it started filtering a lot of history :-P

What I would like is a way for the script to determine the appropriate
tracking branch.  So that the usage would look like:

   git mark-reviewed someone@userprimary.net

and it would figure out whether it should do trunk.. or release-1.3..,
etc.  Can anyone point me in the right direction?


-- 
Seth Falcon | http://userprimary.net/user/
