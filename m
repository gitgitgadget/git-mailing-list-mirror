From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sun, 22 Jan 2012 17:03:30 +0700
Message-ID: <CACsJy8AucS9ez=-zej=72dr+0AVvGFR_eZgQcabitXgmQTJOCA@mail.gmail.com>
References: <201201212036.57632.tboegi@web.de> <7vsjj8acmh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 11:04:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RouHQ-00023q-OB
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 11:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab2AVKEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 05:04:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62118 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2AVKEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 05:04:02 -0500
Received: by bkas6 with SMTP id s6so1668905bka.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/QGirI3U3rjBtiiGYlEAVarQJ6hSX/t5GuQqE29gHfQ=;
        b=VcmBKIODVyjSCNfkO1b76YXPEahcqOpl2HIsCPDyuQUxQviWjO+BY06brcXZQWPkGF
         35mETZkFstmpSq3cuIufjpFiXkz1LgA51GONkFLC4Ao7y8mKqNtotJGa20QAdWqiA4oF
         7XZwNjyctjsBxR8sh6s2Rle6c4pIBjqsOaX58=
Received: by 10.205.133.133 with SMTP id hy5mr1611065bkc.94.1327226641156;
 Sun, 22 Jan 2012 02:04:01 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Sun, 22 Jan 2012 02:03:30 -0800 (PST)
In-Reply-To: <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188947>

2012/1/22 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>>> In order to prevent that ever a file name in decomposed unicode is
>>> entering the index, a "brute force" attempt is taken: all arguments into
>>> git (argv[1]..argv[n]) are converted into precomposed unicode.

Forgot one more thing. We have case-insensitive support in place
already, we can hook precomposed form conversion there before
comparing. In other words we just need to support
{pre,de}composed-insensitive string compare.
-- 
Duy
