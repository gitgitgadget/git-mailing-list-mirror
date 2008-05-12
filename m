From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 11:54:15 -0700 (PDT)
Message-ID: <m38wyf4als.fsf@localhost.localdomain>
References: <4827DEF6.1050005@gmail.com>
	<87ej87is50.fsf@offby1.atm01.sea.blarg.net>
	<alpine.DEB.1.00.0805121428310.30431@racer>
	<48285087.3090402@gmail.com>
	<alpine.DEB.1.00.0805121606010.30431@racer>
	<20080512152731.GM31039@zakalwe.fi>
	<alpine.DEB.1.00.0805121804500.30431@racer>
	<20080512180720.GN31039@zakalwe.fi>
	<alpine.DEB.1.00.0805121920120.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heikki Orsila <shdl@zakalwe.fi>, bill lam <cbill.lam@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 12 20:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdAz-0001l6-Qs
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbYELSyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbYELSyV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:54:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:62950 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbYELSyT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:54:19 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1131632nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=n6tAtNX4mFhr7UsKSMuD76Gpqu6oLP3crhxkO6lO77k=;
        b=j//QoqGSX+IJbkNm+Ri7lf+jNJZa7k+UEImaDF4g3q1JIFp4oL2bYbYAHH7kLR26zZM/MUDn+JQRoSwieh+atCCjGUPR8WAP2JH3lrLG06tRYebmPjHzih/ymtcoEIFVLOLZpK7jJPHdWDuIjbqKm9HO6VhPEX4hDtne04RIIYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=rBwcwFA7VoA0hNto99Z3XWNEqD0/OnV/goSpTYROe7xR7mPDvDkmB0g8cvA2hz3Qp6qrd22Yg9WEmhPB+rnOpLcCj3I+NVtD/0Qt+nPGXl+H44cDLQ91Na0Tnl7RkMaBkQJ1I6JAJQqEt/3LiWa34qQkGoN54NiSfQlcleQs9es=
Received: by 10.210.66.1 with SMTP id o1mr7515972eba.135.1210618457072;
        Mon, 12 May 2008 11:54:17 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.115])
        by mx.google.com with ESMTPS id c22sm11120632ika.1.2008.05.12.11.54.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 11:54:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4CIsAgJ014053;
	Mon, 12 May 2008 20:54:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4CIs79A014050;
	Mon, 12 May 2008 20:54:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0805121920120.30431@racer>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81904>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 12 May 2008, Heikki Orsila wrote:
> 
>> On Mon, May 12, 2008 at 06:07:28PM +0100, Johannes Schindelin wrote:
>> 
>>> On Mon, 12 May 2008, Heikki Orsila wrote:
 
>>>> Is there a simple and efficient mechanism for incremental backups?
>>> 
>>> Umm.  "git fetch"?
>>> 
>>> Like I said, it does not get the reflogs, but if you want to back up a 
>>> repository, the safest is to clone once, and fetch later.  Or you 
>>> could set up a remote with the --mirror option, if you want to 
>>> preserve the refs' namespaces.
>> 
>> Preferably some solution that does not require too much understanding of 
>> Git internals so that admins will actually use it, instead of hacking 
>> their own inefficient backup scripts.
>> 
>> Could someone please write a "git-backup" script?-)
> 
> Heikki, why don't you just go with the "git fetch" approach I described?  
> We do not need "git backup" when "git fetch" does already what you want.

I think that bundles (see git-bundle) would be what you want (please
read GitFaq/GitTips/"Git in Nutshell" for explanation and use cases).

"git fetch" (perhaps using bundle) would save state of refs (heads,
remote branches, tags) and object repository.  To save state of
working area and index I think it would be best to use 'git-stash'
before creating backup, and unstash after it; see documentation for
git-stash.  What is left is: reflogs, configuration, hooks, grafts and
shallow, repository local excludes file, repository local attributes
file[*1*].

[*1*] Which is not mentioned in Documentation/repository-layout.txt
-- 
Jakub Narebski
Poland
ShadeHawk on #git
