From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick/revert: transparently refresh index
Date: Sun, 31 Oct 2010 15:32:33 -0500
Message-ID: <20101031203233.GA22937@burratino>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
 <m24oc2p0rd.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Oct 31 21:33:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCeaR-0006PU-99
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 21:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733Ab0JaUct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 16:32:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62925 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab0JaUcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 16:32:47 -0400
Received: by vws13 with SMTP id 13so2749488vws.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=u1pzWhjgNqXfFDL8lUm2tHQfGOn/wcjZ8gsq0RSdEL8=;
        b=lTYyMrFUdafCvTmwNuxNOZJynYEgmzt43DqTpJUAavoK4TpZ2q9V6JcoGPG2NPOG//
         h4UlDVN+4wj1jntbVro3AYLUvqe79PJxmGXnO+iVmNUD+BTprx2qZLPIRiC2GpHHxrmH
         IUAJLLiOBdqqXliYggeG01QrdRI/kvfDMgQEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JkpVz6yUf5NHqNI+tMVadloNrz5smK0lYkU2vD5A9upI3PYgNUrzwLlzfxXtBko/Gi
         O2lj8mhRiQcGPTB9C+GWxfbGveHUr0A/k3wh6k8w/mIzI0oF4DmdeY7vVtpHmz0HSeQR
         VBNi2/G1pH3n1lbVZCcfnZKhhxLwst/KJnKU4=
Received: by 10.224.211.129 with SMTP id go1mr5514437qab.270.1288557165657;
        Sun, 31 Oct 2010 13:32:45 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id k15sm4293636qcu.47.2010.10.31.13.32.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 13:32:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m24oc2p0rd.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160452>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/t/t3501-revert-cherry-pick.sh
>> +++ b/t/t3501-revert-cherry-pick.sh
>> @@ -83,4 +83,17 @@ test_expect_success 'revert after renaming branch' '
>>
>> +test_expect_success 'revert on stat-dirty working tree' '
>
> ITYM s/revert/cherry-pick/

Good eyes.  Yes, I do.
