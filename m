From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 04:06:38 +0200
Message-ID: <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 04:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkVeP-0000CR-71
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 04:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbXJXCGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 22:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbXJXCGl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 22:06:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:47216 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbXJXCGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 22:06:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so55207wah
        for <git@vger.kernel.org>; Tue, 23 Oct 2007 19:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3/yJHjpa1hBrrnmv1h9WuWQihgmAHVFLT4POBgUaBD8=;
        b=tlwn7NxoF8Bk6uMgbo/lWdy9sWZbQXEBN+hrQ9tvCFz71shvRwoPgDJhGKxy1/6Cz+aPj5Y1QKVkFqkJfyhBaZNYgg5lE/CGDrOHyxJW+SusBKfoT+gHyPWT0D8+NS1PoaJtOIeThT9P30y2S9qiBA4UHbCLcIPCMUSLpj/0P78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pQrztcwR6DFM7SGi1KTCTyT4/DXuO7pth7x1F4wPIgSwh6gmBSuZgwnzW9T4dOcIdovfETGCgWPvMDjpBKAMR6seG3aeGpX3KO5zXUBTApE8FfPDXYNtDmOtWkNBEqFPocK2RXlWR+X3U4Axz0IP0I/nyBn0+EIIU9AqFvE7RGQ=
Received: by 10.114.89.1 with SMTP id m1mr75087wab.1193191599056;
        Tue, 23 Oct 2007 19:06:39 -0700 (PDT)
Received: by 10.114.160.12 with HTTP; Tue, 23 Oct 2007 19:06:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710221156540.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62183>

On 10/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> So once again, what operations involving git do people use regularly?
>
> <rationale>There is a good chance that git is not optimised for most
> people's daily workflows, as project maintainers seemed to be much more
> forthcoming with patches, and therefore maintainers' tasks are much more
> optimised than in other SCMs.</rationale>

For working on gitweb in git.git repository.
1. Fetch (when I am on topic branch) or pull (in rare cases I am on master)
2. "stg rebase origin"
3. work, work, work, using StGIT to generate perfect patch series
(going back and forth between patches, reordering patches, adding
patch in the middle of series, concatenating two patches, etc.; for
example when I notice that something should be changed in previous
patch, be it either bug noticed just now, or change in preparatory
patch to better suit main one)
4. fetch and rebase just between publishing
5. git format-patch to generate patch series; use git-shortlog or
grepping for patches subjects and git-diff --stat to generate
introductory email. Unfortunately StGIT template for introductory
email does have neither shortlog nor diffstat fields to atomatically
fill. Add comments to patches if needed.
6. Either use KMail + attach inline (no word wrap), or git-send-mail
(with sendmail configured to use gmail account; now I could use simply
git-send-mail configuration in user config) to send patches to git
mailing list
7. Push changes (if I don't forget) to repo.or.cz repository (jnareb-git.git).

-- 
Jakub Narebski
