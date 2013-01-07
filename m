From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Mon, 07 Jan 2013 14:43:22 +0100
Message-ID: <50EAD0FA.4050401@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se> <7vobh4sffw.fsf@alter.siamese.dyndns.org>,<7vehi0qh4x.fsf@alter.siamese.dyndns.org> <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 14:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsD1Z-0005zM-MU
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 14:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab3AGNpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 08:45:38 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:45744 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3AGNph (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 08:45:37 -0500
Received: by mail-we0-f179.google.com with SMTP id r6so10219853wey.10
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 05:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=gTohQgd7g7ig6b+nbYspMwESww4tB2g4SasFn5GhbYs=;
        b=OWHCr58oUUK83CyF0FdEgoqS7OkH7bYsEk8kD1THi2m5djyK6PJFHKChDoe7kn+cIZ
         n3KpJRpw+8OlqqjiO5qN4orWTOEKckHf87pAitaqGAYD4YSllagGaSobNI7Zw+bA1pmo
         WiAMaAznVNLbWG6tKd7rlTgobMsCgPhnodsOUwHDuuiZdkjXTPACDZU1e4qhGjWgbxU4
         oX/abOXiBT8XCmBxWimGvNyBQRtcqzQRLSdPm3A2XI3udNpSY/8SsTh+8oBLEx7x50z0
         U+mjmGoR+9dI8mqQgB//bvOiKh5k6iv/Zn4GpTkVTe6HwZYbSJ9n+LXXWXt9yzAKwfoL
         OTpQ==
X-Received: by 10.180.103.136 with SMTP id fw8mr9236961wib.27.1357566336314;
        Mon, 07 Jan 2013 05:45:36 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id hg17sm12261130wib.1.2013.01.07.05.45.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Jan 2013 05:45:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212893>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 21:23, Marc Khouzam ha scritto:
> [...]
> Below are two suggestions that are in line with this effort but that are not regressions.
> 
> A) It would be nice if 
> git commit -a <TAB>
> also completed with untracked files
> 

$ git commit -a foo
fatal: Paths with -a does not make sense.

So
  git commit -a <TAB>

should not suggest untracked files; instead it should suggest nothing.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDq0PoACgkQscQJ24LbaUSTNwCfWt7a1Tdg9u5sd6B3FXCEFj1/
sBwAoIv4B2y4MUQgLNafY2PTWx4giSfD
=tb3O
-----END PGP SIGNATURE-----
