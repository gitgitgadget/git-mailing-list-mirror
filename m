From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 7/7] Make 'stg pull' use git-fetch and not git-pull.
Date: Wed, 31 Jan 2007 23:44:07 +0000
Message-ID: <b0943d9e0701311544k22986545x351c04a8faab8814@mail.gmail.com>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
	 <20070129230555.7102.93948.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 00:44:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCP7e-0005rj-Ki
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXAaXoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbXAaXoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:44:09 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:49558 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161095AbXAaXoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:44:08 -0500
Received: by an-out-0708.google.com with SMTP id b33so236444ana
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 15:44:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S15KcVrFIpK+fEUUBVGKcJ+kfqhZq2Q1szlrDfloH80TeZOgvZcMzv8O10h9LOgg1w3I5MMke95KoQ8F2B/Z+pgJQaO0J9chhpqZz1W2cIx8pGl9WBSyvY5NoQcESdAAD0Se5gt8buZKXUMfAg0csCZzkRhhX9NKUsHG84a9Gks=
Received: by 10.114.195.19 with SMTP id s19mr106260waf.1170287047520;
        Wed, 31 Jan 2007 15:44:07 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Wed, 31 Jan 2007 15:44:07 -0800 (PST)
In-Reply-To: <20070129230555.7102.93948.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38309>

On 29/01/07, Yann Dirson <ydirson@altern.org> wrote:
> We introduce a new pull-does-rebase setting, as companion to pullcmd.
> This allows to use both pullcmd's that need a rebase (like git-fetch)
> and pullcmd's that do not (like git-pull).

Thanks for the patches. I applied all of them but I have a question on this one:

> +    if (config.get('stgit.pull-does-rebase')):
> +        # FIXME!
> +        reset(tree_id = rev_parse(repository))

Why the "FIXME" here? The alternative is switch() and it might be safer.

-- 
Catalin
