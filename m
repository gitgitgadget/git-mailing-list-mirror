From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 4 Mar 2007 13:40:57 +0100
Message-ID: <e5bfff550703040440q45b58e63pb24f17e4a1b10e31@mail.gmail.com>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	 <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 13:41:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNq1b-0000VS-5u
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 13:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbXCDMk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 07:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbXCDMk7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 07:40:59 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:29775 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbXCDMk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 07:40:58 -0500
Received: by wr-out-0506.google.com with SMTP id 37so985512wra
        for <git@vger.kernel.org>; Sun, 04 Mar 2007 04:40:58 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HnefNnv8XGhtuyfYNsbdOw+K0uUH+Kjb4vpCGpEI8dt81ezBFUEPnLM5rOz0cMY+Bvt0LhucbLDgb0EHxsPYE+eSuPsinEjj+RpZB2Q9aWDFDXZKrHIg2olpfehmP/OeN1zTcxjiNPD8vJRjP+03f5zrdzhQrmR7F6Q8ThBMOqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5kBViMXP4vMzpm9T4ihV2UgFyZY2d/+pPR3G+dShOH70YBiW0Pt/5Lhi1DINEUxLwnlaC5K/Vj0ZQ27DrAS1BoVnzCP9a0nbCKJL8lpqLHnTxDWfzdYm5N/8aC6YiU06L/+L3MUy1lQhdudIkwd9r+3wDmTheI4407RojdbaDg=
Received: by 10.114.169.2 with SMTP id r2mr936792wae.1173012057822;
        Sun, 04 Mar 2007 04:40:57 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 4 Mar 2007 04:40:57 -0800 (PST)
In-Reply-To: <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41357>

On 3/4/07, Junio C Hamano <junkio@cox.net> wrote:
>
> * jc/status (Thu Feb 22 02:07:56 2007 -0800) 2 commits
>  - git-status: use in-core --refresh in a read-only repository.
>  - git-runstatus --refresh
>
> These two were done for the specific purpose of helping qgit,
> but I haven't heard about them, so they are on hold.  If they
> are not needed by qgit nor people who like to run git-status in
> a read-only repository, I do not see any reason to keep them.
>

Currently they are not needed by qgit. Probably neither in the future.
It is better to keep working dir view disabled if in a read-only repo
then wait for a sloooow command to return incorrect data (BTW _all_
repo files are always marked as 'modified' due to an issue with
different implementations of lstat in cygwin and ntfs kernel driver).
