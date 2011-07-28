From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 15/18] reset: Make reset remove the sequencer state
Date: Thu, 28 Jul 2011 21:12:33 +0530
Message-ID: <CALkWK0=eh2MRqc1tW3rcPYAF3YLQnXanTZd9kzGdWBpJVcB01w@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-16-git-send-email-artagnon@gmail.com> <20110727051612.GJ18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 17:43:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmSjj-0002xt-Mh
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 17:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576Ab1G1Pmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 11:42:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35218 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1G1Pmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 11:42:54 -0400
Received: by wyg8 with SMTP id 8so224947wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Tp6epRJ9mQiXYPgL1dwLR+9gGLzKNw8c4MxRX1Fb92A=;
        b=G7kaJcc+4mNSVyWIuGOdrolvDupkxqW9Z8+UMqS3VnX/5mVJn+j6u84q/LmbsRBQT1
         SR/StJrRqI1C3zdWAFNXuYMHofrSjaIghjMlKnwSAldV4FTyEbkJTBsaRwaXUB78qBMH
         VMmME9b6huLyTtITUCCbB3XGOmt+4uUnDzTC4=
Received: by 10.227.41.200 with SMTP id p8mr176159wbe.79.1311867773076; Thu,
 28 Jul 2011 08:42:53 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 08:42:33 -0700 (PDT)
In-Reply-To: <20110727051612.GJ18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178071>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> [Subject: reset: Make reset remove the sequencer state]
>
> The chosen strategy here also affects some other commands, most notably
> "git checkout".

I'm curious: doesn't this also apply to "rebase -i" and other scripts
that attempt to remove the branch state through "reset"?

-- Ram
