From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 20:07:03 +0100
Message-ID: <81b0412b1003241207s4951b32cpbe105e7b3623f61a@mail.gmail.com>
References: <20100323232055.GV7038@pixar.com>
	 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
	 <4BA9DCDD.6060109@viscovery.net>
	 <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
	 <20100324134048.GB10190@pixar.com>
	 <81b0412b1003240659u4e6de405t7750b66ca9292cdc@mail.gmail.com>
	 <7vpr2tu1bd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Damerow <lars@pixar.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 20:08:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVvM-00051d-Aj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 20:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735Ab0CXTHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 15:07:08 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:58706 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab0CXTHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 15:07:05 -0400
Received: by bwz1 with SMTP id 1so225215bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Me8Pml1xrT5Eekyzkv2oMOpHDg5vwFdw30pkT/8oK6o=;
        b=Y0+lx4UBa6M3MV57BaCifDBN/6wK7UcD2QdQ0uFJfj2i7ZnGeXdwQoR8zsFQJCqlno
         vY0Z/M6/sIpAARiB6NcUCss/KHjD5pTuBCnzijrZWrj7/XU33I1vKIZaAh97oQNW6LBP
         RXD3T6fJmbAARc78xsHfL8hwzQ/nY/DOwP7uI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BuIGiPVKsDEIAgWL+14BeCM1DXzmdOVsA2GNWC0WjWH9cdy151cxi1Mnm4EAsztKlI
         BpyNPTCncem0BkvCMtCY3fIxKX+7PJMpEvFME0IlA/Lb/224FS3O7961hzhZOLU3pA1k
         lQVPE19PgRo2V0yZpKMJqi+SxMp+vcW3Tf84U=
Received: by 10.204.175.14 with SMTP id v14mr6418594bkz.72.1269457623746; Wed, 
	24 Mar 2010 12:07:03 -0700 (PDT)
In-Reply-To: <7vpr2tu1bd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143105>

On Wed, Mar 24, 2010 at 17:33, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Oh, I wasn't clear. I didn't mean "instead of". A command-line option
>> _in_addition_ to the environment variable. For one-off uses.
>
> I may have been the one who mentioned "-x to git potty" as a possibility,
> but I agree with Lars---I think it would be too cumbersome to use in
> practice.
>
> When would you invoke this feature as "one-off"?
>

Maybe when I want to make sure git status does not go all over an
NFS mounted submodule.

But frankly, I think it will be the most obscure feature of Git ever,
with a command-line option or without. I just wanted to suggest
(and actually, just should have, stupid me) to keep it in line with
other similar configurations, which are present in all three forms
(work tree comes to mind... Come to think of it, only the work tree).
