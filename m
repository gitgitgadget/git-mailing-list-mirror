From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit: cannot push a patch - Python trace dump
Date: Fri, 15 Sep 2006 15:33:37 +0100
Message-ID: <b0943d9e0609150733v6cbe465esfd8d2b598c496768@mail.gmail.com>
References: <450A3524.5040403@intel.com> <tnxwt855wvr.fsf@arm.com>
	 <450AB81F.2090305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 16:34:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOElC-0000xb-Mf
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 16:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWIOOdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWIOOdj
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 10:33:39 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:25573 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751529AbWIOOdi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 10:33:38 -0400
Received: by py-out-1112.google.com with SMTP id n25so4099969pyg
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 07:33:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MmUV28cayP3deyApUmlpcnzRTm6mvo2J89En5RYOzCu4SgOwjpnjWaNlr0ukVEHRkbkbLvGt1ksm0sBE3LkKefFnkLMwxaWbWvfVJSws4Riaio7uA/fruAwc9w3/L19VZxTEGA0fTA6SRNwPNvNL+qlcYIXklb9GMpBpssKrLiQ=
Received: by 10.35.10.17 with SMTP id n17mr17404911pyi;
        Fri, 15 Sep 2006 07:33:38 -0700 (PDT)
Received: by 10.35.103.19 with HTTP; Fri, 15 Sep 2006 07:33:37 -0700 (PDT)
To: "Auke Kok" <auke-jan.h.kok@intel.com>
In-Reply-To: <450AB81F.2090305@intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27089>

On 15/09/06, Auke Kok <auke-jan.h.kok@intel.com> wrote:
> Catalin Marinas wrote:
> > Thanks, I fixed StGIT to cope with this and I'll update the repository
> > and snapshot tonight (which, BTW, will contain the initial support for
> > patch history tracking).
>
> awesome and awesome, allthough I have no idea what that (patch history
> tracking) is about :)

It keeps the history of all the patch modifications (like refresh,
push) so that you can get previous versions if something went wrong.
It's like having many small commits reflecting the changes to a patch.
These commits are totally separate from the main patch commit (so that
an StGIT repository is still compatible with GIT) but you can access
them with "stg log [--graphical] <patch>". The --graphical option will
automatically invoke gitk.

-- 
Catalin
