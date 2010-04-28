From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Groups of commits
Date: Wed, 28 Apr 2010 13:25:39 +0800
Message-ID: <r2jbe6fef0d1004272225rd61ef84axe86ba45a0b352a8@mail.gmail.com>
References: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
	 <87sk6ge312.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Wed Apr 28 07:25:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6zmX-0006Qz-O7
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 07:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab0D1FZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 01:25:41 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:52475 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0D1FZk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 01:25:40 -0400
Received: by iwn40 with SMTP id 40so4753216iwn.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qANoP7HQ5CP1dpVWHkdsTd0hiI34AF7AlRlNyGMK7Y4=;
        b=OsXb5r/3oJvgdicUy37Y3q7I95woJ1NuxkPK8pSShFL3yIWed3FfwFFWpMWaf/Qi8k
         N12gd9Y+goSmoSbk31cxktYTfWgUmaKkFfRvJAOWkbUS2RowmdoMRY1aK/zYmyv4xZzP
         OKBuXnVV4EaD6rW9HfOz8Pwx44W7TQB4QwO7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JBOr/duhY1DEp19WhYKeY/+EwCe3ajbLhQHEcy8xDQefQtw/kEOHlM6mzf+6DH+nj4
         /sfOUTLwsr+JZWyKaIlZW7AqfLB6q7qviOlaTacdPPx/Fp4wu4Af3pImKuBDOWywHBTn
         K4uB0c41aU7R3RgvoUw5W1G2UAzX+XeAJJGzw=
Received: by 10.231.153.149 with SMTP id k21mr2244205ibw.17.1272432339883; 
	Tue, 27 Apr 2010 22:25:39 -0700 (PDT)
Received: by 10.231.36.201 with HTTP; Tue, 27 Apr 2010 22:25:39 -0700 (PDT)
In-Reply-To: <87sk6ge312.fsf@troilus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145969>

On Wed, Apr 28, 2010 at 10:15 AM, Michael Poole <mdpoole@troilus.org> w=
rote:
> John Tapsell writes:
>
>> Hi all,
>>
>> =A0 In my work place, we have a lot of strict rules to get something
>> committed. =A0The code has to pass against a large test suite, it ha=
s to
>> be tested on different hardware, and so on.
>>
>> =A0 The problem is that it forces everyone to have one single large
>> commit for a week's work. =A0All the intermediate stages get squashe=
d
>> and that history forever lost.
>>
>> =A0 It would be nice to have a commit in the repository, treated as =
a
>> single commit for all purposes, but then be able to split it into
>> multiple commits if necessary.
>>
>> =A0 Any ideas?
>
> Isn't that what topic branches are for? =A0When development is done o=
n a
> short-lived branch (hopefully one with a descriptive name), the only
> commit that needs to go through that process is the merge onto the
> integration branch.

Just to add to the "merge in topic branches" idea - if you find that
the commits are trivially fast-forwardable, you can still add a short
note/cover letter with

  git merge --no-ff -m "Added in foo's work" <branch/commit>

--=20
Cheers,
Ray Chuan
