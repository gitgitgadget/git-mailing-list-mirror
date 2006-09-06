From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git.kernel.org not putting out or git-daemon bug?
Date: Wed, 6 Sep 2006 20:17:46 +0200
Message-ID: <e5bfff550609061117p4613094of3a70d42d55f0250@mail.gmail.com>
References: <44FEC6BE.5060301@op5.se> <44FEC9D6.3030105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 20:18:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL1yJ-0007B7-8R
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 20:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWIFSR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 14:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIFSR4
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 14:17:56 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:48588 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751493AbWIFSRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 14:17:55 -0400
Received: by py-out-1112.google.com with SMTP id n25so3766889pyg
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 11:17:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cBE4tazEAJKznOftzFtWEHk8unNAD/2/vulvPuIC+70yAOB9jObUCD5Zsv21e1IeBh4KzXv+/xNQJmg86250mgzZrql3Rm52nEHmZzTmnD+OtIj0a919NWgrKYfyMnmYNw5t+0bPaAiry3sOKUUy786p/9G/A9AtCLzy2BNhv/M=
Received: by 10.35.108.12 with SMTP id k12mr15232283pym;
        Wed, 06 Sep 2006 11:17:51 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Wed, 6 Sep 2006 11:17:46 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <44FEC9D6.3030105@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26546>

On 9/6/06, Andreas Ericsson <ae@op5.se> wrote:
> Andreas Ericsson wrote:
> > Is it just me, or is anyone else having problems 'git fetch'-ing from
> > git.kernel.org? I've been trying on and off for two hours now, but keep
> > getting
> >
> > fatal: unexpected EOF
> > Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> >
> > Around 10 o'clock GMT I got a couple of timeouts, but I haven't seen one
> > of those for several hours now.
> >
> > Using git version 1.4.2.ga444 to do the fetching, and trying to pull
> > things on to a clone of that revision of the git repo.
> >
>
> Fetch over rsync seems to work fine, but git version 1.4.2.g8f5d has no
> better luck fetching over the git-protocol.
>

gitweb it's also veeeery slow to update. I've pushed a patch to qgit
repository more then one hour ago and still http://kernel.org/git/ is
not updated.

It's not the first time gitweb takes time to update, but never more
then one hour!

Also the http://kernel.org/git/ page refresh is very slow and is
getting slower each week more. Unfortunately I have no quantitative
data on it, but my impression is that there is a drift in response
times in the last months.
