From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: git pull question
Date: Mon, 26 Jul 2010 13:21:01 +0930
Message-ID: <AANLkTikpspDiUf==vCUiBqnQKFgcbag8XXaNYK3COjQu@mail.gmail.com>
References: <AANLkTimHg2wtNj2BmJKJfoisoqNEExC=jNU5wB95Bsre@mail.gmail.com>
	<AANLkTi=wXGBMUekUhtHS1KCOhjgac3ET8rmSCwUPHzQ3@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 05:51:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdEic-0005bt-Bw
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 05:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab0GZDvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 23:51:05 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47611 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0GZDvE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 23:51:04 -0400
Received: by qwh6 with SMTP id 6so4796203qwh.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=g3Lr1rjU7lT1fcduuviSnLc/s0Yqiixe1dtsICWxmno=;
        b=ebopJnHxrjDErJ02WhcTCXlXXfpcQHrnjdofEfLvPSXTFdpIBowKpIjpFFOWtpRyKr
         NfJz9Uz2/QSABaWdTYi4aBVZm4raH+R/TDcGjkToPMvQYGn9b+yMozb6Lys3YdN/2xDO
         KZVPz2A0Y3ReM/NintMTdF5Rzwfa4wk3Vxdcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=xG36Y+6LH5OVH5agEADfPsRhB6eO39AZQpSu2K6nePSidi2V9AcJAs1ldL05wNrJCZ
         OFkF3GD2f9Qo9TlCBbILYNFGLDRcd1XjWJAAUbjfKr3ZyrC+LQpB8OQYfVKiCjoIeNE0
         8Ro/p4be3oOTgUkVqelpKmgKoQWJXvTIOcc5A=
Received: by 10.224.78.68 with SMTP id j4mr5542687qak.231.1280116261817; Sun, 
	25 Jul 2010 20:51:01 -0700 (PDT)
Received: by 10.229.227.12 with HTTP; Sun, 25 Jul 2010 20:51:01 -0700 (PDT)
In-Reply-To: <AANLkTi=wXGBMUekUhtHS1KCOhjgac3ET8rmSCwUPHzQ3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151803>

On Mon, Jul 26, 2010 at 1:13 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
>> ...
>> $ git checkout master
>> $ git pull origin refs/heads/brA:brA
>>
>> The pull here seems to update both the current branch as well as brA=
?
>> Is this intentional?
>
> I believe this is intentional.
>
> A git pull always pulls into (at least) the currently checked out
> branch, in your case "master". By adding the <dst> param after the
> colon in the <refspec> you're saying to go ahead and fast-forward
> merge the local branch called "brA" if possible.

Okay.


> However, I'm not entirely clear myself on the meaning of this note in
> the documentation:
>
> Note
> You never do your own development on branches that appear on the righ=
t
> hand side of a <refspec> colon on Pull: lines; they are to be updated
> by git fetch. If you intend to do development derived from a remote
> branch B, have a Pull: line to track it (i.e. =A0Pull: B:remote-B), a=
nd
> have a separate branch my-B to do your development on top of it. The
> latter is created by git branch my-B remote-B (or its equivalent git
> checkout -b my-B remote-B). Run git fetch to keep track of the
> progress of the remote side, and when you see something new on the
> remote branch, merge it into your development branch with git pull .
> remote-B, while you are on my-B branch.

Yes, I was wondering about this ... I can't see any downside


Geoff.
