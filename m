From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Fri, 19 Mar 2010 15:53:01 -0500
Message-ID: <20100319205301.GA15053@progeny.tock>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
 <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 21:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjBK-0003hR-Hk
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 21:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab0CSUw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 16:52:27 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:62070 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0CSUwV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 16:52:21 -0400
Received: by fxm19 with SMTP id 19so1014331fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yYkyGML0WnvfL+TioMSFODrNOvuK5GNlAvmDTPxu6oU=;
        b=kIiNjeeZvv73ht1yq4Y19lA5hvSzQ+It37iQ3JwbCiBODqJZM2LUvRF4gOYfjou7BS
         kNl+y9FgCD/YT9VpPQcNHZOll5fcutTvlAwyrJaVRZhYO7lZUjTmMgpF+hhRp5hGLRCJ
         InCUCHasvluCo5/4gfDNezI+xBXOEQ1H2YSrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TS8xN35S2xPHJAlvAsFZuQ/DIM3hb5K1TDgK1dD7STeZx+M7YUDwSfg+5qmS0usuFp
         ROgQQp6SB0DwKlO/BH/glhRjERsLWAkzdPpFYHeDFWhZdz4k0MaxwVA+AuDdF3hAISuD
         DX009EHs5Rlm4o3QqnODJRGUFcmaw8vS/9sHk=
Received: by 10.86.6.38 with SMTP id 38mr5654969fgf.43.1269031938998;
        Fri, 19 Mar 2010 13:52:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 28sm2625455fkx.6.2010.03.19.13.52.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 13:52:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142645>

Avery Pennarun wrote:
> On Fri, Mar 19, 2010 at 1:18 PM, Ramkumar Ramachandra

>> The following resources are relevant to the project:
>> 1. git_remote_helpers/git/git.py is a minimalistic remote helper
>> written by Sverre. I plan to extend this as much as possible before
>> rewriting it in C.
>
> Are you sure you really want to rewrite git-svn in C?  svn is so slow
> that interpreted vs. native performance is unlikely to be an issue.
> git-svn is probably not going to be needed on embedded systems where
> installing python or perl is a problem.  And managing the data
> structures in a high-level language should be a lot easier.

Hmm.  Sverre discussed why this is more about a redesign of svn
interop support than a C reimplementation of git-svn.  I wouldn=E2=80=99=
t mind
if at the end of the summer, all we have is some working Python code.
Still, it would have to be rewritten in C or Perl before msysgit could
use it unless some hero packages a Python interpreter for them.

Jonathan
