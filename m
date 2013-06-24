From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 6/7] rebase: write better reflog messages
Date: Mon, 24 Jun 2013 13:42:09 +0530
Message-ID: <CALkWK0meLtmSFNSXPxkz4dnXQ_wgNPdUbB-7TL3iqL0JOg5Qmw@mail.gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
 <1371629089-27008-7-git-send-email-artagnon@gmail.com> <7vfvw8dw9m.fsf@alter.siamese.dyndns.org>
 <CALkWK0kj3UOx8sq+h=L0giUC-vn+h3by9o_6YbjA8ArRXZfgZw@mail.gmail.com> <7vtxkoc557.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1tP-0002HO-QV
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab3FXIMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:12:51 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42716 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab3FXIMu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:12:50 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so24038777iec.21
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VeKYnKxYZ+2PoP0Oh0JBpMd5ou9iHamD0z7AAMQktWA=;
        b=wI2/OUCoDmkly0EYeIJ/n+zG9rwfvG1ha9h9tAE0C0L9eSnpRvq2OfUuhyA0gnjGnY
         BCffsJdMvsa97KX6ibF7hSZUrFe/IRaF0oXgk7ViNm710aOM1V0C771L1+CK83tvlNui
         hX/lmy6mw1bXylnZGDB/SXw/bNnkYbhXvezUNAh60pvYDO27HZpb2iJziRHGSzXzy1NI
         +OgmL9MIbp5hton11lne6OMzMCIJUfQvGmmy0wVDgFRthGytAqaGiQLXycZHAYIPYvkl
         FcIK0D1NKel5PfKRnDiveoGXkzKOAx4orW6jvukSnk5oCV9RmiYKc9bo61KtHpM25vda
         fS0A==
X-Received: by 10.42.190.74 with SMTP id dh10mr11108903icb.35.1372061569985;
 Mon, 24 Jun 2013 01:12:49 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 01:12:09 -0700 (PDT)
In-Reply-To: <7vtxkoc557.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228793>

Junio C Hamano wrote:
> So you are forcing people to maintain _two_ variables, instead of
> just _one_, without making anything simpler.
>
> What's so hard to understand why it is a wrong design?

Fine.  Let's say I buy your argument about one-variable versus
two-variables: how do you solve the existing problems that are solved
by overriding GIT_REFLOG_ACTION that I pointed out?

> If you truly think this is "inconsequential", that unfortunately
> convinces me that you cannot yet be trusted enough to give you
> latitude to design interfaces that span multiple programs X-<.

*shrug* I certainly don't think one-variable versus two-variables
warrants this much discussion.

I don't have anything to win or lose: I designed a solution to the
problem which I think is reasonable; you don't.  Fine.  Show me an
alternative that doesn't involve rewriting half of the rebase
infrastructure in a series that fixes checkout-dash.
