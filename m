From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-describe: what is the '-g' prefix good for?
Date: Thu, 16 Jul 2009 13:47:19 -0400
Message-ID: <32541b130907161047h7df7fa4dsfa61ed65789f4c01@mail.gmail.com>
References: <4A5F5340.9030908@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Jul 16 19:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRV3b-0000J5-Lk
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 19:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbZGPRrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbZGPRrk
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 13:47:40 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:60881 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932891AbZGPRrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 13:47:39 -0400
Received: by yxe14 with SMTP id 14so466799yxe.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aRr38MXkABkp9N+QNsdxeBen9hnuoOSlXOPsRZj6Sus=;
        b=DDwrG/ydPPRdtn/LNwzbHqFexIfgykQ5dq/HyatNhE+nSCpUCtrj97kgWJ2Bvi2PBY
         K17ZFyeBmwQqf7O5nqVAQLtYFitxpbr3QoV1jXQsABKsP8SE5fxBXDBdPEx2JIiObQqx
         dP0rBc13l4dUl3Qnhy86SPIbqs9i3XPbVdwXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qVta2ot4rt8C2WDun9yyMHi9ba86e2ki2xOzyK3RgCPm49aatZtAA2YmPXR5l30CxN
         iU66PUAsxKVRYIoRvTu92YK87OIoHYnFngHLR3UjntKQslW0fhq+SdoyfIbGsa+l80sD
         dco1TAjaRIkVqkF94FjJQIYwH0JBpTQuWvijY=
Received: by 10.150.136.10 with SMTP id j10mr177176ybd.299.1247766459058; Thu, 
	16 Jul 2009 10:47:39 -0700 (PDT)
In-Reply-To: <4A5F5340.9030908@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123412>

2009/7/16 Dirk S=FCsserott <newsletter@dirk.my1.cc>:
> I'm a bit surprised about the output of git-describe: if I'm on a tag=
,
> git-describe tells the tag's name. Fine. If I commit sth. on top of
> that, it tells how far I'm away from that tag and the current commit'=
s
> SHA1. Very fine. But then the SHA1 is preceeded with a '-g'. What's t=
hat
> for?

I'm sure it stands for something like "git".  You don't want a random
number appended to your tagname (which is often a version number)
because it might be mistaken for part of the version number.  The g
makes this less likely.  It also differentiates between git and any
other version control system (except ones starting with 'g', I guess
:)) that might implement a similar feature.

Avery
