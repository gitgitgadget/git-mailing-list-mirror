From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: global hooks
Date: Thu, 20 Mar 2008 01:04:33 +0000
Message-ID: <57518fd10803191804g7b2ce670xe5d89b53c1bb8f6f@mail.gmail.com>
References: <1205942671.691.8.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Victor Bogado da Silva Lins" <victor@bogado.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 02:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc9E7-0007Bd-1W
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbYCTBEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 21:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYCTBEg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 21:04:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:47883 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbYCTBEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 21:04:34 -0400
Received: by wx-out-0506.google.com with SMTP id h31so797033wxd.4
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 18:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=QyBMHwY9cWXtx7zdeNUWJdRz0aTiAoByI8EFP9YLIVo=;
        b=X7z87lZBGRxIDAXYugMdajIpirqcaYxYxu5TrInnkdG+z78lxPERWj7qXywAfkxrofY94oNqhVs6PhKW791zId7lwUGLaakcr2mwlawVQYI6yfVI8m5oA5xdfcFSycegLbpFTJ2XfwCxok1kSR0NU1rHBqrvQ31hwmilD+MQSD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NbR7H7D+3LVJUe49/YsJdmO+AZZQKTuDOF0DGpbYYnFtURk5bN5+CC88TAOgihCOKcLqyGKuuWFCPYXzGrAk+kNoxGgYva92lXs+/EVDIiE3PdIpcK8xYOQ/b5yswjEHdOKjwuMkNSyu1j8TsL34OoQwIjOvaxg6N9mkctxGzuI=
Received: by 10.141.36.10 with SMTP id o10mr536459rvj.176.1205975073417;
        Wed, 19 Mar 2008 18:04:33 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Wed, 19 Mar 2008 18:04:33 -0700 (PDT)
In-Reply-To: <1205942671.691.8.camel@omicron.ep.petrobras.com.br>
Content-Disposition: inline
X-Google-Sender-Auth: 0e9856302406a1ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77609>

On Wed, Mar 19, 2008 at 4:04 PM, Victor Bogado da Silva Lins
<victor@bogado.net> wrote:
> Hi, I made a prepare-commit-msg hook today, it basically appends the
>  diff I am about to commit to the commented information that normally
>  appears.
>
>  The problem is that if I want this hook in all projects I have, I have
>  to copy that file to every single project I have. This is an error prone
>  operation, not to mention a pain in the... .
>
>  SO my question is, is there a way to make that hook global to all
>  projects? If not, would it be a good idea to allow this?

I'd love to see something along these lines - at the moment, I have a
precommit hook to drop textmate's caret metadata from the commit file,
and it's a pain having to symlink it into every git repo.
