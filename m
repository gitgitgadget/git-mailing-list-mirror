From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Sun, 5 Sep 2010 01:55:44 -0500
Message-ID: <AANLkTimf_EJcZtJk_X7FiKqQy-oRU4NvZsXMCEcsB=Wa@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os99N-0001z8-OE
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab0IEG4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:56:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51781 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab0IEG4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 02:56:05 -0400
Received: by yxp4 with SMTP id 4so1229601yxp.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MzpHxkPTbyW4R4OBQmLQ9Vb8/pR44N6vtAOQSWD6eOs=;
        b=IBeQXfHlkDiEmhV/aQUzUYVWazueht2XB5B1wHm2E/2GaLwvCf5LSEOoSkLt0JI/b/
         6JlkGUC3FF3bj6tW1JglC6fuArv6LyzIsfl2CJZjfze7B7UC3FJCkw2fCf1KkOkkTiLP
         nUMYQWx8euUGv5EcfcVOyO30fYjXswvBUjxvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KWzsELm9brUO+0k97EPX7FVfY8nziFHNdZ/9MEMe8DH/7kOpOr+NDxKoMqYCDJBpjZ
         rgZZKfurHQjRRFt7LIj9i2GLXulN80QtrwhhQ4SrVQbmrGxTfbZkQxim5R7Ix7+w8Bpd
         ebDGBlTRiYfdtX82KCBKl0wpDwum7FpjMqxKg=
Received: by 10.150.138.2 with SMTP id l2mr807930ybd.41.1283669764106; Sat, 04
 Sep 2010 23:56:04 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sat, 4 Sep 2010 23:55:44 -0700 (PDT)
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155444>

Heya,

2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> Tree generating from index, Elijah merges the base tree inside
> write_cache_as_tree() while it does it inside commit_tree(). Again th=
e
> principle is pretty much the same. I'll see if I can resist from
> stealing some more :)

Why don't you two combine your series instead? :)

--=20
Cheers,

Sverre Rabbelier
