From: "David J. Neu" <davidjneu@gmail.com>
Subject: Re: git-checkout question
Date: Sun, 13 Jan 2008 10:12:02 -0500
Message-ID: <20080113151202.GC10426@bach.davidneu.local>
References: <20080113142140.GB10426@bach.davidneu.local> <AF05EA04-C41A-4964-B225-E3A427D32E33@zib.de>
Reply-To: djneu@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 13 16:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE4Vo-0005Ca-9F
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 16:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbYAMPMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 10:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbYAMPMH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 10:12:07 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:32232 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYAMPMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 10:12:06 -0500
Received: by an-out-0708.google.com with SMTP id d31so371476and.103
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 07:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=+O/qs7shxsGA+t1soNwIKZsB59Ji32EPQDzxNtxviaA=;
        b=P5eQSq/5e7H+pjhM/hEBWynjcGnv9ml3lJie5posrVQBgy1z3bkCJJp+VLQKSiownUHGiYpke+yLzcI/e+XAbA7S6wqCd0Jciky/F3afNoHVy39n+dv+4zEHSGAiJzZ6MyCN4/eQduzp5l2nIfAwu0DnpWvOkO0Vqw0H6eddgG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hzAyv89gKI0eBA1NoRTeQz6vuXPRJNPS+mtRZelXL5MezEKsJ93gyUNvFLPQaiScfoTbh7lTpv0cLlGNKAr1HEeyKXabuwEF1kLFHLmXWFV9vxz0gyEOzOsGbQAHbBJ5yqkQ5AQibdvGPyZQsXFngZP+i3uSlpK1XMyXBJmTbU0=
Received: by 10.100.57.6 with SMTP id f6mr11690811ana.113.1200237125360;
        Sun, 13 Jan 2008 07:12:05 -0800 (PST)
Received: from localhost ( [75.69.180.181])
        by mx.google.com with ESMTPS id i49sm7012599rne.1.2008.01.13.07.12.03
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Jan 2008 07:12:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AF05EA04-C41A-4964-B225-E3A427D32E33@zib.de>
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70387>


On Sun, Jan 13, 2008 at 03:31:19PM +0100, Steffen Prohaska wrote:
> 
> On Jan 13, 2008, at 3:21 PM, David J. Neu wrote:
> 
> >I was wondering if someone could explain the following behavior.
> >
> >1. create and switch to branch off master
> >2. edit a file in the branch
> >3. checkout master without committing changes in the branch
> >4. the changes in the branch are automatically applied in working tree
> >   in master
> >
> >I wasn't expecting the changes in the branch to be automatically
> >moved to master.  Had I committed while in the branch this doesn't
> >happen.
> 
> This already is the explanation.  You did not commit.  Therefore,
> the changes are not in the branch but still in your work tree.
> They are on neither branch; they are _only_ in your work tree.
> If you switch the branch the changes will stay in the work tree.
> They always stayed in the same place: your work tree.
> 
> 	Steffen
> 

Ahh, got it - thanks!
