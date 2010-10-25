From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 09/10] gitweb: provide a routine to display (sub)sections
Date: Mon, 25 Oct 2010 17:15:54 +0200
Message-ID: <201010251715.54531.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-10-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOmS-0005Ha-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab0JYPQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:16:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42172 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab0JYPQG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:16:06 -0400
Received: by bwz11 with SMTP id 11so2451552bwz.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2C2f7wsTqvX400jFoOc8QNdDdnb0hlAxqcLBm8khY+c=;
        b=frN9NrDA5LhEDDW4MUOx9dBLh7KPQMqpoDrH4nwNyWs1QyAIwRxjKVwb94rqkmRV/9
         22Qixib5V5DEYbK96oizX/uP2TiDPahRuHzUgn2nIJDM02LEW1L35Q6jfZzWJlsTx3w5
         0oQB3cje0hLata7t+geRTP94AiSTKW+Yzk668=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qNHK4p43W9cBnM8Nivt7+AM+MAaxbYfGQuvPPCD/Y6joOEeK1pPymmE5YJgrPbpNJU
         FlfDVAj0crELNB6HvgWYEOBa/GJmkI4SfXE9gitP4YGXpRyCxWNMeRIurqxfH4ba3HQL
         FxeKSsHK8sQFoSAUu7+JdUnkeQwTFXri2XzHs=
Received: by 10.204.79.131 with SMTP id p3mr5243684bkk.178.1288019764044;
        Mon, 25 Oct 2010 08:16:04 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id u4sm4921885bkz.17.2010.10.25.08.15.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 08:16:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-10-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159959>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

[...]
> +# Group output by placing it in a DIV element and adding a header.
> +# Options for start_div() can be provided by passing a hash reference as the
> +# first parameter to the function.
> +# Options to git_print_header_div() can be provided by passing an array
> +# reference. This must follow the options to start_div if they are present.
> +# The content can be a scalar, which is output as-is, a scalar reference, which
> +# is output after html escaping, an IO handle passed either as *handle or
> +# *handle{IO}, or a function reference. In the latter case all following
> +# parameters will be taken as argument to the content function call.
> +sub git_print_section {

Very nice API.  Good work!

-- 
Jakub Narebski
Poland
