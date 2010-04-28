From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Groups of commits
Date: Wed, 28 Apr 2010 08:46:03 -0400
Message-ID: <i2k32541b131004280546j5fc4e160oa1618fe14d83a291@mail.gmail.com>
References: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com> 
	<87sk6ge312.fsf@troilus.org> <r2jbe6fef0d1004272225rd61ef84axe86ba45a0b352a8@mail.gmail.com> 
	<y2t81b0412b1004280105p46962bdeq163bc4fb92cb0fdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Michael Poole <mdpoole@troilus.org>,
	John Tapsell <johnflux@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 14:46:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O76et-0004JO-6j
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 14:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0D1MqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 08:46:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45429 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab0D1MqY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 08:46:24 -0400
Received: by vws19 with SMTP id 19so213286vws.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XG6EY1B/rodnbTmeDqCJqRELayvrIW8qqqOmPwPYzfE=;
        b=RSmrx9pnPsDdgmuDI4Rj6ZnwzaO6WyG9Ygl4SDUIFsLyb5Z/Bc9LS+HIM3SXcFVs0A
         HZzwOF7+T0mlVKIYeQXi+D1H3bv/ucBs7MzFuh7iB/JBrKoNUQZ40zVCy+/h7nGgsOD2
         C1wWL4w16/92FkBtBm9Mhwynq4RuZO8m/B9Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sYXOFZtqRZ5rjAWZ/7L3b3Bns5GLpDg8xN2zMitOsFIqrCsrkV3oNcKBJrocOeXNsh
         SWK0hFfTXROdlM2SixYs1yXsCzDpC7qNjS2cJX6VZ06lpssYRDGLc2nVQlLhZJ3Ggr5k
         qlukJqJcFCb59YUctno29PeKexdQfcBw8Pmo8=
Received: by 10.220.123.7 with SMTP id n7mr3808213vcr.164.1272458783153; Wed, 
	28 Apr 2010 05:46:23 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Wed, 28 Apr 2010 05:46:03 -0700 (PDT)
In-Reply-To: <y2t81b0412b1004280105p46962bdeq163bc4fb92cb0fdb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145993>

On Wed, Apr 28, 2010 at 4:05 AM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> On Wed, Apr 28, 2010 at 07:25, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
>> Just to add to the "merge in topic branches" idea - if you find that
>> the commits are trivially fast-forwardable, you can still add a shor=
t
>> note/cover letter with
>>
>> =A0git merge --no-ff -m "Added in foo's work" <branch/commit>
>
> Except that is not a "short note" anymore, but a full-fledged merge
> commit. You forced it with "--no-ff".

I think it's safe to say that a commit *is* just a "short note" about
a tree, who made it, the reason (message), and who its parents were.

Have fun,

Avery
