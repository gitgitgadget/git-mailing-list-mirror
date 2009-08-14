From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 2/3] fast-import: add option command
Date: Fri, 14 Aug 2009 10:43:21 -0700
Message-ID: <fabb9a1e0908141043l35d2070bxdadae96a7dd8a232@mail.gmail.com>
References: <1250190156-4752-1-git-send-email-srabbelier@gmail.com> 
	<1250190156-4752-2-git-send-email-srabbelier@gmail.com> <1250190156-4752-3-git-send-email-srabbelier@gmail.com> 
	<20090814153707.GT1033@spearce.org> <fabb9a1e0908140937h32a2eac7ka88f76aa417fd631@mail.gmail.com> 
	<20090814173929.GU1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc0of-00083a-S5
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 19:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbZHNRnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbZHNRnl
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 13:43:41 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:61665 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbZHNRnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 13:43:40 -0400
Received: by ewy10 with SMTP id 10so1673271ewy.37
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5QqQqw2tZqPuPMbK26E8jS6dK+cMGWB+wAgoUZiOMn4=;
        b=P6gKtcnOIlzfBGAwWQDDr+4msSw8LoI9ZlWoztOfZYUX1eltGYBkL7B8ywfOhtnBkw
         RBHAL/FzQAWmvIwIZr/sjiXg9tghBZqNSKY6/85DZhlEquKFtvtgZQ8snQ5ESpTi+RDB
         fTxisS8vYOSFPzeDA5Jeot7BoejTsOryK1Onc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CMyNQ6RK3QTTz2fDk8oxqHvVQvsegiQc+I5NkVI/92T0O1/X9fbSDCcUO7TGgXvGZ3
         CDOrouyNC6M6li25QgEtur0RMGBzxnGDqA6XY3jy2SvOCR+xGyyw9ey7B/q8jncAoGmz
         jpXhtJmDeKWZbA122tAcUnoI9vbhDMdHgMRT8=
Received: by 10.216.70.205 with SMTP id p55mr471160wed.55.1250271821090; Fri, 
	14 Aug 2009 10:43:41 -0700 (PDT)
In-Reply-To: <20090814173929.GU1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125939>

Heya,

On Fri, Aug 14, 2009 at 10:39, Shawn O. Pearce<spearce@spearce.org> wro=
te:
> Sorry, lack of caffeine. =A0Rereading the docs makes sense.

Perfectly acceptable, I totally though the 'break' in a 'switch'
statement would break out of the outer for loop the other day.

>> > So yea, I really do think its a good idea for command line options
>> > to override stream options, despite what Dscho may think. ?:-)
>>
>> Which is what the current version does, yes?
>
> Yes. =A0:-)

Ok, I think perhaps we can wait 'nother day to see if anyone notices
anything (possibly after more caffeine) and then ask Junio to apply?

--=20
Cheers,

Sverre Rabbelier
