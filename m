From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 23:42:44 +0100
Message-ID: <200711132342.45280.jnareb@gmail.com>
References: <874pfq9q8s.fsf@osv.gnss.ru> <473A027E.5000107@op5.se> <473A262B.4010205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, Sergei Organov <osv@javad.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4TP-0000oG-4j
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbXKMWmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 17:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757098AbXKMWmx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 17:42:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:13377 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371AbXKMWmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 17:42:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so203711ugc
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IX9jvbYky+2bwoNFKoEJ4aeJuZYnAV3rv78jL8hc+LM=;
        b=PHSBaaJU+IfHDXlGKzTqho6Pr68CjUgvHG9Y74Z1PNfU9wjbr7ocmhCZN453yHkjBNHXAAYjSBOqpXFTktL5WhUY83aa8hcwxI/CupdQZ5BnRQTc2I0RDJjybjGuC5dyXNHyyC0zqfsMJ1yZNj5F+AwMrIVglUGqBwOnFYJxfIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RBfgC6d3eRnjQ3O4v9bNg8xoM5OBOwP//Pa427m6C3OAx3NkCiUsA6xnWgNvgsWaqPSiz0zeFjWUZoOTEMdNcgve+rvV5Eqr9zhKFT5+/cleslaXp9J7wNIWl2wwuWA+upteg+Ov8DWI6Sw4QtcRUg70k1c9JGFdR14eSzJJ7Yk=
Received: by 10.66.243.2 with SMTP id q2mr456105ugh.1194993771142;
        Tue, 13 Nov 2007 14:42:51 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.6])
        by mx.google.com with ESMTPS id z37sm275981ikz.2007.11.13.14.42.49
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2007 14:42:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <473A262B.4010205@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64898>

Andreas Ericsson wrote:

> This is what I've got in Documentation/glossary.txt so far:
> 
> [[def_remote_tracking_branch]]remote-tracking branch:
>     A "remote-tracking branch" is a branch set up to track the
>     state of a branch in a remote repository which the user has named. 
>     These branches follow exactly the same rules as the branches which
>     reside in the remote repository, except that they are manipulated
>     by `git fetch` instead of `git push`. That is, they can only be
>     updated if the update would result in a 
>     <<def_fastforward,fast forward>>, or if the user supplies the 
>     '--force' option. 
>     They cannot be checked out or committed to by users, but serve
>     solely as local reference-pointers to their corresponding branches
>     in the remote repository.
>     The most common example of a remote-tracking branch is origin/master.

If user supplies '--force' option, ur uses '+<src>:<dst>' refspec
('+<remote branch>:<remote-tracking branch>').
 
> It's a bit long-winded. Anyone got any improvements?

Long winded is good. Well, long is good.


I would add that remote-tracking branches reside in refs/remotes/<remote>.

I would skip the part about `git push`, and just say that they are
updated on fetch (`git fetch` or `git pull`).

-- 
Jakub Narebski
Poland
