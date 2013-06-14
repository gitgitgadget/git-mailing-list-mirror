From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 20:41:12 +0530
Message-ID: <CALkWK0mF7s7Zfp4VTekT9AhHNhd80Jj3GT8SaKVs4gAATACsBA@mail.gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
 <1371196058-23948-2-git-send-email-artagnon@gmail.com> <7vli6crau5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVfS-0008VT-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab3FNPLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:11:54 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:34382 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab3FNPLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:11:53 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so330981bkc.29
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HxRLxD54srO8UJlnjwcsWsa9zVKyDZXZvxilOzyUysQ=;
        b=wVbrJNNuxoTKt5/aRo3DSnefItgGnVi6d90rrIuqe5ULzBlWTAgUAmsdqUhGNu4d48
         ICeTo7Lxq5bGLDP1PXPZfCuBd31URv4Rxvfe39/NXh08wyo+7w0Wahok1QYekTTQ8Eb4
         bokeWEfk8+1OVGVU6I4or11114EpMjFIiPSDh4xHMb/sprNLtB6QBpxS+Yi1i9tM90Dr
         rEKAMy+FGvXoJF0UWO3WtPBzRtT6Ntg0n+cTRQSiyhsn449ADYViREtaeJrp8dkBf5Ds
         Nu2l3tzK20YXkm6mEwpiVjrakuo7UI+R4yuxL7CGOqIGKfRzEKUEGROJjNZurjyifM4v
         tomg==
X-Received: by 10.204.69.12 with SMTP id x12mr417735bki.14.1371222712696; Fri,
 14 Jun 2013 08:11:52 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 08:11:12 -0700 (PDT)
In-Reply-To: <7vli6crau5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227882>

Junio C Hamano wrote:
> These two case arms are indented one level too deep (will locally
> touch up).

Thanks.  Can you tell me how to get shell-script-mode to indent the
case statement properly? (I used the default indentation)
