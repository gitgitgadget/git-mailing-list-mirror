From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 12:22:46 -0500
Message-ID: <20100724172246.GA1714@burratino>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <20100724110239.GA13067@vidovic>
 <20100724125408.GA17481@burratino>
 <20100724140054.GB13067@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 24 19:24:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OciSD-0002xl-HO
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 19:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab0GXRXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 13:23:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60846 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab0GXRXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 13:23:50 -0400
Received: by gyg10 with SMTP id 10so494545gyg.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UCotT+ktbF0lcTU4E7XKi3YjmxOggMjFZZH1124RaiE=;
        b=qJkCr3QBf1coYpvggOSCfodZyqe+6Fj8S9z/pRfGglBgmIviEOaAx9gGv4kq6/HtFn
         9ziQSdYNNW5ZDi5+KxxBWItd4B53bE5pRj1lsj3b580Rdf5zWA8U7FIC2Q5zdu1QJs5+
         3XyIYDPWRAYYgidsNEkcjN6osiu1oSpMw+xXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u3+rARaIkBA8Lla1sCoctIql5NR35YB6fgD6xafEEi+5glWToAmj7f/KvShfGrPEwd
         3rdit9lnXIInorTaXPB+6fIhFqjAMhrxPBGOKa3+zHJ8zNTO3hbNpDMrV/DJFmVRE1wy
         /U/c6vC5GGBWRB3guGsQXVaArQ8Kpb1VLnQ/Y=
Received: by 10.150.14.8 with SMTP id 8mr2517580ybn.60.1279992229695;
        Sat, 24 Jul 2010 10:23:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 36sm1837860ybr.20.2010.07.24.10.23.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 10:23:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724140054.GB13067@vidovic>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151662>

Nicolas Sebrecht wrote:
> The 24/07/10, Jonathan Nieder wrote:
>> Nicolas Sebrecht wrote:

>>> What is the issue with the current status?
>>
>> Here is one:
>>
>>  $ git log --oneline -SListbox.font -- gitk-git/gitk
>>  $ git log --oneline --follow -SListbox.font -- gitk-git/gitk
>>  62ba514 Move gitk to its own subdirectory
>>  $ git log --oneline -SListbox.font -- gitk-git/gitk gitk
>>  207ad7b gitk: Set the font for all listbox widgets
>>  $
>
> I'm sorry, I don't get your point here.

If a person tries to drill into history to figure out the answer to a
question like "when was that code involving Listbox.font added", it is
totally counterintuitive how to do that now.

I run into this with git.git very often (you would think I would
learn).

I don=E2=80=99t have any argument with the rest of what you have said. =
 I
probably did not make it clear enough that I was not trying to
advocate for one side, only presenting pertinent information.

Regards,
Jonathan
