From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to
 existing values
Date: Mon, 16 Jun 2014 11:35:11 -0700
Message-ID: <539F38DF.3090004@gmail.com>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Robert Clausecker <fuz@fuz.su>,
	Alex Riesen <raa.lkml@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwbkb-0005KX-3n
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbaFPSfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:35:20 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:63965 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbaFPSfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:35:20 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so3014802pad.9
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+Iqh4cZNB4QUfqY/VCAxnUri7w7umJYjyVJkBkSeeag=;
        b=nZK4T6sR5TlEvEQ6dvuCyyCDOGvmvUaqCTVW2XXTDCX12O9ROXokyXU3mw0OkJt/C2
         nmwXczrxBWeNiHCwNx31Vtc3tJ9bzoSnISavpNz/siyrupKOr/iQKJ+ZufDLeO1mFPrY
         C3Pl+HjEnf2ZRvYaY7NQiCXaCH0orECM85RRWCPU7S6Q7iWQ+4xKgHa8O7TLHPbro5lu
         LbESUoWow2qUx/6ejWGZMEjrk7x4xf+g9KdSAezVvyl9m2dy7qJvz/JKChMixU7mIswt
         s8ImrIYBTh4rbFttQ2Yxsg834IkVNMOWt/eeswK0749yXld5byxp66YSe5bC4RRm94y2
         blYQ==
X-Received: by 10.68.226.105 with SMTP id rr9mr6687987pbc.161.1402943719465;
        Mon, 16 Jun 2014 11:35:19 -0700 (PDT)
Received: from [192.168.52.163] ([117.254.222.96])
        by mx.google.com with ESMTPSA id gr10sm20000906pbc.84.2014.06.16.11.35.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 11:35:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1402922952-172-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251796>

On 06/16/2014 05:49 AM, Philip Oakley wrote:

>  	Pass a configuration parameter to the command. The value
> -	given will override values from configuration files.
> +	given will override single valued variables from configuration
> +	files, and append to multivar variables. Previous multivar values

Nit: Forgive me if I am wrong, but `, and` is used for joining two independent
clauses. It would be better to drop the comma.

> +	remain in effect. Use "insteadOf" style config variables when an
> +	over-ride is needed.
>  	The <name> is expected in the same format as listed by
>  	'git config' (subkeys separated by dots).
>  
> 

'insteadOf' is a very specific approach for a general suggestion because it is only
used in url.*.insteadof in the whole codebase. Also, it has a variation described in
urls.txt as "pushinsteadof". So, if a problem such as mentioned above arises in
a different scenario 'insteadOf' cannot be used in it.
