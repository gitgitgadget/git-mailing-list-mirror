From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Thu, 23 Sep 2010 02:13:18 +0400
Message-ID: <AANLkTin60S-6dtSmcYGqQTgBbpqXFLJWhJWfCWgpiA0E@mail.gmail.com>
References: <1285080133451-5555023.post@n2.nabble.com>
	<m3mxrak937.fsf@localhost.localdomain>
	<1285114417273-5557145.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 00:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyXZ6-0006gA-Oh
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 00:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab0IVWNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 18:13:20 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51492 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab0IVWNT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 18:13:19 -0400
Received: by qyk36 with SMTP id 36so5879143qyk.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 15:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qU8U8yscQLm70SeiO23MUT11Dx88+zojCTm5VksajjA=;
        b=sEd8KFLClc1Yu2py0s4QV63kf+dyuuRSevP1VnpIwqnMqtibnMrW8zn4niiWg9iMoe
         HC9E79bVBvW7dZvlTK8IIL5YgBrUvRVf8tpPfVNz5A0oBI5MU3w1OjpBWJtcrSos7A44
         YVBDtVfRKmG6SU3DPWiyJgyXNc8uMQ5TZg6XI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AjZAJd1TT5B8wy2PyiOXH1oviQd3r14UrFlJveq0eVRCAAlT+nJ62czNEbInN0DRlB
         0kMBT2cWM2qraJQODOh3NUE9M7BZU1NepjUHCrrdQLHehLN2KbpqTxtOjbsOTOuiG3Qh
         oXddJ2nGXPrpVN3nbTqePnWb4QgL9bk9nDndo=
Received: by 10.224.9.205 with SMTP id m13mr668373qam.68.1285193598489; Wed,
 22 Sep 2010 15:13:18 -0700 (PDT)
Received: by 10.229.215.6 with HTTP; Wed, 22 Sep 2010 15:13:18 -0700 (PDT)
In-Reply-To: <1285114417273-5557145.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156838>

On Wed, Sep 22, 2010 at 4:13 AM, FernandoBasso
<FernandoBasso.br@gmail.com> wrote:
>
> For instance, I have 'hello' in line 2 of site.php in the master bran=
ch. I
> go to the =A0testing branch, edit site.php, change 'hello' for 'world=
' at the
> same line, commit and got back to master. I merge testing into master=
 and I
> get no conflicts. Shouldn't it conflict ? (site.php in master also co=
ntains
> the string 'world' in the place of 'hello' now).

Conflicts happen only if two branches have contradictory _changes_ to
the same line. If you merge some branch, it means you accept all change=
s
from it. So, if one branch has no changes, and the other branch has som=
e
changes then all changes from the other branch will be accepted without
any conflict. The special case when there is no changes on your current
branch but only on the merged branch is often described as fast-forward
merge, because the result merge does not produce any new commit, but
only advance the current state to the state of the other branch.


Dmitry
