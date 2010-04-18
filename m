From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v5] gitk: Use git-difftool for external diffs when git >= 
	1.7.0
Date: Sat, 17 Apr 2010 22:20:19 -0400
Message-ID: <l2t76718491004171920y80eba2d7lbeed0add15e6ffed@mail.gmail.com>
References: <20100408090211.GA31594@gmail.com>
	 <1270717690-32133-1-git-send-email-davvid@gmail.com>
	 <20100417085230.GC6681@brick.ozlabs.ibm.com>
	 <20100417224556.GB9366@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 04:20:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3K7d-0007eV-Dl
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 04:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab0DRCUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 22:20:22 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51561 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab0DRCUU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 22:20:20 -0400
Received: by gxk9 with SMTP id 9so2337077gxk.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8y3/9jCGPW8fnITa/7KNRWnlbJH1ytuG+416KvKZaAg=;
        b=ssNPXpJdGVd43ZUuW1wLTA8avnMYv4w39tyIdN1/eSUeewbK6u/JNZ3kVmPqmywUBj
         YGW2z6aS2QlE5cTYBI45BctiUbCgbXKsWUhht3/RlTS2UIm4Ov5nWVity6udW+ZPVFlo
         UMBhPmd6FDmsR6XIvNi4eLRpPz1qc8GUSxA88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=STgXIrWVxuJsRKqGjqCm8abndWaKFruGdiggqOL3D0xAOEOGkKCmgHnrRNHwdjWB5T
         sFW6AGmmaBgLawY9BZVQbKXZLqj2XCTNpjebm/qw7ul/3VjI+UKI3vAHsoDpI2azd5oS
         DE5mPE9SOdybY8DpYOj/CloZCpgk6bmMAEjkE=
Received: by 10.231.36.9 with HTTP; Sat, 17 Apr 2010 19:20:19 -0700 (PDT)
In-Reply-To: <20100417224556.GB9366@gmail.com>
Received: by 10.100.233.36 with SMTP id f36mr8970993anh.143.1271557219497; 
	Sat, 17 Apr 2010 19:20:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145203>

On Sat, Apr 17, 2010 at 6:45 PM, David Aguilar <davvid@gmail.com> wrote=
:
> Jay, you mentioned wanting to give Junio's approach a try as
> well as looking into what mercurial did with mergetools.
> Do you have any thoughts about it since then? =C2=A0I can help
> factor out the backends if you don't think you'll have time to
> get to it soon.

Wow, I need to stop starting new patches and start finishing some of
the ones on my todo list.

But sorry, no, I haven't had a chance to look at this and I'm not
likely to soon. So if you've got the time and inclination, I'm happy
for you to do the work. :-)

j.
