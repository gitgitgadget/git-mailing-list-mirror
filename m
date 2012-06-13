From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [Query] Update email-id in kernel source
Date: Wed, 13 Jun 2012 21:43:05 +1200
Message-ID: <4FD860A9.4000804@gmail.com>
References: <CAOh2x=k==ZjqQk4bvvviz4Uy7Xg2yn0A+9vbYJ63VJa4qMCodA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, spear-devel <spear-devel@list.st.com>,
	git@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 11:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sek6w-0005Jo-7o
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 11:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab2FMJmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 05:42:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46828 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab2FMJmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 05:42:37 -0400
Received: by pbbrp8 with SMTP id rp8so2052249pbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uP4dffREOWWe0v9yiWcIpeikFzlHOmiXNf5bPXOL4sE=;
        b=lLlcHfu7LJtiORQhEAu+Gc22GD3OuLnHEK/mHApNrk58AzHJz4l2ageLTFq9vj27K1
         0MbIfenMQ/iQzYQAJ8qkN+ZLpCPfD2E3xQ748W/acMqkYDZjLW/dtaxAyyhbOb37Sf36
         1dtb+fNko0a9X5p/UJadFrOhRPzfYdJtzjX3LfKm28PYT2e0gWTbQwssfp2h8N9oo0PE
         WwDGulkeKwkvnx2zzjCR/0SHl/A5IqwUzk/pXKvNhiY/UAh1Lx8mQTHcticP2v7cCbgJ
         clDqtP+4O8w27U8MVHaHBmlNjgh6Kg6qAU8A9gBmggv5nD6gU4Uvh8bmlKmiERsMK5KB
         GAzw==
Received: by 10.68.225.9 with SMTP id rg9mr48519627pbc.137.1339580556600;
        Wed, 13 Jun 2012 02:42:36 -0700 (PDT)
Received: from [192.168.1.66] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id og4sm5189929pbb.48.2012.06.13.02.42.32
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 02:42:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAOh2x=k==ZjqQk4bvvviz4Uy7Xg2yn0A+9vbYJ63VJa4qMCodA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199883>

On 06/13/2012 09:24 PM, viresh kumar wrote:
> Hi guys,
> 
> I have recently changed my company and am required to update my email address in
> kernel source.
> 
> I can only see one way of doing that:
> - Do a git grep, update all files, commit and post the patch.
> 
> Is there any better way of doing this that git provides, by which even
> 'git log' would show
> the latest id available? I heard from a friend but don't know if it exists.
> 
> --
> Viresh
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Not sure if the kernel maintains one but projects can use a .mailmap[1]
file to do just this kind of thing. You'd still have to update code if
you want people to get hold of you from MODULE_AUTHOR statements.

--
[1] - http://www.git-scm.com/docs/git-shortlog
