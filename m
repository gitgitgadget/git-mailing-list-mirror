From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Tue, 24 Feb 2009 10:35:17 +0200
Message-ID: <94a0d4530902240035n1145f4b7k25cd6bdf1123028@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
	 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
	 <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
	 <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 09:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbsmX-0003c4-TJ
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 09:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZBXIfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbZBXIfV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 03:35:21 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:60344 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbZBXIfU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 03:35:20 -0500
Received: by fxm11 with SMTP id 11so2569173fxm.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O5fvDAQ0jgaczHvWVq6+x/wvK3ylyxQ1ZEaMwpJoyfQ=;
        b=u26h8atdoeGtVUCCApLqlvmzFfkpNgtwBZhPRlvOKZbWONbzZoY9d2ESDlcOhDIW0H
         ZNrl3nV6c/P+/0562cnKl+uJvKM9h/xztcQbp7oTWWYipG6lerNj2rOf4K8b2sAT7CtE
         3qQvuy734CSt0qgkfrgykQMK79qSSBvGTfkoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KH1sAnoBj8gj6Zno+MznW9CCkLmcy5EzGGwW7HHTnoHQp/GSazZYh6Li3HaSm9zTZs
         BZE1gEsup+lZqWOQWAxzvzKXsDX8yWT6Miwg1IYZdPW8AmI+klQUdfvxJLNluOub76ah
         Ev5K3ezeQffuVfcv/N9ynLwvoJupkHtLig+4A=
Received: by 10.86.98.18 with SMTP id v18mr3529852fgb.46.1235464517271; Tue, 
	24 Feb 2009 00:35:17 -0800 (PST)
In-Reply-To: <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111237>

On Tue, Feb 24, 2009 at 3:33 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> People already are used to finding the shed in the scenery by look=
ing for
>>>> that original color, however ugly the color might be. =C2=A0The an=
swer to your
>>>> question has to become quite different when you take that into acc=
ount;
>>>> otherwise you are being irresponsible to your users.
>>
>> People somehow got used to the ugly color, they'll get used to the
>> pretty one, in fact, they would probably like it better, and maybe
>> even thought more than once on changing it.
>>
>> If they're the kind of people that don't like new things they'll
>> probably not be using git anyway.
>
> You do not have to send two messages in a row to reaffirm that you ar=
e of
> irresponsible kind. =C2=A0I heard you enough already.
>
> Go away.

After sending the email I realized I didn't answer your argument about
people already used to the existing stuff.

I might sound too aggressive on email, but my intention is not to
attack anything or anybody, just improve things.

--=20
=46elipe Contreras
