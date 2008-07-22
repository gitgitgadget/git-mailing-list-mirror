From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] parse-options: fix parsing of "--foobar=" with no value
Date: Tue, 22 Jul 2008 20:53:06 +0200
Message-ID: <bd6139dc0807221153n18c864b7ve83a316867e892ab@mail.gmail.com>
References: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Olivier Marin" <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 22 20:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLMzz-0001dL-49
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 20:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbYGVSxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 14:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYGVSxK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 14:53:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:41432 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbYGVSxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 14:53:08 -0400
Received: by yw-out-2324.google.com with SMTP id 9so854531ywe.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+d4zL3S8hsJnLazuSMYYzAB4pYdVSkdYhKxFXrNKI1c=;
        b=T6Ht3JFN59eBFmZIovvtkju77Zx+m3QAT9dWhvdovh89/pMQgulL4RsxpQNKYLXeMS
         N6xwFORAXWD8/UuL30BWj/xnJCJWDIzf+6m0V/ZmtOINo31xQnjKyxWR9L4+fpRFxvHo
         /uYk7LvBTwjF6sgSgxioE+bFls9jAT6QGQiJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Vstrqpi9un4XIXe3nRf5BoMhHZxQ4HdMzcuth7lYoySUJCM3X/xwpp/pTELpDLzOT/
         2zVw1ynkVkxr44aFCdJT9KZRCrWIrWlzxNV2+kbT+0QV8SDc9dGLJADBBeRwm+xNHJQ5
         /r7l7oDoJX+4u37CL4l2LnZuusmm1OuworveM=
Received: by 10.142.240.19 with SMTP id n19mr1982092wfh.12.1216752786272;
        Tue, 22 Jul 2008 11:53:06 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 22 Jul 2008 11:53:06 -0700 (PDT)
In-Reply-To: <1216752267-12138-1-git-send-email-dkr+ml.git@free.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89511>

On Tue, Jul 22, 2008 at 8:44 PM, Olivier Marin <dkr+ml.git@free.fr> wrote:
> We should instead, exit with an error if a value is required, or use
> the default one if the value is optional.

This makes no sense, when I run "git foo --bar=" I either mean "set
bar to empty" or I typo-ed. Why would I specify "--bar=" if I want the
default value?

-- 
Cheers,

Sverre Rabbelier
