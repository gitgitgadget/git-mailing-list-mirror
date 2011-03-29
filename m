From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 18:10:05 +0800
Message-ID: <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
	<AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 12:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4VsM-0006jI-Hv
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 12:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab1C2KKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 06:10:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38376 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1C2KKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 06:10:07 -0400
Received: by qwk3 with SMTP id 3so2505664qwk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kaxtBEezaRy7ipE7xzFRE9DllutpOie5Q5SdSrDXdus=;
        b=LB6VkyAprSmWMn2B+xWC0lblVXBmkJS/DKc7gzauync2ir0PM52H7se5wfNuRJXxrJ
         Nb8FKSoAYaSlcmCzOtl7bE4qcEG0nU6Atjwt0qVWx+pRB2Vd/uMiD84a3DgMBLy8RHzR
         zzIj06GdySZiM33HTOtjpbmUxs+yEcCOli7Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ivAUMk/VFRi5q4zeOG1qPpVCaR6vjGxSzc+btQ1gDthp3jqQl1T4Kf1HbVZqkh78rf
         2i++OvpSdS1qCMWsCZk+d9vUN1AbIEzh3dJf9GIVqn4HYW41WdwX2pbZD5fwIEXBcOtY
         yJT5MT3JL5WsPsynQ8oFVv0wm/QBvLEXDtCm0=
Received: by 10.224.40.195 with SMTP id l3mr4600132qae.41.1301393405907; Tue,
 29 Mar 2011 03:10:05 -0700 (PDT)
Received: by 10.229.185.2 with HTTP; Tue, 29 Mar 2011 03:10:05 -0700 (PDT)
In-Reply-To: <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170252>

On Tue, Mar 29, 2011 at 5:38 PM, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> wrot=
e:
>> All,
>> =A0 I have only have two commits in repo,then I want to squash these
>> two commit into one through git rebase -i .However it fails
>>
>> $ git rebase -i HEAD^1
>> it only show up one commit so can't squash (can't squash without a
>> previous commit)
>
> $ git rebase -i HEAD~2
>
only have two commits
> 8-]
>
