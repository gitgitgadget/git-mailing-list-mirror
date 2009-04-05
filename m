From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:22:41 +0200
Message-ID: <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> 
	<200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> 
	<200904060117.24810.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Apr 06 01:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbhX-0004AT-VW
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZDEXXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZDEXW7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:22:59 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61820 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZDEXW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:22:59 -0400
Received: by fxm2 with SMTP id 2so1662700fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=glPWfirWrkqvIVkX9k2safEoSPWuH96ojcuEIr32y4Q=;
        b=F3zVV9+F8GRAqE3vGkEQWllHNYtN9CEU8rqF0H9PddArGtDGteiRT2T2h83dQNBJpm
         Mo4WKwyf/q6FMcORM1YkDl3YRoB8FldhcHrhBBTsjeE1gLDRy8THBTKECm0o4BTOwmyM
         qn/Un4ubTynRBgWUSAdLb+mfcPROKz4HpxH9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LaqPt+Ay2nudekz0U4wXpFqXVwisKMazrrRn3AcaVEJy+bqKged9Ud23n7MbkP5FK3
         M9mXSOns89ShmXAnDqN/Omy6D45cWBAuVRps6vCCHbE57wSVQAXWx7AS9ra5uYY+ifQc
         V5LwCmKBVhoRRWHwG7bbwBpoBaa51F/RLKZKg=
In-Reply-To: <200904060117.24810.markus.heidelberg@web.de>
Received: by 10.103.244.10 with SMTP id w10mr1671557mur.71.1238973776279; Sun, 
	05 Apr 2009 16:22:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115736>

Heya,

On Mon, Apr 6, 2009 at 01:17, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Felipe Contreras, 06.04.2009:
>> But actually, "git diff --cached" is a
>> different action; you can't do "git diff --cached HEAD^.." for
>> example.
>
> And I neither could I do "git stage diff HEAD^.."

I rest my case ;). That's the whole point Felipe is trying to make here.
$ git diff --cached
$ git diff HEAD^..

That's two different modes of operation with the only difference being
a switch ('--cached'), which changes what is, and what is not valid
after that.

Whereas with
$ git stage diff

There is no confusion that 'HEAD^..' is not a valid argument, as there
is no command in 'git stage diff' to which it _is_ a valid argument.


-- 
Cheers,

Sverre Rabbelier
