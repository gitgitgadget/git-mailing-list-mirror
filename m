From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 11/13] remote-curl: accept empty line as terminator
Date: Sun, 29 Aug 2010 21:02:17 -0500
Message-ID: <AANLkTik-kcXrTKJiN+euhYYgC4582oO_Nto6bk58pH1Z@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-12-git-send-email-srabbelier@gmail.com> <20100830013928.GE2305@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:02:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opthq-000848-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0H3CCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:02:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38573 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab0H3CCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:02:37 -0400
Received: by ywh1 with SMTP id 1so1489023ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=gJAxNY4VdPX51IoU0bp68eW4azDy0GYre5pFdhPwBMY=;
        b=Q+8dPzw6LQXv8gLmpmJJTRAIDToCIEduWjNhFnxLhsP1ikKuULv+Wb0sTzXwcFQmoR
         DRIGR8xhxCerX47kYJ+agtDCfmDL0opWvy98LVHXqogfdLcsnEXyFVvUYkaZKJdxpm2e
         w8/BHRzqUIUczsdGhHpMGWxnziu8jS/Ud4KN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xRVeE5tlk1niV+CwDM9N4hYk7WjTkaALpgaXbntx9jUAmC3CdtPuuilQXN4PcI4jsF
         H/BnfWMIgQV4ePW/8uvi2epzPycB+VB3YB0/sBne9CnUYdrj4FdgRH4A0dFka1XF6vRX
         rPDRw6/6V4SERoecDo2w+xXRNf22xqezWLuGY=
Received: by 10.151.63.23 with SMTP id q23mr4741898ybk.133.1283133757174; Sun,
 29 Aug 2010 19:02:37 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 19:02:17 -0700 (PDT)
In-Reply-To: <20100830013928.GE2305@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154747>

Heya,

On Sun, Aug 29, 2010 at 20:39, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Shouldn't this go before "check status code of finish_command" for
> bisectability, then?

I guess so, the current code is already broken, but at least the tests pass now.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

-- 
Cheers,

Sverre Rabbelier
