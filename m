From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: GIT and Cloning Remote Repositories into "Local Remote" Repositories
Date: Tue, 21 Sep 2010 12:26:41 +0800
Message-ID: <AANLkTimR_qo-LP=_VmUTb=LFGfoW1tLq2Qyn5FTh9ogf@mail.gmail.com>
References: <C8BD56D1.1E331%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Grant Erickson <gerickson@nuovations.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 06:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxuRc-0003bv-1H
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 06:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0IUE0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 00:26:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62284 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab0IUE0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 00:26:43 -0400
Received: by ewy23 with SMTP id 23so1806532ewy.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Kg12VlkhtWXp3UuH10vKW4wKgFofng6j2loEELJ6I+Y=;
        b=o2AeakTtVixgSU8ZvClgP/PWn1DiB5EPCUkQqg0MGYg4CHPAp09fxYTSYjWxtTpPUA
         pC2CLuAxFOaOZWs3xrs68Cy4Nk6VkfUlFvdUmawWOIpjxlGArewZ9CQqtUXFcwD2oSm7
         Pp7cN6v7t6FF3xX+BPGFC5XGSD6IrXkhuBxG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XHyCaEQY9/2PhOCocQQaS7eQUt7Xf6yzFbDYyo+nkVtEqJzSMP2EHR6EHMdkLIw2Pt
         5xbSAdZ8rNB+VCdaRZ272pLkf5JGQKYLNeT7FE8X1LK8FAZQKGvZI4wpGcYSGbWlRXtu
         0RIqBv0lZVK1qRTSbHTkyYPLTHkvXfi8X2uKw=
Received: by 10.213.17.82 with SMTP id r18mr7767265eba.18.1285043201989; Mon,
 20 Sep 2010 21:26:41 -0700 (PDT)
Received: by 10.213.31.147 with HTTP; Mon, 20 Sep 2010 21:26:41 -0700 (PDT)
In-Reply-To: <C8BD56D1.1E331%gerickson@nuovations.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156689>

Hi,

On Tue, Sep 21, 2010 at 9:22 AM, Grant Erickson
<gerickson@nuovations.com> wrote:
> 3) Changes in these subdirectories in (2) should ONLY go to GitHub but NEVER
> to the origin of the clone UNLESS the user (usually me) really knows what
> he/she is doing.

Then be careful with the default remotes - for example, "origin", or
branch-specific default remotes.

-- 
Cheers,
Ray Chuan
