From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 11:42:31 +0100
Message-ID: <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>
	 <fk2juf$t25$1@ger.gmane.org>
	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
	 <fk2p0f$961$1@ger.gmane.org>
	 <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
	 <fk2q1f$bbh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Abdelrazak Younes" <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3qxT-0001gK-Pj
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 11:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033AbXLPKmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 05:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbXLPKmc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 05:42:32 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:31250 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbXLPKmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 05:42:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1486155rvb.1
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 02:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gJvLaJQa7Zjr+zH1YvqgECLoQulwLJQ7A+Q2NfLiqnQ=;
        b=rH1HrKIKgV/D5C9azMPq44ZnefqktaoWvot4T2oS7fqSQQQNm0QFWsMSCkWqTIgMegrec8CxyZXl8w8YMx62bqFN9alHI4t7k1jSk3XruKazeLUcS3N7m0ENyuVXNxKfbUf1kfGykf/P5yGGdqSv/EWGZEhiPogvdiz8h7l3FWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErBntVsR6gvN/PA2FawzavxWMU6DLZuk7S2QS07fdNMQUtcSR/rbFIwvdanSxGkgE0SjhBK8Kk3vw0xrkTZrgwATHeFZdbwfv8YVXXHqqBYcZ+ygDn3mWlzgXPWKvq/K3MV7IgdynzV1dZ3laik++03XQGuDV1gCFNT3CAlUh6s=
Received: by 10.141.20.7 with SMTP id x7mr71155rvi.183.1197801751081;
        Sun, 16 Dec 2007 02:42:31 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 16 Dec 2007 02:42:31 -0800 (PST)
In-Reply-To: <fk2q1f$bbh$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68455>

On Dec 16, 2007 10:10 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
> Marco Costalba wrote:
> > On Dec 16, 2007 9:52 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
> >> Hum, I can't imagine this is the reason, it might be for another reason,
> >> most certainly the static compiling.
> >>
> >
> > Static compiling is indeed a highly suspect. I'm now compiling as
> > shared libraries, we will see...
>

Ok. compiled shared libraries release version and qgit release version
-> does not even starts!

After some more test I found that if I compile qgit release adding
flag -O0 it starts, although there is some strange misbehavior
sometime, so the suspect now is a broken O2 optimization for mingw.

To test this I could recompile (sigh!) Qt with shared release + O0
flag, but I'm not sure how to do it.

>
> The MSVC compiled Qt dlls :-)
> Sorry too, I guess I was not clear enough.
>

Yes please!

Thanks
Marco
