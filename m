From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Mon, 15 Jun 2009 20:56:25 -0400
Message-ID: <ca433830906151756s7c3f8a1cge360a9d7a08562d1@mail.gmail.com>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
	 <1245033541-15558-2-git-send-email-lodatom@gmail.com>
	 <alpine.OSX.2.00.0906151927010.816@xor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karsten Weiss <knweiss@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 16 03:25:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGNQL-00076c-M1
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 03:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbZFPBZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 21:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbZFPBZH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 21:25:07 -0400
Received: from mail-fx0-f211.google.com ([209.85.220.211]:57457 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbZFPBZG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 21:25:06 -0400
Received: by fxm7 with SMTP id 7so310762fxm.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cdkzyNjh9a+7t78XuUNW9DvuJMuc0PYq4VRjG80DIgQ=;
        b=xdCyPRAkPdHlJfDsCw6JQjB8bItYRk31qpVsnMNbacglNrP9af5itOG1bJVGW6y6TN
         oHmZnCCx7/8tovTm0E/4fNj440s5kX9+KgejX2czVePhaNg1aChW9exFhKLhZ2PGO5cg
         kQhkzzdtTfHG1cCA0yQMpB1lVxxfNTg6gxMlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KqzRBHKtCNDPbf82CDb68KMuE4+MZrTLSYnMmePtYF9pJkYhkzLFWvW1WT8qrMMVfg
         E5/yUHx+QpK6yWGpNbY7xZ5wJYPzQytW1Psu4dwQdcNTPVr2yt8m0sjwIXV8o/6Ku+wM
         yXo7n3+lfTz41DGxRENITtN9aqUw4rdjxMkAg=
Received: by 10.223.106.14 with SMTP id v14mr4812770fao.49.1245113785946; Mon, 
	15 Jun 2009 17:56:25 -0700 (PDT)
In-Reply-To: <alpine.OSX.2.00.0906151927010.816@xor.localnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121644>

On Mon, Jun 15, 2009 at 1:43 PM, Karsten Weiss<knweiss@gmx.de> wrote:
>>> +http.sslKeyType::
>>
>> + =C2=A0 =C2=A0 =C2=A0 Filetype for SSL private key. =C2=A0Must be "=
PEM" (default), "DER", or
>> + =C2=A0 =C2=A0 =C2=A0 (if libcurl >=3D 7.13.0) "P12". =C2=A0Can be =
overridden by the
>> + =C2=A0 =C2=A0 =C2=A0 'GIT_SSL_CERT_TYPE' environment variable.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KEY

Whoops - thanks.  Sorry for that typo.

Mark
