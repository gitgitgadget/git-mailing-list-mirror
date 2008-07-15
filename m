From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: applying and committing patches in a single git command
Date: Tue, 15 Jul 2008 12:46:18 +0300
Message-ID: <ce513bcc0807150246g790ca009vc0a76bd6ef0aac9b@mail.gmail.com>
References: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
	 <487C659E.60606@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Boaz Harrosh" <bharrosh@panasas.com>, s-beyer@gmx.net
X-From: git-owner@vger.kernel.org Tue Jul 15 11:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIh7w-000783-5b
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 11:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbYGOJqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 05:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYGOJqT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 05:46:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:44639 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYGOJqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 05:46:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5907433rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=osNxF2XQlKHbl9UCdTjvYVZ9vD1Tgtmi8oeROaS+mxg=;
        b=u00PEil/kYKkylZ5JCBHyeeQqubzhmZCrOd1EtWsBo0VYBSuvz9Ng4O8F8mqVV0Xqb
         3hXZGJ5ICADh+Kz9RFvX9I2u1YXxREXlO+8SYmhnFaOLEihKMAIuNJqKeDS0C1R6ATK/
         LjPjChQZP8sulqT+i+o+sIudnvIfbhOs34JY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NQ2KeriwBwdXbjzsdz51UoiP9ETjJ+dCQSVYzH4aM7tzcD93y6+A+Tj5fReaBxtyro
         v/Xf8MlgJoDhqrPg+Jx5D3YLi5nUDT62YcAoAMeuO5To1l0elPrKnEFmvNcYLjo0qpWb
         WmyZpb3FSIxwZSHnP2Ouaka4Wqje8bN11rzwY=
Received: by 10.141.89.13 with SMTP id r13mr7275506rvl.88.1216115178415;
        Tue, 15 Jul 2008 02:46:18 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 15 Jul 2008 02:46:18 -0700 (PDT)
In-Reply-To: <487C659E.60606@panasas.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88546>

On Tue, Jul 15, 2008 at 11:53 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> Erez Zilber wrote:
>> Hi,
>>
>> Someone created a patch with git-format-patch and sent it to me. I
>> would like to apply & commit the patch. If I use git-apply, it only
>> patches my tree without committing it. Now, I need to copy the commit
>> log, run git-commit and paste the commit log there. Is there a more
>> intelligent way to do that?
>>
>> Thanks,
>> Erez
>>
> git-am, can take all bunch of them at once
>
> Boaz
>

Thanks. I have 2 more questions:
1. How can I tell git-am to take a patch from an e-mail from a gmail account?
2. If I have the actual patch on my machine (not in an e-mail
message), I guess that I need something else (not git-am). Is there
anything like that?

Thanks,
Erez
