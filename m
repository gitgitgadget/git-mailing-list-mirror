From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: pushing specific branches to a public mirror repos
Date: Fri, 17 Jul 2009 11:47:18 +0200
Message-ID: <36ca99e90907170247m7919980l38f8f379d2976c52@mail.gmail.com>
References: <h3pcrg$ekk$1@ger.gmane.org> <4A603B7A.6050208@viscovery.net>
	 <h3pf9d$mo7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 11:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRk2M-0008Lf-Qi
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 11:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934318AbZGQJrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2009 05:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934316AbZGQJrW
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 05:47:22 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:49540 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934314AbZGQJrV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 05:47:21 -0400
Received: by bwz28 with SMTP id 28so620372bwz.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rYm6ZEr5cAwYh2/oLYbU4Mtv9FoB+ljLYGapm61E4og=;
        b=O2o0tK7JUa9FrXR5zbl66tSRC9c/D4HpkDyR04fJQYYoCSWBgbC6BHN+4ickH6vAa8
         lOhqi7AoomLepW7pplRv8dUAKbeLexMd7feA2kj+z8nEHlLQmLq4vu0lSzSaQZqHM01B
         Ex7corLJfV5/XkNApuHaNv9aDHEhKOobUgxSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C28Ky3JATYItHzhOiT4NUCt6ShvFy6c9jsxcfErIHazKNDrKNloimx5iHWQSJvQNFE
         CNW3SWK6Nkat5LD17u976m1C4iRH9xBYSodxbC1Lixwf+MkmHosJ2gW19+Rpgny63XbS
         8EC4u0XYrOmnLPIz9+SoBmA5zUwqtWdEueisg=
Received: by 10.223.120.67 with SMTP id c3mr128999far.15.1247824038400; Fri, 
	17 Jul 2009 02:47:18 -0700 (PDT)
In-Reply-To: <h3pf9d$mo7$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123456>

On Fri, Jul 17, 2009 at 11:11, Graeme Geldenhuys<graemeg@gmail.com> wro=
te:
> My local "master" branch is currently tracking the refs/remotes/trunk=
, but
> for some reason (which I don't understand), if I do a 'git svn fetch'=
 by
> default master branch is not updated. I still have to run 'git svn re=
base
> -l' to get master in sync. Is there something I can change in the con=
fig to
> automate that as well?
Try 'git svn rebase' instead.

Bert
>
>
>
> Regards,
> =C2=A0- Graeme -
