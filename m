From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: skipping commits via commit-msg contents
Date: Mon, 12 Jul 2010 20:35:18 +0200
Message-ID: <20100712183518.GE17630@debian>
References: <AANLkTikYcODU96J-cVYCIad1yrd5zGklVj2OV4UT2PxC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:33:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNov-0004og-VU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0GLSde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:33:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:32949 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0GLSdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:33:33 -0400
Received: by ewy23 with SMTP id 23so907332ewy.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fDGWe2VvNPs7cNv3XGqx8tcvrXN00cmldraklgAoyE4=;
        b=eh2nZ5Ojn5gncvl0npb0rQB3rCkPrz/54Gl3IjWrjyPDAQ34jGx5mXbN+hhoCt5wzP
         DjCTxJud8FdmQNmsy9BIjqh4EvwmhDGpIFQvRED1PRvYnhT8j04qkZXQVE4yvWMr+wLT
         VxoVl+xtwo1A1eNX9CgZg2uvk2m1e3oBxu7DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GUKM1XKWfw5j4pEAjSQiEYqQApJM/MGIbNBpccDjOq5wkqsARYnalVZF8cqSfJvz91
         j4Ux+hNlks8tNBQknRg+upZkC47RnPFwsnHqOTyPsQ7VMuboaFElw0XQrtR4hD0evz24
         y3kNXYVmyZASiVAJ3bxM8QZJ6+EAlgediGlO0=
Received: by 10.213.26.13 with SMTP id b13mr8169885ebc.91.1278959611731;
        Mon, 12 Jul 2010 11:33:31 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm39341113eeh.9.2010.07.12.11.33.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 11:33:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikYcODU96J-cVYCIad1yrd5zGklVj2OV4UT2PxC@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150839>

Hi Jim,

Jim Cromie writes:
> sometimes its desirable to commit incomplete work separately,
> for example a struct change thats intended to get compiler to report
> where changes are needed.
> 
> if git bisect were to recognize  --skip-bisect  in the subject line
> (or in commit-message somewhere, say top or bottom),
> then bisection could proceed silently past such commits.
> 
> This would also allow rebasing a patchset to markup crappy commits
> which need further work.

This is perhaps not exactly what you want, but I thought I'd mention
it anyway: I usually prefix commit messages of temporary commits with
a "fixup! " or "squash! " and then use the `--autosquash` feature of
`git rebase --interactive` in a new branch before running `git
bisect`.

-- Ram
