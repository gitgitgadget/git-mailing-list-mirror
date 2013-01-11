From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git-completion.bash: Silence not a valid object errors
Date: Fri, 11 Jan 2013 22:12:00 +0100
Message-ID: <50F08020.2010701@gmail.com>
References: <alpine.DEB.2.02.1301110304220.26739@antec>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dylan Smith <dylan.ah.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttlu3-0007FN-57
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 22:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab3AKVMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 16:12:19 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:54797 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3AKVMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 16:12:18 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so661413eek.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=q3r7zOhJfwPVnRLdGL0Jw03WAj9Wf6fJBpshvXCfOp0=;
        b=ed/zRZp2FZfKz+vichWn6nLcI6mebaAIiLKnuV2689rzBWHKEhS9hnOThrnpw3moWZ
         kdnQFTNPhTSZQPe9WPQzObu8XUp5j5uXQXEGQUNWTD9KWERhrZl8DwsT9Xgv8sKfaiyd
         2cbxAbp/uDWM5YJ9Gw/ImfH/wP6LccOWGipcJPL1nbxKWG72dyzGh/WnZEGkswbxQzfD
         68EHcm8d1/AZ8BcN//PQRaFMz3yO/95PtXhWiav2sYD0iEvZEx16BvT+QsNo8GlJB82d
         B7lxD76/LFe5oiOhXeGWb2E1yOoC/zXmUuXZbx/rW5iV4pbKXBwuYshlboeT+1Pu+/zz
         fhrA==
X-Received: by 10.14.177.1 with SMTP id c1mr203505787eem.8.1357938737235;
        Fri, 11 Jan 2013 13:12:17 -0800 (PST)
Received: from [192.168.0.3] ([151.70.220.147])
        by mx.google.com with ESMTPS id z8sm10035428eeo.11.2013.01.11.13.12.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 13:12:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <alpine.DEB.2.02.1301110304220.26739@antec>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213244>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/01/2013 09:06, Dylan Smith ha scritto:
> Trying to complete the command
> 
>   git show master:./file
> 
> would cause a "Not a valid object name" error to be output on standard
> error. Silence the error so it won't appear on the command line.
> 

I reported the problem a few weeks ago; thanks.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDwgCAACgkQscQJ24LbaUTAxgCfZbB8X8IaTZAcT8iTs1XIILBJ
72MAn2zlh3xbRa/wjq1WyA2yOiAlaCr7
=dMN7
-----END PGP SIGNATURE-----
