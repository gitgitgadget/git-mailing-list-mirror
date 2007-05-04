From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [tools-dev] Re: Git benchmarks at OpenOffice.org wiki
Date: Fri, 4 May 2007 02:48:22 +0200
Message-ID: <200705040248.22443.jnareb@gmail.com>
References: <200705012346.14997.jnareb@gmail.com> <200705030130.44018.jnareb@gmail.com> <200705031351.40548.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: dev@tools.openoffice.org, git@vger.kernel.org
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 04 02:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjlv8-0007VI-JX
	for gcvg-git@gmane.org; Fri, 04 May 2007 02:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767556AbXEDAoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 20:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767558AbXEDAoH
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 20:44:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:21674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767555AbXEDAoC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 20:44:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so561361uga
        for <git@vger.kernel.org>; Thu, 03 May 2007 17:44:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ENFwRQsV7vbeHfatHr5AP4wQUz+zUNP/oXe2fWdxcOAdVDs5C/3Z9pS8zQlEHqmtaMpG2GJ/WgGN5ImGLzkwQl2MUC7I0FOicQcnubEIFvnLK9zXbXW/BbfywR4/RsPIVjclldwDC7P42QAwDrBW2q1aYxtQGaqRT54hFIxkO0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H176RCTUWIFf4k9JuOVCOVn1WZaszhAm5+aGnpEhAVFkgG8aL/0hIaQuNGyPdY2+Q1qBXfDwbYOEQwslWN3timkHuYprgQNCb8oN6ysTBNt89rVk5CIOTzJHor8diZIr9Pmx2jYz+HOHxdU8aTNSg+9JjuqTkicd9KxUbaHlyuI=
Received: by 10.66.237.9 with SMTP id k9mr2270458ugh.1178239441573;
        Thu, 03 May 2007 17:44:01 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id o24sm4434083ugd.2007.05.03.17.43.59;
        Thu, 03 May 2007 17:44:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200705031351.40548.kendy@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46126>

On Thu, May 02, 2007, Jan Holesovsky wrote:
> On Thursday 03 May 2007 01:30, Jakub Narebski wrote:

>>> We should better split the OOo sources; it's a process that already
>>> started [UNO runtime environment vs. OOo without URE], and I proposed
>>> some more changes already.
>>
>> In my opinion each submodule should be able to compile and test by
>> itself. You can go X.Org route with splitting sources into modules...
> 
> Indeed, this is the case of URE - it is supposed to run by separately & be 
> used even by other projects than OOo.
> 
>> or you can make use of the new submodules support (currently plumbing
>> level, i.e. low level commands), aka. gitlinks.
> 
> And this would be interesting for the translations, I guess...
> 
>> The submodules support makes it possible to split sources into
>> independent modules (parts), which can be developed independently,
>> and which you can download (clone, fetch) or not, while making it
>> possible to bind it all together into one superproject.

By the way, even without submodule support, which for now is plumbing
level only, it would be possible to pull separate subprojects into main
project, like git repository does now with gitk repository, and with
git-gui repository. The latter is merged putting git-gui files in separate
directory in git.git repository, via using 'subtree' merge strategy.

Submodules / subprojects are something similar to Subversion svn:externals
done right.

-- 
Jakub Narebski
Poland
