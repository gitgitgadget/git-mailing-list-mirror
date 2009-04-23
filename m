From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Thu, 23 Apr 2009 16:55:06 +0200
Message-ID: <ae63f8b50904230755p12170753qf3fc273b48afe4d4@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
	 <20080604192916.GB17327@sigill.intra.peff.net>
	 <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
	 <20080604230858.GA27136@sigill.intra.peff.net>
	 <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
	 <20080808211916.GA30583@sigill.intra.peff.net>
	 <2c6b72b30808100216j2c719bf2yb7dfba651db901e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 16:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx0M4-0001Tp-R6
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 16:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533AbZDWOzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbZDWOzK
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 10:55:10 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:36309 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953AbZDWOzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 10:55:08 -0400
Received: by gv-out-0910.google.com with SMTP id p33so383gvf.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=Nf0Aw7S+WjUd8t9IDIswu9CNC6GDWSzi5U/P+2qF8xM=;
        b=qoIKIOeUUwfZYDhFXiVdjTR0PpGkACbbcwrPeURc2xnhzN470Kykn0jkTUzyN2ANxb
         jsDeyJhJciGykG35GGN113NscxtKfJul/rWpZXPX5U0m/mofRZxZOq8sLJt680QtExtp
         3Ttg+fdj4hPSxVffN8+r5nF8HFkMPwQLi4pd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dsqCxrby4HxgyNxYtHzx7UfR5qRmqJp5fOTOuxFvJ2YtpXZihR5PZmc8HmYrGNYy8J
         hSaIN6UUgbG/XV9twldJDK25f3El/HeTx/oZARz6a9sCSyZZ/GymyKnD4xMSXu2lQLuM
         I//HfsbOxuOXeBruJVEgQmC5W80N6GgaRaO/s=
Received: by 10.239.162.17 with SMTP id j17mr50386hbd.123.1240498506283; Thu, 
	23 Apr 2009 07:55:06 -0700 (PDT)
In-Reply-To: <2c6b72b30808100216j2c719bf2yb7dfba651db901e3@mail.gmail.com>
X-Google-Sender-Auth: b1c8a325fe20d394
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117343>

2008/8/10 Jonas Fonseca <jonas.fonseca@gmail.com>:
>> So here is my cut-and-pastable version:
>>
>> =A0tignowalk() {
>> =A0 =A0tmp=3D$(mktemp)
>> =A0 =A0cat >"$tmp"
>> =A0 =A0TIG_MAIN_CMD=3D"git rev-list --pretty=3Draw --no-walk --stdin=
 <$tmp" \
>> =A0 =A0 =A0tig </dev/tty
>> =A0 =A0rm "$tmp"
>> =A0}
>
> Thanks for the fixed up version.

Restarting this old thread again.  Starting from 0.13 the
*tignowalk()* hack does not work anymore.  What's the preferred way to
feed specific revisions using stdin now?
--=20
Jean-Baptiste Quenot
http://jbq.caraldi.com/
