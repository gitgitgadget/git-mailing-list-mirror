From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 0/2] Fix spurious conflicts with pull --rebase
Date: Fri, 13 Aug 2010 01:48:52 +0000
Message-ID: <AANLkTi=9Mqyoc5jjMOZJVNGY0e=DqZUr7ays=WOcr2tN@mail.gmail.com>
References: <1281664250-2703-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, santi@agolina.net
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 03:49:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjjOF-0004Ki-Jc
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761025Ab0HMBsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 21:48:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35713 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0HMBsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 21:48:54 -0400
Received: by yxg6 with SMTP id 6so699454yxg.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=D3y/gAXP508WX2+A7KGOTLKFCCeJAz0t/oSowAPbi7k=;
        b=pimh03dRAYmi8jQLBNqZJX3hEBHuAQE9W94NRxezenRZZHDxIsCBTv8p/SsoZe4rKP
         RaUc5OjhaMNLRRN94TLnQsbl2M4WWeNaM7EW1t+zqREcnRChII0RnAw8OgdGJ6Cbq+7R
         ExDU43DEOsfNbMghxavMj9XV+QrBHHK9DuxfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wS+9FlSBJX4qHzN/8kzibbRcLtb78tcYgisdFe3F4gk+0YXB5je9g2teuxZFFVW8Sd
         bQkwaQ3Dma782MVvOHN1NTnYNKzInLy4IX2SXoW6fMxqYDABV1/9kmKu5Jp1S5PruvOA
         Fi3iyR6CrXF9GDmSU5YoHW4YL1g/tdHlgRD30=
Received: by 10.231.166.9 with SMTP id k9mr831482iby.127.1281664132733; Thu,
 12 Aug 2010 18:48:52 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 18:48:52 -0700 (PDT)
In-Reply-To: <1281664250-2703-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153456>

This looks very good, and has a great code/test ratio.
