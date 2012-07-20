From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 12:49:32 -0300
Message-ID: <CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	<7vhat2toz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFST-0001nv-JV
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab2GTPte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:49:34 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54141 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab2GTPtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:49:33 -0400
Received: by obbuo13 with SMTP id uo13so4992654obb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TeoCDwKTE2W8u2iR9RrSfMsUB9Ha5DCalor1348ZMr4=;
        b=qIIBCCmbdnDIAst6XcMBAQzxODdmsb8h+f1TCJzH7/kFnXUUQz+Oa9rfMIU2pWB7vR
         9dxYG/aqrfVkMTZhHBDLmx+O399Irv/iVtIalvmPXdNcKXq5KezoTT8z3I64lYatjw5P
         zV5fZcOBpyCTjGbFmfpLqIkJoFiemlkOQUfbnwxcTBHOurmeuwB50RcuEXcMTXRt++FD
         9GI9FtBaF3JwTCUHuIH8HQKrrA5Z8tgPAq/wNyEJfu7JwpsjGeTRDyOuVF7hxH9KzquU
         4FskKp9XP2SDVPIcLSXT/T3wJflIKjm+BXDKnPmwVx63GVXmQJEDRwaKe9/63p7zDS5B
         Wc2w==
Received: by 10.182.144.104 with SMTP id sl8mr7593565obb.74.1342799372816;
 Fri, 20 Jul 2012 08:49:32 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Fri, 20 Jul 2012 08:49:32 -0700 (PDT)
In-Reply-To: <7vhat2toz8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201781>

On Fri, Jul 20, 2012 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> How can I push a working branch to github inside it?
>>
>> E.g:
>>
>> # On master:
>> $ git checkout -b feature-work
>>
>> # On feature-work
>> # vi, hack, commit, ready to push
>> $ git push origin master # here I expected it would working pushing my
>
> "git push origin master" is a short-hand for "git push origin
> refs/heads/master:refs/heads/master" to update their master branch
> with what you have in your master branch.
>
> See output from
>
>     $ git push --help
>
> for details.
>
> I think you are trying to update, while on your feature-work branch,
> their master with your feature-work branch (or more generally, the
> current HEAD), so
>
>     $ git push origin HEAD:master
>
> is perhaps what you are looking for?

What I'm looking for is to upload/create the remote branch in github
from inside my local branch, without having to checkout master in
order to do so.
