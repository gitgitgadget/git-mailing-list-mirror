From: Olivier Delalleau <shish@keba.be>
Subject: Re: Suggestion: add option in git-p4 to preserve user in Git repository
Date: Sat, 12 Jan 2013 14:44:49 -0500
Message-ID: <CAFXk4bpM8X3k=iwRjM9kvm4XbZyKS+hTCiVbHOjH3jK6MkkBSg@mail.gmail.com>
References: <CAFXk4bpQo26sAfHkE5_VLi_UkZcgsYvwYNH8byZjuXs=EAhu+A@mail.gmail.com>
	<20130112163838.GA28722@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu70x-0007IM-7m
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab3ALTov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:44:51 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47871 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab3ALTou (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:44:50 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2866319oag.5
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=/aVXjbMZGexAqNKD5L7L8Kf/lUnPQNOmWIEcB/y9l3s=;
        b=P4qVKQAotWgy5GmN5jOKX1SpNWgHR/50HXVSqsFLWypKH9EYZLmaA9cpkNlRlcZys0
         8pXD2BmpIQEdbN98aBkn9rbZBP5Rz7Z8egjVJwL17PRve/iSTe0/VrQvDqX8NVOluc7+
         rqugR4iib/jaI2jkgvUbNr1ZROOSs/TCr9yc2PHqmCPJkxbme8erkEfFBQlEXVmgL6FN
         m1VvLItRdUejUNWtLiKLuBucemWNItm1iADJ4HDyXYH/u/HAAE3H5PrxvVHpNQ9t0d/7
         8yYOKfTrZISL69unZMUL4dXYAYzY+i966QYTviOyON1QlyM+p7oKFlgPDPMebDmRD4CT
         2i8g==
Received: by 10.60.1.232 with SMTP id 8mr47192845oep.30.1358019890214; Sat, 12
 Jan 2013 11:44:50 -0800 (PST)
Received: by 10.76.28.69 with HTTP; Sat, 12 Jan 2013 11:44:49 -0800 (PST)
In-Reply-To: <20130112163838.GA28722@padd.com>
X-Google-Sender-Auth: uHW9h5wWB4eP0pcSeqeC-_J5Xa0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213310>

2013/1/12 Pete Wyckoff <pw@padd.com>:
> shish@keba.be wrote on Thu, 10 Jan 2013 22:38 -0500:
>> I'm in a situation where I don't have P4 admin rights to use the
>> --preserve-user option of git-p4. However, I would like to keep user
>> information in the associated Git branch.
>>
>> Would it be possible to add an option for this?
>
> The --preserve-user option is used to submit somebody else's work
> from git to p4.  It does "p4 change -f" to edit the author of the
> change after it has been submitted to p4.  P4 requires admin
> privileges to do that.
>
> Changes that are imported _from_ p4 to git do have the correct
> author information.
>
> Can you explain a bit more what you're looking for?
>
>                 -- Pete

Hi,

Sorry I wasn't clear enough. When "git p4 submit" submits changes from
Git to P4, it also edits the Git history and replaces the Git commits'
authors by the information from the Perforce account submitting the
changes. The advantage is that both the P4 and Git repositories share
the same author information, but in my case I would like to keep in
the Git repository the original authors (because the P4 account I'm
using to submit to P4 is shared by all Git users).

Hope it makes more sense now :)

-=- Olivier
