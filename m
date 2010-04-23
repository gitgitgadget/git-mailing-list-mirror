From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 18:38:35 -0500
Message-ID: <s2mb4087cc51004231638u6f0110fcxd4369ff8d81c7c06@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <4BD1EE10.4010009@gmx.de> 
	<k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com> 
	<4BD21CAB.8060903@gmx.de> <20100423222522.GA21224@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Apr 24 01:39:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5SSi-0005kR-M3
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 01:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab0DWXjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 19:39:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:63959 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0DWXi7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 19:38:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so460447fgg.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CPlDTpVM9al6zRUr7aSM4Elu8KDn8WOGytviEFLv+gA=;
        b=qS9VY46HgdHVwzB2sBbtr0v7w1QYAvjD2yLoJZdZoRGWFrb9TA6BcdKpzUHlXMwyLm
         HzH2w13MlGB+PdjIYfwEQSIi8LwVW0jekYa+GUoQFU0p0IfSl2qS9ZacimotSXUKHpxi
         2Gpbd0mccTLydqd8AvzaF+U+up8+oQf7N4h5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IBRA1QCvjc+NBKUuBfsm+gAlWEzpIn0YmG2Jxk36fMrEjCNCrBkHrk0sjQVppHYiW+
         20uZhty2lRhSDRQRytRa9MPYemjgf0zBaPUqq7KSwRRzqVixUb97hX6xFe2MSWZ+y8ra
         7MoAGUHmb/Rq0GYYhUkTX4Ia4/8ff53TiZOdQ=
Received: by 10.239.177.212 with SMTP id w20mr65395hbf.126.1272065935102; Fri, 
	23 Apr 2010 16:38:55 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Fri, 23 Apr 2010 16:38:35 -0700 (PDT)
In-Reply-To: <20100423222522.GA21224@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145650>

On Fri, Apr 23, 2010 at 17:25, Eric Raymond <esr@thyrsus.com> wrote:
> Commands that are simpler
> to mentally model, because they don't have a lot of exception cases,
> are better.

The UNIX philosophy: "Provide mechanism, not policy."

Some goofball touched upon this subject in a little-read book called
"The Art of Unix Programming", specifically:

    What Unix Gets Wrong
    http://www.faqs.org/docs/artu/ch01s04.html

    ...

    But the cost of the mechanism-not-policy
    approach is that when the user can set policy,
    the user must set policy. Nontechnical end-users
    frequently find Unix's profusion of options and
    interface styles overwhelming and retreat to
    systems that at least pretend to offer them
    simplicity.

    In the short term, Unix's laissez-faire approach
    may lose it a good many nontechnical users. In
    the long term, however, it may turn out that this
    =E2=80=98mistake=E2=80=99 confers a critical advantage =E2=80=94 be=
cause
    policy tends to have a short lifetime, mechanism
    a long one. Today's fashion in interface look-and-feel
    too often becomes tomorrow's evolutionary dead
    end (as people using obsolete X toolkits will tell
    you with some feeling!). So the flip side of the flip
    side is that the =E2=80=9Cmechanism, not policy=E2=80=9D philosophy
    may enable Unix to renew its relevance long after
    competitors more tied to one set of policy or
    interface choices have faded from view.[6]

:-D

Sincerely,
Michael Witten
