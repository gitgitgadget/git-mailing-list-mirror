From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-svn and logging.. new to git
Date: Wed, 05 Mar 2008 13:02:42 -0800 (PST)
Message-ID: <m3ir00hoj9.fsf@localhost.localdomain>
References: <fqloop$ll$1@ger.gmane.org>
	<ee77f5c20803050401o7f33522dj6dd0f0f1c0a78f96@mail.gmail.com>
	<fqmg8v$rmm$1@ger.gmane.org>
	<ee77f5c20803051237y571efa54nc80f157015859cc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>,
	git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0m0-0000ku-Iv
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760036AbYCEVCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755211AbYCEVCq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:02:46 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:7561 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYCEVCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:02:45 -0500
Received: by el-out-1112.google.com with SMTP id v27so2375704ele.17
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=4ZUmhm59rda/vWNiDqnjoErUk1vkM5KLjPyy9eZVgOM=;
        b=xyiPIUiHPXYfR3h986vwkEMAIatu9JNQLPNPtycThtuG2SKlclI0V1moCsun8W7EhmQHYN0ufNkI6cTkLsqAkMc5yYQmY19bkLKULpuL3kGoSAh3v52yrs/NRB5DCG20CpfklXkdRVv0xbnRi6Z3/862nLuB2fKSINdcBIV+I2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=g5wZOKR+zX6fy6WyRKvh41cZqI6GYCy8m42p9FCQhh2FWBvFznEXTRs706PvDNKA7h4nq9FhqcNaV7fH3cvPvKpX+9824MfDyqoJUR8GUkkgdMApg6x96lM69HLRpfEy/7RFa3aEZ5p2L3ErX6N/hz5cQVbza0jXbEV8SJ2o4uI=
Received: by 10.114.135.1 with SMTP id i1mr5338231wad.88.1204750963128;
        Wed, 05 Mar 2008 13:02:43 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.32])
        by mx.google.com with ESMTPS id o1sm4101515uge.1.2008.03.05.13.02.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 13:02:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m25L3815025842;
	Wed, 5 Mar 2008 22:03:08 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m25L36qe025839;
	Wed, 5 Mar 2008 22:03:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ee77f5c20803051237y571efa54nc80f157015859cc6@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76265>

"David Symonds" <dsymonds@gmail.com> writes:

> On Thu, Mar 6, 2008 at 3:03 AM, Kenneth P. Turvey
> <kt-usenet@squeakydolphin.com> wrote:
> > On Wed, 05 Mar 2008 23:01:34 +1100, David Symonds wrote:
> >
> >
> > > git-svn creates a whole bunch of remote branches -- does "git branch
> > > -a" show them up?
> > >
> > > Also, you can probably leave out the --trunk, etc., and just use
> > > --stdlayout.
> >
> >
> >
> > Thanks.  That's good information to have.  Is there a way to just do a
> >  straight import like in svnimport?  Is svnimport still available
> >  somewhere or has it been completely superseded by git-svn?
> 
> I believe git-svn completely replaces svnimport. Check the git-svn
> manpage, which is quite extensive.

You can find git-svnimport in contrib/examples/. 

git-svn has more features, and git-svnimport is no longer maintaned.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
