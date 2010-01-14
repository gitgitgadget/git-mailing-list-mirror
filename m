From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] status: only touch path we may need to check
Date: Thu, 14 Jan 2010 17:02:50 +0100
Message-ID: <fabb9a1e1001140802v7d1e535dn7cfca60c54ec7504@mail.gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com> 
	<1263481341-28401-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVSAH-0007wp-MJ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 17:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867Ab0ANQDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 11:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439Ab0ANQDN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 11:03:13 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35083 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab0ANQDM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 11:03:12 -0500
Received: by pzk1 with SMTP id 1so8385115pzk.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 08:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kOsCqfVkgNr+FxQu9R+4McbccrbBXJwo71QMpUVKUB4=;
        b=uU0dUgelg4cU0jt+rbffba0Yyxb8k4/aLrth5gIosZa6SycrE7fgDgYlMcezTPgKRf
         7UsHfWwT+h421ahhyMBmJ/+RZEaMLW9wBGinyko73QqxzX5CAJSX5zfz66lOTSL+BpBZ
         uVLj96q4EVVKYovlSdMxBoY69LJW/mcBW2ZbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v0uT8YFZvuEG/mcgndOFZ8bpbVPR46qQg2nX6734vs57G0mkYHKdc7CDz+Gi71LkNz
         bgkBw/g9LTCUeVnYDHQX0xM4zUCGIWBsL652xslbTsIR4MNYbTAgmgNFfxSqmz8udQnC
         1V+dwJFXVrJIF9x+iK6fNwvfvYnDzSI58BZ9c=
Received: by 10.142.121.10 with SMTP id t10mr645713wfc.308.1263484990145; Thu, 
	14 Jan 2010 08:03:10 -0800 (PST)
In-Reply-To: <1263481341-28401-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137004>

Heya,

2010/1/14 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> $ time git st eclass/
> real =C2=A0 =C2=A00m3.211s

> $ time ~/w/git/git st eclass/
> real =C2=A0 =C2=A00m1.587s

Wow, nice reduction!

--=20
Cheers,

Sverre Rabbelier
