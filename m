From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 20:37:16 +0300
Message-ID: <CAHkcothno3tQG0G-5Mo7vVbKxUkNGqWd+6BRWhjnKafrSp1FTw@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hHJ-0002bz-Df
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab2CHRhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 12:37:19 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39513 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2CHRhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 12:37:17 -0500
Received: by mail-qy0-f174.google.com with SMTP id w6so524209qcq.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UdpKIgvl37odaP352D5sb2gBub+wwnlq8uG1bC6j/UA=;
        b=ApVw9xpfg49HuxAM/utQqT9mCxxliFi+phxmnjSm81x+XvYf4PiR0kHz09XqR0sUBw
         rlEDXpqlwzeHcPs3SYkCUCHBGOWWdDA+qqgW8IOL7arCqEU86J1jMI5x7eqTQy0Xi6cr
         ThJSzt/zN6iaS0fEam0Y9cJLZMnJpuyuoVb44akpxQgSfcWaTj/+nPfG4NpkwU5OyUNT
         Ueb0Pg9AH1aSPB4Ld9I2AOfaP2f2qdgd33T1Gj3bjE1jcyD8jXuIoqX98YzDDZ2MVyAK
         mIbPJIIE/hliY37x8zy9AYdeutLO7/xwy/HZ5rvMFZusPbUZ+VsBr0MJACwkE2m7jMOK
         Cw5w==
Received: by 10.224.186.145 with SMTP id cs17mr4142171qab.40.1331228236889;
 Thu, 08 Mar 2012 09:37:16 -0800 (PST)
Received: by 10.229.88.149 with HTTP; Thu, 8 Mar 2012 09:37:16 -0800 (PST)
In-Reply-To: <4F58C977.8000400@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192621>

On Thu, Mar 8, 2012 at 7:00 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>
> Perhaps --force should be changed to require an explicit ref if push.default
> = matching (and the code finds that it needs to use push.default's value)?

No, it will workflow for some people. In general, --force should not be
used, but when it is used, it is used for a reason. If you need another
behavior like forcing only the current branch then you probably should add
--force-current or something like that, but not to break what works now.

Dmitry
