From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: zsh completion broken for file completion
Date: Tue, 02 Apr 2013 14:47:14 +0200
Message-ID: <515AD352.9060105@gmail.com>
References: <vpqtxowp9e2.fsf@grenoble-inp.fr>	<512FA915.4080203@gmail.com> <CAMP44s3=pHAUHohgJxddVdXMRj-toWOEvKea-E02mEZPBLk25w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 14:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN0dN-000165-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 14:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760510Ab3DBMrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 08:47:48 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:65007 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760480Ab3DBMrr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 08:47:47 -0400
Received: by mail-ea0-f173.google.com with SMTP id k11so204458eaj.32
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=8/QjiiR4iL1sN4ZYLrqn8v5ielnZEun4o83spPpSO4Y=;
        b=ENEuiia6IUVdLLhUwXDUSwsUuqAwCE1aPaUuU6SkkXmD8sq6e4WFTpZe/F+GUV0D35
         MKygeyAJ55ATdvP/+vrLjf+oJgWKcRS0lF/a6fNZom13HCUeae+jRFPfeDQAvCD7ZysD
         2JzqdcIfvRFECA9tX+20VgZ4r3OH0maRY/9LoleOeGxVoJCBtlav77bXRLT9AXt56Knh
         +UUHHuU4Od6lHIx3Kv4/JGfEcWWIo2aikp/+fjiSDVEVVejkTUUn7NfwcESkazpt1QlH
         6iq1IiFfAMyOtVWbTVQv45j+y85coK6Ytqp9U3NCYZnRgIK/tSf5Dn9eitGyufwCIJE0
         YdqA==
X-Received: by 10.14.173.67 with SMTP id u43mr48938933eel.22.1364906866219;
        Tue, 02 Apr 2013 05:47:46 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.222.134])
        by mx.google.com with ESMTPS id 46sm2491028eea.3.2013.04.02.05.47.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 05:47:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <CAMP44s3=pHAUHohgJxddVdXMRj-toWOEvKea-E02mEZPBLk25w@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219769>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 01/04/2013 11:29, Felipe Contreras ha scritto:
> 
> 
> On Thu, Feb 28, 2013 at 12:59 PM, Manlio Perillo
> <manlio.perillo@gmail.com <mailto:manlio.perillo@gmail.com>> wrote:
> 
> 
>     [1] Basically, on my system I need the following change at the end of
>         the file:
> 
>             -_git
>             +autoload -U +X compinit && compinit
>             +compdef _git git gitk
> 
>         I don't know the reason, however; and it seems that it is a problem
>         only for me
> 
> 
> Are you sourcing this script? If so, don't; do what is suggested at the
> top: use fpath to load it automatically.
> 

I'm using fpath as documented.

However I tested the script again, and now seems to work correctly.
It is possible that in the past I was using an incorrect configuration.


Thanks   Manlio Perillo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlFa01IACgkQscQJ24LbaUQOmACghDC30GqXXPIExHOPl9HrrO1y
BYgAn2QPAYvtsSAAiPpgMnmMRI3z0LE8
=kmm0
-----END PGP SIGNATURE-----
