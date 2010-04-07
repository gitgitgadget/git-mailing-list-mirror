From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 7 Apr 2010 18:15:55 +0200
Message-ID: <w2w4c8ef71004070915td320f46as66da08712c6aaa91@mail.gmail.com>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
	 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
	 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
	 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
	 <20100407031655.GA7156@spearce.org>
	 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
	 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
	 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
	 <20100407144555.GA23911@fredrik-laptop>
	 <i2sfabb9a1e1004070827m2745f9ccz5976664852eabd3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:16:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXv9-0004jM-6G
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656Ab0DGQP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 12:15:58 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:48291 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932539Ab0DGQP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 12:15:57 -0400
Received: by fxm23 with SMTP id 23so1200331fxm.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sWk0Bdf+hzNJYLi7x3v20IKm0ovnzUlqjQv4M3iAcQ8=;
        b=mtfgEAWXGj8g+ceWTgBVlS9k2i1T/RX3CvQ10qQKcCD9AvVFRUC+L5TQQRKgs5Yq5h
         vwzom7oMe0F0bSWK5D/9S+NqyhQuRdJtgJWC3mP0Plg9OaSOK4Knp7bcTBVfPufgKkdA
         nLg4d7rmA4vjTvLw67eBnbZcmDSFuKau1RZeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W7wqQSZ1QwpZh+VAOys4xbbEr0qFXOt8XnDXdoOaT+/KGwtqK6RMTy5xDE7nVPJtBB
         NzwN+RlWgPJJdu9aWztllAb3wVmCxDqQYKAcFyPWioq++C/ClWfvBAiXGlhRSBUhVYzj
         rlxloxGpKwM3wd7i4jSgt3Pgh/uBizs2HQZVU=
Received: by 10.239.140.138 with HTTP; Wed, 7 Apr 2010 09:15:55 -0700 (PDT)
In-Reply-To: <i2sfabb9a1e1004070827m2745f9ccz5976664852eabd3b@mail.gmail.com>
Received: by 10.239.135.78 with SMTP id c14mr800080hbc.187.1270656955956; Wed, 
	07 Apr 2010 09:15:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144245>

On Wed, Apr 7, 2010 at 17:27, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> On Wed, Apr 7, 2010 at 09:45, Fredrik Kuivinen <frekui@gmail.com> wro=
te:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("pthread_mutexattr_settype failed:=
 %s", strerror(errno));
>
> Can't you just die_errno here?

Ah, yes you are right. Thanks.


- Fredrik
