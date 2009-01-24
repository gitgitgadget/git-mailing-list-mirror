From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: http fixes, was Re: [PATCH] Allow cloning an empty repository
Date: Sat, 24 Jan 2009 10:39:34 +0100
Message-ID: <bd6139dc0901240139l76ea28bq2610bf0ac07087b3@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
	 <20090123215559.GA5561@glandium.org>
	 <alpine.DEB.1.00.0901240125190.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 10:47:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQf6K-0004eI-Mi
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 10:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbZAXJpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 04:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbZAXJpS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 04:45:18 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:43161 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbZAXJpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 04:45:17 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1317410rnd.17
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=qDFeBkG8qeSpAra31zZJsB7pTJIkWmHILL35WxxGQxQ=;
        b=h0ufKaJclouyh+myJ1xhJAbPBQrpoe8NZ4rA2vlncv298JTaP/+N2RXG4GZlBEkStX
         NS6MwaDyI8c9eACted78OFGPmxPLe4UTXTYWp5YaOVHaHW92lxjW8ud4y3pPwWVZ68GY
         3BROyjyZi0gYULm08Z4ttRcZvLgS3770UYvzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=L2upXhyozkTDYobUuWKzWzMBE+YrnL8D4HEeRHyfty+DQUVY9oN8L5cVm8YA40aUmD
         FMsm3NAauyYbcezZuCKqD7whX9lZyEwsCon2s6lMvHOV+T4S5Tv3WKWouPTBrRU0K7Qp
         hRdxLsFzRgXQR9eh/RTxrgjGsYctOH7+5w4Qo=
Received: by 10.150.51.2 with SMTP id y2mr1885868yby.197.1232789974774; Sat, 
	24 Jan 2009 01:39:34 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901240125190.3586@pacific.mpi-cbg.de>
X-Google-Sender-Auth: cdde558b23aa8dc9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106961>

On Sat, Jan 24, 2009 at 01:26, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 23 Jan 2009, Mike Hommey wrote:
>> As I said when posting my patch batch, I don't have much time nor
>> motivation to work on this series. But let's make a deal: if someone
>> writes a good enough http test suite, I'll polish the http code.
>
> I already said in my replied to your patch that I will add the http test
> suite if you fix your patches.

I think Mike meant that he wants a working test suite before
continuing work on it? As in, what's the point in working on something
if you don't have a working test-suite to test your solution against
;).

-- 
Cheers,

Sverre Rabbelier
