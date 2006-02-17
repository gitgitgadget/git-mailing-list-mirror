From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: stGIT: commit vs export vs mail
Date: Fri, 17 Feb 2006 22:12:33 +0000
Message-ID: <43F64A51.10607@gmail.com>
References: <Pine.WNT.4.63.0602171139020.3052@jbrandeb-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 23:12:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADqD-0001l6-K4
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 23:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWBQWMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 17:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWBQWMi
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 17:12:38 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:45112 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751474AbWBQWMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 17:12:37 -0500
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20060217221236.IVLW29066.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Fri, 17 Feb 2006 22:12:36 +0000
Received: from [192.168.1.101] (really [86.15.186.141])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20060217221236.ZVEH20103.aamta09-winn.ispmail.ntl.com@[192.168.1.101]>;
          Fri, 17 Feb 2006 22:12:36 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <Pine.WNT.4.63.0602171139020.3052@jbrandeb-desk.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16373>

Jesse Brandeburg wrote:
> So I am using stgit .8 right now, and I'm having a hard time figuring
> out what the correct workflow should be for using stg and then
> committing a change
> 
> Here is what I've been doing:
> stg new test
>  enter my short description on first line
>  enter my long description on next lines.
> vi file
> stg refresh
> stg mail <blah blah blah>
> or
> stg commit

There is no "or" above but only "and maybe". The 'commit' command is
only used to permanently store a set of patches into the repository.
After that, you should not be able to change them anymore (well, someone
just sent me a patch for an uncommit command). I only use this command
when I work in the "maintainer" mode on StGIT. For contributing patches,
you shouldn't need it since the base of the stack should usually be
identical to the HEAD of the remote repository.

> Problem that I'm having right now is that the templates do the right
> thing for mail, but, the commit only puts in the "enter my..." text.

I don't fully understand this. Where does commit put the "enter my..." text?

> Is there a template based way to automatically append the author in the
> Signed-off-by: line when i do stg commit?

This can only be done when creating a patch. Commit doesn't modify the
patches. I think you slightly misunderstood the commit command.

Catalin
