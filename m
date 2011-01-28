From: Tilman Vogel <tilman.vogel@web.de>
Subject: Re: [PATCH] git-gui: add config value gui.diffopts for passing additional
 diff options
Date: Fri, 28 Jan 2011 01:19:33 +0100
Message-ID: <4D420B95.2060509@web.de>
References: <1295607585-15971-1-git-send-email-tilman.vogel@web.de> <87ipxdn81f.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jan 28 01:19:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pic41-0004xN-C1
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 01:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab1A1ATj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 19:19:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56384 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1A1ATj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 19:19:39 -0500
Received: by fxm20 with SMTP id 20so2771243fxm.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:message-id:date:from:user-agent
         :mime-version:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        bh=zYk9pBM1QfUssQMwmfNUJpACjFcXUGWDA+A/c7zYeGQ=;
        b=D29adTucb7uOlX1y2rcxp8ylxlAb+PGs9HzcBTUqJhmOpc1DxWrNTK7D2nFbgxZP+A
         pDxkEBuKUfXE2b8PQ+IPCD+M7vdlxiF2336WlUKgO5KY72ULLdmL40WihiGhhBVqQYOh
         h+MleSPvkP5KfwINFLPrs60RB7etN5lCScfbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ZsYj5gDESZWHkX/zR545sRq3cLjgnsaIKKUpFnEpDBYZ76wUcp0JzFP1DuhveJUKW/
         qdqcoywxRGXLnZfClxcmz/npH+vRl5XZlwLh4vHK1skGAlnnzsN7jLHODiwdXaY8tLlx
         YDNaMPFxN7kXTNNXeFJWnOvxIimDaud0tuI3Y=
Received: by 10.223.85.203 with SMTP id p11mr1631116fal.108.1296173977002;
        Thu, 27 Jan 2011 16:19:37 -0800 (PST)
Received: from atrium.lan (e178201102.adsl.alicedsl.de [85.178.201.102])
        by mx.google.com with ESMTPS id o17sm6241666fal.25.2011.01.27.16.19.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Jan 2011 16:19:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.11) Gecko/20101013 SUSE/3.1.5 Thunderbird/3.1.5
In-Reply-To: <87ipxdn81f.fsf@fox.patthoyts.tk>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165599>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Am 25.01.2011 01:25, schrieb Pat Thoyts:
> This seems ok but you don't say what it is for. Why do you want to be
> able to pass additional options to git diff?

Sorry, forgot to copy the motivation from
<https://github.com/git/git/pull/8>:

I want to be able to make diff ignore whitespace changes "-b". But maybe
someone else wants "-w" or what not, so I think a generic option field
is most versatile.

If you feel, this switch should be easier to reach than through the
options menu, I agree, but I am a Tcl/Tk newbie, so this was the easiest
fix for me.

> I can apply this to git-gui's repository. The Documentation change will
> need to be sent to git separately once this is merged from git-gui.

Sure, I would be happy. However, if you feel like coding up something
that's easier to use, I'd be even happier. But maybe the generic field
is still of use.

Regards,

Tilman

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk1CC5UACgkQ9ZPu6Yae8lknCwCfcEfBH8uSSZbB93IHpJiEivll
zlwAoKgPswZGMf6fERRB8p24TsLCGA1r
=uWHw
-----END PGP SIGNATURE-----
