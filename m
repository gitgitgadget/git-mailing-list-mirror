From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv8 6/7] gitweb: picon avatar provider
Date: Tue, 30 Jun 2009 22:50:42 +0200
Message-ID: <cb7bb73a0906301350u6c44628ds5bbee6b77abf7983@mail.gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906302223.23190.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLkI0-0006sd-Ax
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbZF3Uul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 16:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZF3Uuk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:50:40 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:43626 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbZF3Uuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 16:50:40 -0400
Received: by fxm18 with SMTP id 18so410776fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a82Bjlmldtt7p/edDF+E+VnY/PyIx1K1KEn/xyOvXy0=;
        b=L1H7KJsfDJiRU6UNj3AoHDvijhB/gRqUFtarxut+QT8N2D752HJLcHL8ttETV6+dz5
         GKoOddIXcM3jiK8Mg/uwk65smzIdfVFUFgjqspnD8o/Onwptus8LXH1gZ+QPTHHzBlxM
         nDNgFXVxDw/8xdTmBTk8z/LwWEIN3OBsdAor8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fwOqpFTJKVB7ueCSOUKIL/M+XrjjvM9ZJ8oHBX4CjVr7+xmOZU+4hj7HeFnrWUTtYt
         ilCC3H2OYFIzqzQArinq9jkiL/S/j9kVBzfTkqFJ5FWkp3F1moO39F8B+C+90Qvol8sw
         90N4m05DwjDpjN1+eaNwFFP2KbUsLgSnkayv4=
Received: by 10.204.70.135 with SMTP id d7mr8728067bkj.87.1246395042601; Tue, 
	30 Jun 2009 13:50:42 -0700 (PDT)
In-Reply-To: <200906302223.23190.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122542>

2009/6/30 Jakub Narebski <jnareb@gmail.com>:
> On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:
>> - =A0 =A0 # Currently only gravatars are supported, but other forms =
such as
>> - =A0 =A0 # picons can be added by putting an else up here and defin=
ing $url
>> + =A0 =A0 # Other providers can be added by extending the if chain, =
defining $url
>> =A0 =A0 =A0 # as needed. If no variant puts something in $url, we as=
sume avatars
>> =A0 =A0 =A0 # are completely disabled/unavailable.
>
> I see that you have updated comments too.

Well, I tried to address all the points that were raised during review =
8-)

--=20
Giuseppe "Oblomov" Bilotta
