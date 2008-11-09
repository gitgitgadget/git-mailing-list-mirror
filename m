From: Deskin Miller <deskinm@umich.edu>
Subject: Re: force a merge conflict
Date: Sun, 9 Nov 2008 15:35:26 -0500
Message-ID: <20081109203526.GB18415@euler>
References: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com> <20081109183917.GA18415@euler> <81bfc67a0811091219t393ab1faj8d1c4df6de3c260c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 21:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzH1e-0003zL-JP
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 21:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbYKIUfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 15:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756714AbYKIUfd
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 15:35:33 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:1900 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681AbYKIUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 15:35:32 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1255166qwe.37
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 12:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=bVhzts01aeJKw99o9v40MMfhADL2CBQrI7AqdaxaWbE=;
        b=SkZ8bTNJoPHR8n47ybuGsiadxAF/VQYp/lBJJ0bblfY9K8GugcwaeMr0xW2v5UwBFe
         h3DE7L93NpMl7qb8qpjrif3GoLwxCNvNWXESGM0hQBqK9mBavXVovAOGI0s/Xh2q8jY8
         hTUfMEyaTXbvJkQQRNRf1ChuMJXaKz/OEtY3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=u+YYDzW0sD27XLFpxbGj4eB4cbjo6gqaQsPhCHRs+1e8U+btUPk9yuFu+mvYYrM433
         f3YjGeV234Mk/UeTZ3mkxXZzUXtNumLKZwL9SrK6ZZjalQXK+to5wGBR8/IJht4Z1ep/
         egykcc0JywuzyuVmMiXVPUxgUrp3CAItBlFiE=
Received: by 10.214.183.8 with SMTP id g8mr5875972qaf.198.1226262930780;
        Sun, 09 Nov 2008 12:35:30 -0800 (PST)
Received: from euler ([152.160.57.162])
        by mx.google.com with ESMTPS id 30sm6866512yxk.4.2008.11.09.12.35.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 12:35:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <81bfc67a0811091219t393ab1faj8d1c4df6de3c260c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100469>

On Sun, Nov 09, 2008 at 03:19:57PM -0500, Caleb Cushing wrote:
> > I'm not sure a 'conflict' is what you want, based on what you say below;
> >  rather, it seems you simply want to force a 'merge commit', i.e. a commit with
> >  multiple parents.
> 
> >
> > git merge --no-ff ?
> >
> I tried that but I don't see that it's any different than a fast
> forward in this scenario. Actually I don't see any difference between
> it and a fast-forward.

Look at the results of 'git merge' and 'git merge --no-ff' in gitk.  Or,
compare the resultant sha1 for the two commit objects.  Or, look at 'git log'
of the resulting commit objects, and look for a 'Merge:' line.

Deskin Miller
