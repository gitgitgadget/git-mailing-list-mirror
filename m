From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] clone: Deprecate the --recursive option in favor of --recurse-submodules
Date: Wed, 03 Nov 2010 15:13:47 -0700 (PDT)
Message-ID: <m3aalqgion.fsf@localhost.localdomain>
References: <4CD1ACF7.6040108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDlag-0007FS-2r
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab0KCWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 18:13:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63877 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab0KCWNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 18:13:51 -0400
Received: by bwz11 with SMTP id 11so1070915bwz.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ERjkarADKTikhvR3INaxChybDdz1vscsIBjBaIz0MPw=;
        b=XFxJ2+hQJ4i1V5OmdGRbNKwTof/H/ENzRCe7CLyXhk/JUNL1de1ImKz9wMJFpcm0i1
         0viM4PDgYaenqu2Hic1g9HhJVVseT/6l8b+fpfxpY9YWFJ4s6jl+CG7lki61oMo778P7
         yzWoyWnuMoUQSLMfxaims3cGx3trZ8RPBCPbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=apD5kE63r38knjjtXYFPnrBHCZa0XI15IrRvp06fTg9VfqGq7Hr9lpGc+G0zHNIum8
         SL5hKsB4OHmqUVZQCMRwHcfzqstNHGabJWx1OmoLoCvsa2m2hRpvhfEDfFRCV3punOvJ
         Ef+yPIyNLnxYahOM5Tmm4oH5pWfz9VKwhHiGo=
Received: by 10.204.53.9 with SMTP id k9mr12905386bkg.102.1288822430100;
        Wed, 03 Nov 2010 15:13:50 -0700 (PDT)
Received: from localhost.localdomain (abvz101.neoplus.adsl.tpnet.pl [83.8.223.101])
        by mx.google.com with ESMTPS id u4sm6060211bkz.17.2010.11.03.15.13.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 15:13:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA3MDE6C012174;
	Wed, 3 Nov 2010 23:13:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA3MCv70012169;
	Wed, 3 Nov 2010 23:12:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4CD1ACF7.6040108@web.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160643>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> @@ -65,6 +65,8 @@ static struct option builtin_clone_options[] = {
>  	OPT_BOOLEAN('s', "shared", &option_shared,
>  		    "setup as shared repository"),
>  	OPT_BOOLEAN(0, "recursive", &option_recursive,
> +		    "initialize submodules in the clone (deprecated)"),
> +	OPT_BOOLEAN(0, "recurse_submodules", &option_recurse_submodules,
>  		    "initialize submodules in the clone"),
>  	OPT_STRING(0, "template", &option_template, "path",
>  		   "path the template repository"),

Shouldn't we use PARSE_OPT_HIDDEN?  Or should it be left for later?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
