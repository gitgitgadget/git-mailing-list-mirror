From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 11:09:33 +0200
Message-ID: <BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
References: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
	<4DAD4B0F.9030908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 11:09:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC6wF-0007le-ER
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1DSJJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:09:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52581 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1DSJJe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:09:34 -0400
Received: by pwi15 with SMTP id 15so2653044pwi.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ORm2SzjvO3JSJ6otmz8iYzxjzBsMC3D9hyX057vNpLs=;
        b=lRFKSCmUWz5smY62n5yGAv2U/Np8ZuoQSBOBWxe2S8+2Jlq6jK6vJBf2Y+oHIZpMw/
         tJGlBPozeDjIxgOUx9tYSTtlaB03Im9BpRs3F7jMxjgOmKOKbZkrr1eWfk3xr33vC7mb
         GOHTAYJgsampOxImY78t85ygo/iSwsTHXtPmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bNz8or7p++GIi9SUiwoxfwwP6FG3REuaOzT/V2A0AC7MGjeuO4oehuHPoHvH32tewy
         fDlI4Og4GoXfrBXD/FzJGmZ+oGhjGvWtDsPjcPWeEXedB18Gr2d8HL48X7fGirTYi3X3
         YSENP+KPDq6g/nngM6gUwcUrujyG21inUIUE0=
Received: by 10.143.3.8 with SMTP id f8mr3332440wfi.39.1303204173944; Tue, 19
 Apr 2011 02:09:33 -0700 (PDT)
Received: by 10.143.18.11 with HTTP; Tue, 19 Apr 2011 02:09:33 -0700 (PDT)
In-Reply-To: <4DAD4B0F.9030908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171784>

On Tue, Apr 19, 2011 at 10:42 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Francis Moreau venit, vidit, dixit 19.04.2011 09:32:
>> Hello,
>>
>> I'm wondering if it would be a good idea for git rebase to allow not
>> rebasing reverted patch which are part of the rebased branch.
>>
>> For example I'm currently rebasing my branch 'devel' onto master. This
>> branch have several commits and specially one called A and another one
>> called A' which reverts A.
>>
>> When rebasing 'devel' branch, rebase could try to drop both A and A'.
>>
>> What do you think ?
>>
>> BTW is there a way to do this currently ?
>
> You can do this with "rebase -i" by removing A and A' from the commit
> list (or squashing them or dealing with them in whatever way you like).

Of course, but my point was to make this automatically...

-- 
Francis
