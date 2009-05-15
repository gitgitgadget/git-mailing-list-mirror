From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Fri, 15 May 2009 17:21:42 -0500
Message-ID: <ed82fe3e0905151521m64df542eifca87073c4360fbf@mail.gmail.com>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com>
	 <20090515211611.27697.82605.stgit@localhost.localdomain>
	 <4A0DDD94.1010901@freescale.com> <200905152336.49319.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 00:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M55mp-0001ZX-Od
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 00:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbZEOWVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbZEOWVm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 18:21:42 -0400
Received: from mail-qy0-f129.google.com ([209.85.221.129]:54021 "EHLO
	mail-qy0-f129.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbZEOWVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 18:21:41 -0400
Received: by qyk35 with SMTP id 35so575320qyk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 15:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=myi0k68YLeGEZ/w73PUrl3BKQ6/CK8qqZY3dSBlaayE=;
        b=dD+oBmyPpP4qtDAkGfFtOFRzOgeHLKwB1AsXeY3XPgE/cjO4IXYGOEJ+ZuQZaBsqNU
         eBgITQpNDCvE7/3vIr2EzyBeCJXWDh2MLvTB5PHCVTtIjy1zVrXJl6+gsacPkUCuW9cP
         ZyCZr3G2lw8f4ubHTT8cfMuVTAGTGy1XIZx20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ec2sOvgTOx5ERhTnpMdkd89AsYfVocU7H2mPcXSTmgUgowB/YtgNQnL2ZvgczBEGeQ
         rBXHmtz35Rs+jICG2TSyrW8lYU9oWl8bV3GlYZ7V9VJ7XF712K8FhLkhYG95qv4LecQD
         HzszShPIEDmK3MGFumxZDhh4EhLlVGY4y9pj8=
Received: by 10.229.96.15 with SMTP id f15mr2230801qcn.91.1242426102560; Fri, 
	15 May 2009 15:21:42 -0700 (PDT)
In-Reply-To: <200905152336.49319.jnareb@gmail.com>
X-Google-Sender-Auth: da5fb9724e3e9906
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119305>

On Fri, May 15, 2009 at 4:36 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Gitweb can deal with non-bare repositories. It is only that because
> gitweb is not interested in working area, it shows $GIT_DIR (path to
> repository itself) as name/path to repository. Therefore repo/.git
> for non-bare repositories, because it is repository itself that matters.

I understand that, but why does gitweb have to punish me because I
give it more than it cares about?

> If you provide access for others, i.e. if those repositories shown in
> gitweb are public repositories, it is much better to use bare
> repositories for that.

Why?  What difference does it make if they clone directly from my
working tree, instead of some shadow repository?

-- 
Timur Tabi
Linux kernel developer at Freescale
