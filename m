From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: No way to resolve git am conflicts.
Date: Sat, 8 Jan 2011 10:36:33 -0600
Message-ID: <20110108163633.GB28898@burratino>
References: <ig9nqq$4ib$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 17:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbbmZ-0006Mp-Eb
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 17:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab1AHQgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 11:36:41 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59263 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab1AHQgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 11:36:40 -0500
Received: by iwn9 with SMTP id 9so18056296iwn.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nXpsIzSq8ncmKc37yQjKNO4Rlq3GTyfAPX4LcF4URYE=;
        b=xR5xpNI+FML6bsWy5jOaYWtqTkgO/HQB5WSzq9sIcL5egnSNme1rzjtqw3OIIFesX/
         7NScGj5odOFVrK7na1FS8/Iels/UVu/2sUcUxoXctfqrLVMAaHRZEgHCR5TCRPc/tq+x
         8MqaKWY8SIQGU07TOapGf/shlm6JFPSvq29fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F92dxntxngxRbrUGTqswe4wTixo9vI2ASKo2csOwKTwf6UvReEyHSftiNPSyffFGnN
         buOADrzV96S1P0lW0SA2yfyh+dvmhX5KKMdYzqI9v22nQrewJ7nKPOKrLFgxvWTRarsr
         IJXgnWKhJZyx+9mhA1h3EPi9XniFMlUw+ssLI=
Received: by 10.42.241.3 with SMTP id lc3mr2208493icb.347.1294504599804;
        Sat, 08 Jan 2011 08:36:39 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id z4sm24209199ibg.19.2011.01.08.08.36.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 08:36:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ig9nqq$4ib$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164831>

Stephen Kelly wrote:

> git am the.patch
[...]
> Applying: Introduce new configuation option to override committer 
> information
> error: patch failed: builtin/commit.c:1352
> error: builtin/commit.c: patch does not apply
> Patch failed at 0001 Introduce new configuation option to override committer 
> information
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".
> $ git diff
[...]
> As git status doesn't tell me what the conflict is, I can't resolve it.

Have you tried "git am -3" or "git am --reject" (after "git am
--abort")?

I agree that the hints printed are suboptimal in this case.  Please
feel free to make them better if you have time for it. :)
