From: Manuel Doninger <manuel.doninger@googlemail.com>
Subject: Re: multiple group access to update repo
Date: Sun, 16 Jan 2011 13:27:48 +0100
Message-ID: <AANLkTikGHEz4YknOAH2hFQKjYOhsYocdNfUYUZW_8GVd@mail.gmail.com>
References: <igr99g$mca$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 13:28:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeRiT-0008TH-Qz
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 13:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab1APM2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Jan 2011 07:28:12 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46245 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1APM2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jan 2011 07:28:11 -0500
Received: by iwn9 with SMTP id 9so3896054iwn.19
        for <git@vger.kernel.org>; Sun, 16 Jan 2011 04:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:dkim-signature:domainkey-signature:mime-version
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=yRP9Wc69x839K/LkhWjR4PvCIlPvxe3x214ac05qBVI=;
        b=db1nOMwzbqk1J4jFtSFYm9nqsq2gaoIxHhoYFZr16aHxk05VQzKJkSq7o4MGpgOcv0
         Gb9kt9dOkZxHQqxoygzIjETqz3gKmvDcibyOCMLLQZWH2hW8NkTNmDT2x9GKI0wZy60H
         6a7u78oLz1RkwzH0I+LSYINMfzXW0ExTiudng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=UBxiALHgmNixbhcdM8D9a4ahgMMIxt88kv/rDcKlUUAvBaMNBbzcG88a0Bo0nmeIZB
         E0leQwFB4kiayPuydmWadwptkZ7u3cyWcYooQz5merpNrUlFFhrLXyhUGWKMVbXaDF7v
         NOEEgA9ZE9L5ub043ch1WqsKQXu9GMvHvPyyA=
Received: by 10.231.15.8 with SMTP id i8mr2910023iba.125.1295180890517;
        Sun, 16 Jan 2011 04:28:10 -0800 (PST)
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
        by mx.google.com with ESMTPS id z4sm2988900ibg.7.2011.01.16.04.28.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 Jan 2011 04:28:09 -0800 (PST)
Received: by iwn9 with SMTP id 9so3896048iwn.19
        for <git@vger.kernel.org>; Sun, 16 Jan 2011 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=yRP9Wc69x839K/LkhWjR4PvCIlPvxe3x214ac05qBVI=;
        b=ukR0FAonC3Ey6pSjRUmo1dOKQqYCzKdv8XUHDqjOLZEpZKkMxm+6z3ZT18inxnt6i1
         E0ffPgCyPEmj30O9IdrAyHAJQ1XdXhjgGb5W2q7us00t9YDAnuSIQeO2ttMKsOqhXlRr
         a68gYkyUUI3tW1UumyJPoRLwXSxiwgLpytkBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c6CKAdfF+owR2wbZyJzrXdLncAvLKa4bNlkTStDIIVRshZTlesGOoS1CooWpPb54Ub
         G76le/6ipjPX6qfIJHaCXIH70d3XZdJyMvzlFdMNCXCiDvuTgyMyLFlB+CjcTAPibBs4
         ElSsGr0nVbQ+6Iey7dPyY6x2dEFkum/YZEf1w=
Received: by 10.231.16.68 with SMTP id n4mr2924834iba.94.1295180888559; Sun,
 16 Jan 2011 04:28:08 -0800 (PST)
Received: by 10.231.19.6 with HTTP; Sun, 16 Jan 2011 04:27:48 -0800 (PST)
In-Reply-To: <igr99g$mca$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165162>

On Sat, Jan 15, 2011 at 05:53, Neal Kreitzinger <nkreitzinger@gmail.com=
> wrote:
> How do I allow users from different linux group to cd to a common bar=
e
> mirror repo and also to a common non-bare cloned repo and perform git=
-fetch
> and git pull --ff-only? =C2=A0Currently, the non-owner group gets thi=
s error:
>
> error: cannot open FETCH_HEAD: Permission denied
>
>
> v/r,
> Neal
>

In this case i would suggest to access the repository via SSH and do
the access control with Gitolite. Then you can use for example a user
"Git" and chmod the repositories to that user and group. Depending on
the size of your team, it could need a bit of time to configure
Gitolite, but it's very flexible to adjust it for later needs.
If this doesn't fit your needs, then i think the only solution is to
create a linux group only for that repository and assign all users,
that need access to the repository, to that group.

Manuel
