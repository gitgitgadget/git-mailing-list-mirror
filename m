From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] Makefile: add missing dependency on http.h
Date: Mon, 9 Aug 2010 12:01:06 +0800
Message-ID: <AANLkTik-vjj0Nbv7XJoeiZo5W6E+ygk58C8KDpDJnAru@mail.gmail.com>
References: <20100808211910.GA7210@burratino>
	<20100808214859.GC6962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 06:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiJYE-0007A0-Ge
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 06:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743Ab0HIEBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 00:01:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51431 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab0HIEBI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 00:01:08 -0400
Received: by eya25 with SMTP id 25so3292074eya.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aX+ktmZ8NN7QJoySuZdCKZAqAhxHvvJ12bkthA8y1rs=;
        b=p3x6ajDa/9Epihez3l984Oj7dsKYPAzx4KnwqzVJYV8rnh6dBBXewUoJ4e9gbUCKZo
         7TEl55ZCEHcKxuTRwav7W1D3sjvFLgpS1cEl1LYtEtAutf4BNSQZFbapzWd0YYjY91l6
         BEyATet7VFvZXzyiQxYitcB1ClOb+z7qnPqOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pxb/ySwev2p08zFvKQ4DBtjuUL1tasMoUVIPJEMjrJ6mF8YJqUgsS+2ohLWpJwPN39
         7IQqW4aqLkbh1O3Bb7b2KaOuE6qqTx7MSOvv4bQ2Xni7vlpifLbmjiB9yXcvqASVeOrL
         +2GRy8989q23DuLTXjEnDaUNVP28UckfeAM00=
Received: by 10.213.25.143 with SMTP id z15mr11617059ebb.68.1281326466222; 
	Sun, 08 Aug 2010 21:01:06 -0700 (PDT)
Received: by 10.213.15.72 with HTTP; Sun, 8 Aug 2010 21:01:06 -0700 (PDT)
In-Reply-To: <20100808214859.GC6962@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152948>

Hi,

On Mon, Aug 9, 2010 at 5:48 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> v1.7.1-rc0~65^2~2 (http: init and cleanup separately from
> http-walker, 2010-03-02) introduced a direct dependency from
> http-fetch on the HTTP request library. =A0Declare it.
>
> Detected with "make CHECK_HEADER_DEPENDENCIES=3D1".
>
> Cc: Tay Ray Chuan <rctay89@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Whoops - thanks for catching this.

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

--=20
Cheers,
Ray Chuan
