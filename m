From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial 
	branch
Date: Thu, 12 Mar 2009 09:48:29 +0100
Message-ID: <4d8e3fd30903120148u52164fe3offe665bf70ef6d8d@mail.gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
	 <1236040414-19089-1-git-send-email-torarnv@gmail.com>
	 <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
	 <loom.20090309T143413-334@post.gmane.org>
	 <94a0d4530903090901o6e8c2a40k676387f90ee461b3@mail.gmail.com>
	 <4d8e3fd30903110152m1b52de30ge630d6b9f6a4c7fe@mail.gmail.com>
	 <buoocw7s79y.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	torarnv@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 09:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhgcC-0005hW-Ej
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 09:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZCLIse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 04:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZCLIsd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 04:48:33 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:38066 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbZCLIsc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 04:48:32 -0400
Received: by fxm24 with SMTP id 24so288661fxm.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KrTm9iuPFX5WQqz6Ue4QKcHqZXXaDR4pcFSJJfFd9L8=;
        b=IU/7dSuilkFO3fQoBPpHhIRobZVSXvtjYedh3RB5S7cHXSQtAwI7ThVCyYGQ6kZZ+p
         9X0Lhc2F9Cd3CH0MKi2w3XcOSr5bznzcArJeCun1aZfUWKrt0jHleVXngTvzbyQy5LvV
         wWcKG3du8YjM9/8Q75717iuMTp7ff2h4Iew9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N/0Ynf5donJL0u3HSNBL8h0YvniAc29fi/KQgU0q9M4pbYbFcMXV9NFKR79zoZL2Uv
         G1jTjGdN6K4kIn24DrGbdNvr5w4Ouu2CyWU0I+84Ee1JmS1bXC8otxr1RSLmlqpSkYTD
         sxGrb6iUBfW/U3KN2tVdc20CgwES0qAhmvqiU=
Received: by 10.86.100.19 with SMTP id x19mr3257527fgb.49.1236847709687; Thu, 
	12 Mar 2009 01:48:29 -0700 (PDT)
In-Reply-To: <buoocw7s79y.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113021>

On Thu, Mar 12, 2009 at 5:18 AM, Miles Bader <miles@gnu.org> wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> writes:
>> $ git clone -n URL
>> $ git checkout -b foo origin/bar
>>
>> That being said, I see the following command as an improvement over
>> the actual GIT UI:
>>
>> =A0$ git clone git://URI -b bar
>
> Note that in your original advice, foo and bar can be different, and
> it's not clear to me what "-b bar" should do...
>
> Personally I frequently use foo =3D=3D bar (no local master branch), =
but I
> think another common pattern is foo !=3D bar, but foo or bar =3D=3D "=
master".
>
> Maybe a syntax similar to push, like "-b LOCAL_BR:REMOTE_BR",
> with "-b BR" being shorthand for "-b BR:BR"?

Yes, makes sense.

Ciao,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
