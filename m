From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 2/5] Add string search routines from GNU grep
Date: Sun, 14 Feb 2010 17:52:48 +0100
Message-ID: <4c8ef71002140852g4966f35aq9a5aa0fda0247a9c@mail.gmail.com>
References: <20100213141558.22851.13660.stgit@fredrik-laptop>
	 <20100213142038.GC9543@fredrik-laptop> <4B76CBA8.5060504@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:52:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NghiJ-0007R7-Lx
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab0BNQwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 11:52:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:36297 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0BNQwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 11:52:50 -0500
Received: by fg-out-1718.google.com with SMTP id 16so165085fgg.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t4ryKjlu5VWefOpLum3q22M8gY4OCynamcHSOaPLHaE=;
        b=qQ2CxW43JZNw7c6mFJKkAw5Vhd2zwvbQDNlISdTxE6QBx6EYbKgsKSjYQc9sdYen8H
         yXnuu7PAcC0j7Oj0F+EiGkIwH5ilJY11av6CZlGh8sHN92hVtnlK6mC1Ef9AW3c/0W+E
         sO0Wz6bS2VtdfPIrJ4DQK8TGzzvRmLKWY9MDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PvPObrsyOynrZfIv+RX1yjMhK7Y+ZvzHKVB3DEkiesT6VGDT8lmm+1py5xA0zTTknJ
         NBEnrlNQrQuT9+Suctp/r+heOtaz4MyU/GO8le8J3YdsCIFuQScrtXoTEpXgmaJ6VCLB
         pwmNiPH+u578sp3DVIEYRKyIRrW6Nanl8yfC0=
Received: by 10.239.188.202 with SMTP id q10mr410328hbh.80.1266166368582; Sun, 
	14 Feb 2010 08:52:48 -0800 (PST)
In-Reply-To: <4B76CBA8.5060504@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139927>

On Sat, Feb 13, 2010 at 16:56, Paolo Bonzini <bonzini@gnu.org> wrote:
>
>> + =A0 This program is free software; you can redistribute it and/or =
modify
>> + =A0 it under the terms of the GNU General Public License as publis=
hed by
>> + =A0 the Free Software Foundation; either version 3, or (at your op=
tion)
>> + =A0 any later version.
>
> You need to use the last GPLv2 version (commit e7ac713d^ in the GNU g=
rep git
> repository). =A0It doesn't change anything except the copyright heade=
r, but
> let's do things the right way.

Thanks. I will use the GPLv2 version in the next iteration.

- Fredrik
