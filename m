From: Sam Granieri Jr <sjgdev@gmail.com>
Subject: Re: [Feature Request] Better Subversion integration
Date: Mon, 11 Feb 2008 10:55:37 -0600
Message-ID: <E947A49F-4A4C-43F5-8E22-FFAF008E0B82@gmail.com>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet> <20080211084704.GB20741@albany.tokkee.org>
Mime-Version: 1.0 (Apple Message framework v919.1)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Sebastian Harl <sh@tokkee.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:57:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObxX-0007oZ-5n
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759417AbYBKQzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 11:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759411AbYBKQzq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:55:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:13089 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759375AbYBKQzo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 11:55:44 -0500
Received: by wr-out-0506.google.com with SMTP id c48so4081754wra.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=zzhWn1Qf6o6yQXZ06zOj+HkS9dZ6QFzCWwNxaki3DM8=;
        b=AqcEu/Djvxatj8tEpOh2XbPNITAXAxjVnj5YVjxjkenEy7AYkES6na/U2VeFE61nIb8Iiz3PZ+UVdq5ZUxXQCrR/ILb7YTLkc88KM06HzwW/NoZqVgWT7qQm9UXMLQ+Lce23mfT8cKrICFrpAxekpEIqC5VjTF5KXFXPCh2XQuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=l2D+4fkArMhWxLL1c9CJlSEqeOLAqnkjz/C8XDi+ZzoOSvc4HfDdi6W0Bev6PB+2GVwHGjr/7ce8DoQcifnUsDAUb2Ooh+nBRA1pTlC0YyY3Jn/k3o5XfW8AQezGORWztIotakgFgue6dkZQa4egqlHjtNibkQafMGqY5u2QzRw=
Received: by 10.114.151.13 with SMTP id y13mr219300wad.60.1202748941448;
        Mon, 11 Feb 2008 08:55:41 -0800 (PST)
Received: from ?10.136.11.83? ( [216.21.36.75])
        by mx.google.com with ESMTPS id f14sm14723460qba.25.2008.02.11.08.55.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 08:55:40 -0800 (PST)
In-Reply-To: <20080211084704.GB20741@albany.tokkee.org>
X-Mailer: Apple Mail (2.919.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73553>

Sebastian,
I think you have the right idea.
One last question
If a person wants to work on a tag branch, would the right idea be to =20
create new branch on it as to not screw up the previous tag?

On Feb 11, 2008, at 2:47 AM, Sebastian Harl wrote:

> Hi,
>
> On Sun, Feb 10, 2008 at 04:56:11AM +0100, Bj=F6rn Steinbrink wrote:
>> On 2008.02.09 20:44:59 -0600, Sam Granieri Jr wrote:
>>> Right now, git-svn import (or clone) will convert tags and =20
>>> branches as
>>> remote branches.
>>> I would like it if git could pick up subversion tags and translate =
=20
>>> them
>>> as git tags upon importing
>>
>> SVN tags aren't like git tags. A "tag" in SVN is just another =20
>> directory,
>> which you can modify at will.
>
> Well, a SVN tag could be represented as a Git branch _and_ a Git tag
> pointing to the head of that branch. Whenever any such "tag branch"
> advances, the user should be notified, the user responsible for the
> further commits to the SVN "tag" should be seriously hurt and the Git
> tag should be overwritten (git tag -f).
>
> Sam, is that basically what you want?
>
> Cheers,
> Sebastian
>
> --=20
> Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://=20
> tokkee.org/
>
> Those who would give up Essential Liberty to purchase a little =20
> Temporary
> Safety, deserve neither Liberty nor Safety.         -- Benjamin =20
> Franklin
>
