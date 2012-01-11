From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git svn clone terminating prematurely (I think)
Date: Wed, 11 Jan 2012 10:04:26 +0530
Message-ID: <CALkWK0nyc6NVE7Qpvbc0dXb1UHGM_=uYbCS+a53HZxiBRG9HvQ@mail.gmail.com>
References: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Line <sline00@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkpu5-0002qL-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667Ab2AKEet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:34:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:58653 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739Ab2AKEes convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 23:34:48 -0500
Received: by werm1 with SMTP id m1so228024wer.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UX8ubLAb8n4d8veSd+002IoioX1/WMc8YTLov+Qy3cI=;
        b=ELcH7eKPK12gBoc33KoucNxeT2uATTK+OEzH5HNosJrVKQrFmM+NQf2oFqwl007TPt
         Z1nx/R1Hi0rzRXe66TGVb5a4nSuh2FhR7F5ouWQFQyjPFqNHS4zTF3j7cbrRIx85/nok
         YN/iHQr2sq4gMaXmnP76TRnjOw9RAhtDMvvYM=
Received: by 10.216.134.69 with SMTP id r47mr10328421wei.17.1326256487243;
 Tue, 10 Jan 2012 20:34:47 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 20:34:26 -0800 (PST)
In-Reply-To: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188325>

Hi Steven,

Steven Line wrote:
> First off I am a new user to git, I'm not a git developer or power
> user. =C2=A0Am I in the right mailing list? =C2=A0If not could somebo=
dy point me
> where I could get some help from experienced git people?

This is the right place.  The Git community believes in maintaining
just one mailing list.

> I need some help getting my subversion repository cloned over to git.
> Our svn repository has about 12,000 commits, when I run
> git svn clone -s =C2=A0-A authors.txt
> svn+ssh://csvn <at> source.res.ourdomain.com/home/svn/sem sem
> It runs for about 2h 15m then completes with no error messages. I hav=
e
> also cloned starting at revision 6300, about the middle of the svn
> repository, and I get the same results as below.

> $ git branch -a # shows only about half the branches that should have
> been cloned

Interesting.  From the git-svn-id of the most recent commit, can you
tell if there's anything especially fishy about the revision where
git-svn stops?  Your Subversion repository is probably broken in some
way, but git-svn should not use that as an excuse for appearing to
finish successfully while failing in reality.

Cheers.

-- Ram
