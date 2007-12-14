From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGIT: "stg refresh -e/--edit" to refresh patch and edit description no longer works
Date: Fri, 14 Dec 2007 17:01:42 +0100
Message-ID: <200712141701.43914.jnareb@gmail.com>
References: <200712141507.01552.jnareb@gmail.com> <b0943d9e0712140626w3a2f55b1i83c33f93d7f8af2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 17:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3CzM-0000R0-O1
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 17:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039AbXLNQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbXLNQBu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 11:01:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:31814 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756046AbXLNQBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 11:01:49 -0500
Received: by nf-out-0910.google.com with SMTP id g13so962242nfb.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=wXOcNec2Vzxa3MPWQPobjkA8PJR2e7uBme4xUJJfajc=;
        b=xAZ5gl2J+qJrFjDzhrqEX3/pMKHHmuxGZxFIpxoEp5kZJpHLsEUlhhzjs+wG5CmLaXUqIhdN+Hu96qMPwJMrMAIHvMkTeqbxQejvPqSY4FvjNvgV8XgxidLuWyuihvyeEFgj6QfP0jkiYnf9nPk8PZ9Fdc2zXHm/eMPL8TCSrMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FrZsYSbOlGom5LB1msa4/qSCdmTf3UeNULYUnvS83xaNVDjWCtg0Sr3+cUWK6PLFpFkFq4/J8VmauDV/YEsBujkpi8/2r5pzW7SlsGRg9DfL4zb6PzKXAn1XgtxdNeJJwbRUAqU9ags9cXbsMMbOVqHOrIWqWymikye8pIofmkE=
Received: by 10.86.89.4 with SMTP id m4mr3139178fgb.45.1197648107413;
        Fri, 14 Dec 2007 08:01:47 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.223.189])
        by mx.google.com with ESMTPS id 12sm1915703fgg.2007.12.14.08.01.45
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 08:01:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0712140626w3a2f55b1i83c33f93d7f8af2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68312>

On Fri, 14 Dec 2007, Catalin Marinas wrote:
> On 14/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> The command I used quite often in my StGIT workflow, namely
>> "stg refresh -e", which used to refresh patch and launch editor to edit
>> commit (patch) description no longer works in Stacked GIT 0.14.1.
>>
>> I used it when new (refreshed) changes needed also changes in commit
>> description (commit message). Now I have to run two commands:
>> "stg refresh" and "stg edit".
> 
> Well, people complained that 'refresh -e' is misleading and a separate
> command is needed. It's not difficult to move the editing
> functionality out of stgit.commands.edit and re-add the --edit option
> to refresh (while also keeping the separate edit command).

First, the "misleading" part could be corrected by renaming long option
to --edit-description or --edit-message. Second "stg refresh -e" matches
non-StGIT usage of "git commit --amend"; and it is damn useful to have
it as one command, not two. 

> I'm a bit busy with home/family commitments until the new year.

I'll wait. As I am not running StGIT master, but released version,
I would have to waith nevertheless on next release.

TIA
-- 
Jakub Narebski
Poland
