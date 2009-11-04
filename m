From: demerphq <demerphq@gmail.com>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare 
	repos
Date: Wed, 4 Nov 2009 18:15:17 +0100
Message-ID: <9b18b3110911040915q1dfa5a4bk18087d93a00f4cf5@mail.gmail.com>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
	 <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
	 <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5jSC-0002k9-C8
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 18:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbZKDRPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 12:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757293AbZKDRPO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 12:15:14 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:59690 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246AbZKDRPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 12:15:13 -0500
Received: by ewy3 with SMTP id 3so3319736ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NUtgZwKzSxacaN3+Kt9P9ciNebFmZWfMHXgiVOIK2DM=;
        b=jI8J0qMercHBAznLCMohjwlwGq+jIszDnyaKOjE0tmlBUVV8EQE8eLUa/ThLh9RsPQ
         7ahxSlRMJXXQ2/Vh4urmKmMPjbxrTUm+yufTuhlQTSCRpdRcnR1pdLRbdEH/9gBoSUjK
         4TZag3Gy//xSsxIWIeXRGxQCzRgzex5GSTkc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VV6iXrwbD4EwLkHR9pZPRl5S2LReMyNnZgX1w3fbun5rp0fsrl3j/Ll8iJKT9VfwnR
         SjuHfakOF7AClk10uxKNtuKZD6pFh81KB4ozJ7eyqqkY5s5c+F+BuysUL2lGPPmYZosW
         aUsoxakBW36ZnwvLW7Pz/2dW742bBQl/n6lcc=
Received: by 10.216.90.81 with SMTP id d59mr576885wef.29.1257354917801; Wed, 
	04 Nov 2009 09:15:17 -0800 (PST)
In-Reply-To: <2e24e5b90911040841l7741787et48fabb8c8066e946@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132097>

2009/11/4 Sitaram Chamarty <sitaramc@gmail.com>:
> Hi Johannes,
>
> On Wed, Nov 4, 2009 at 6:55 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
>> I did not have time yet to investigate, but it seems that there are
>> problems with the permissions of shared bare repositories when activating
>> the reflogs.
>
> Interesting; I will try and investigate if I can find something.

Assuming you mean via ssh access then if there is we haven't noticed
the problems at $work, and we have had this setup from the first time
somebody did a forced push and broke things, which was like day 3 or
something of our switchover to git from cvs, which is about two years
ago.

IMO it would be nice if the reflog could be set to ONLY record forced
updates. This would make a lot of sense on a bare repo.

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
