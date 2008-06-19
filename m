From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] git-push: add a --delete flag to allow branch deletion
Date: Fri, 20 Jun 2008 01:20:43 +0200
Message-ID: <bd6139dc0806191620y3f821c15h91454ddef2173590@mail.gmail.com>
References: <1213884787-24692-1-git-send-email-pdebie@ai.rug.nl>
	 <485ADE10.7070404@op5.se>
	 <4BED18CA-BFFE-4F35-A484-6CF0908D3FC1@ai.rug.nl>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Pieter de Bie" <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Jun 20 01:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TRl-0005qq-NS
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYFSXUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYFSXUp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:20:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:50915 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbYFSXUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:20:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so563682ywe.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=maTiZkGdIVry1IyUtNPaYKFU4EA1tlxDeGVsUgWh6c8=;
        b=ofiEC3ACcY5/KxE23/hZ1MNxG8c4SXhbHD3jo/myZf/mweE9479pO7oqF+tcKY9yV/
         0rs+awqMQVgEMa0NfzhYfgbOSmTnevcAkQUe+lO/Ju9trTrC5/IqNqp+VWNqwjo3tJ8i
         GUl9/W6UPskiL0//hz2ieN5PB5aX1IYYZZeoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=drpo7UZwHhC+CW6CemgN6zvLcNYgWzj+ixvTi0dc/9nlYljUosx39euPZ5NGFKJaZS
         46c48mM/wg+tAx2uVjW6Inf1g1xA13IqsQyYK2EoSZvq3LV0dV5SKRqNU5x0XWLVeKSZ
         /D6fOtY8/jqBVy2gpQXBwG4ZMwpRaw0PVEQD0=
Received: by 10.150.151.11 with SMTP id y11mr3961474ybd.218.1213917643498;
        Thu, 19 Jun 2008 16:20:43 -0700 (PDT)
Received: by 10.150.149.14 with HTTP; Thu, 19 Jun 2008 16:20:43 -0700 (PDT)
In-Reply-To: <4BED18CA-BFFE-4F35-A484-6CF0908D3FC1@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85561>

On Fri, Jun 20, 2008 at 12:55 AM, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> On 20 jun 2008, at 00:30, Andreas Ericsson wrote:
>
>> Question though; does it delete the currently checked out
>> branch if no branch-name is given? I'd prefer if one has
>> to explicitly name the branch to delete.
>
> You have to explicitly give it a remote and one or more branches
> to delete. I thought it would be best to be unambiguous in cases
> where deletion is concerned :)

I like it too, it's one of the most unintuitive parts of the git
interface imo. I am guessing there is no "-d" switch because deletion
is involved? Then again, there is a "git branch -d/D"?

-- 
Cheers,

Sverre Rabbelier
