From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH compatibility
Date: Mon, 11 Mar 2013 18:12:57 +0100
Message-ID: <513E1099.9070104@gmail.com>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr> <7v38w1c3ms.fsf@alter.siamese.dyndns.org> <7vobepany3.fsf@alter.siamese.dyndns.org> <vpqtxohubmb.fsf@grenoble-inp.fr> <7vfw01an1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 18:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF6I6-0007do-E4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 18:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab3CKRNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 13:13:07 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:34051 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab3CKRNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 13:13:05 -0400
Received: by mail-ee0-f44.google.com with SMTP id l10so2376197eei.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=lIBIQaAu8N2C8s/s/hDfvZYGo6mLO9VTBqhiXEIcPa8=;
        b=LtyinsBOtnJZRXYYA4EOJml+7f1IdZd/CLvAyWbYau8cg1j4ytLwtrQKPIbD/jceLo
         4uZZoUy+bbrJrFLRVHhnXS8x4goSWjUA8uTsJZUKCat7L8G/R+AdvDrwy0pph1zE34Ym
         z4oPerRPSlLIjkbA7OF2GGhToumLy9H9vBNF3czpmTgKITHj3PxTRgWyfH5ZdwGXIdfg
         /v7uU6LS3QOOu59Dw+8qzAbynCuvTzbiXMajxBGgw5L8qeZmbKjAWncL3gfsnTc/hTc3
         Yek3020WSq3tXuIwoxbhchrNkF+jOzALH4yAcEx0qSRomPLiW9D266a+r5vfJoLlQNpq
         3/cA==
X-Received: by 10.14.216.198 with SMTP id g46mr23687190eep.30.1363021983516;
        Mon, 11 Mar 2013 10:13:03 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.200.211])
        by mx.google.com with ESMTPS id 44sm24723039eek.5.2013.03.11.10.13.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 10:13:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vfw01an1b.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217894>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/03/2013 18:01, Junio C Hamano ha scritto:
> [...]
> Having to restrict to the common subset means that whenever bash
> adds new and useful features that this script could take advantage
> of to improve the user experience, they cannot be employed until zsh
> catches up (and worse yet, it is outside the control of this script
> if zsh may ever catch up in the specific feature).
> 

Maybe, to avoid this problem and code duplication (the main reason bash
script is sourced, as far as I can tell), it may be useful to add
additional reusable git commands, for use in shell completion?

E.g:
	git suggest <cmd> *args

returns a line separed list of filenames affected by cmd.



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE+EJkACgkQscQJ24LbaURjNwCfdW73fET/n4FRGftKcSJPsK7M
nu4An1CC0dspGxLe5zqR9BdXBBDHWl/Y
=11j7
-----END PGP SIGNATURE-----
