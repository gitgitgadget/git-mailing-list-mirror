From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/12] Re: Makefile: add missing header dependency rules
Date: Tue, 26 Jan 2010 10:19:55 -0600
Message-ID: <20100126161954.GA5550@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 17:20:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZo99-0007bL-Qs
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 17:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab0AZQUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 11:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753581Ab0AZQUA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 11:20:00 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:63105 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0AZQT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 11:19:57 -0500
Received: by gxk24 with SMTP id 24so5884936gxk.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q4lYgUhBP/wMYunRNM+nFkaNM7JDyyz8qVPCk2sdHWM=;
        b=IcSdNERxZSmKPAlDwJ60iR4NhXdJGLiE1H1JoAhge6IDnTmWCINAHf57LL/kvIWORG
         PMFyYtaHdB+GLZQXotT3mWMedmhvlw1GOdNxVKu/r23kAby6OWCb/EaxUp6m7nwFfEgC
         R24HW/D+9C47dXN/nbtnQTG+oRwvbnzQjGoY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FPhfmbUHrjprbDvTeSx1Hsa4p+f5k2SD3FfRZGDXyXkbUz6uK23QS9LlLky5+GP4Mj
         KZqmWibQ/6rDqRDkft1z6v4hQUeQ5sE7pww/tO9PFcv8o/91TclCAA63vAw6E92we9Bk
         wcc1XZ6MvfJ9drLtZjOoPmCpKCqSggT1xSeTI=
Received: by 10.150.128.38 with SMTP id a38mr3884035ybd.217.1264522795572;
        Tue, 26 Jan 2010 08:19:55 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2174336ywh.0.2010.01.26.08.19.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 08:19:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138054>

Jonathan Nieder wrote:

> The remainder of this series is based on a merge of master and
> patches 1-5:
[...]
> Jonathan Nieder (12):
>   Makefile: add missing header file dependencies
>   Makefile: make sure test helpers are rebuilt when headers change
>   Makefile: remove wt-status.h from LIB_H
>   Makefile: clean up http-walker.o dependency rules
>   Makefile: drop dependency on $(wildcard */*.h)
>   Makefile: transport.o depends on branch.h now
>   Makefile: rearrange dependency rules
>   Makefile: disable default implicit rules
>   Makefile: list generated object files in OBJECTS macro
>   Makefile: lazily compute header dependencies
>   Makefile: list standalone program object files in PROGRAM_OBJS
>   Teach Makefile to check header dependencies

=46or those would like to avoid redoing the conflict resolution (and
who wouldn=E2=80=99t?), this series is also available in the git reposi=
tory
at

  git://repo.or.cz/git/jrn.git autodep

If you=E2=80=99re interested, please take a look around and try it out.=
  I=E2=80=99d
be happy to hear about any bugs you find.

Thanks again,
Jonathan
