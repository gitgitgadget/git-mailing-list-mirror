From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Reverting to old commit
Date: Wed, 28 May 2008 01:00:11 +0200
Message-ID: <bd6139dc0805271600k6968b6c7j9075bb8aeffe9863@mail.gmail.com>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
	 <m3bq2r39gh.fsf@localhost.localdomain>
	 <6IRlPIxadiyIIPsto-MFx6wInl0VvCRxVSaI3-OglmCjLt5obfbiww@cipher.nrlssc.navy.mil>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, Marcus <prima@wordit.com>,
	git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed May 28 01:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K18AE-0002Xu-T4
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 01:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbYE0XAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 19:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758709AbYE0XAN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 19:00:13 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:58609 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758514AbYE0XAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 19:00:12 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2304597wfd.4
        for <git@vger.kernel.org>; Tue, 27 May 2008 16:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=APj2/soBUyj6Bzv4QzXGYwxCallMAQvTbb9pHspQp/8=;
        b=bZpIOA45VswGoZPVb7Nen7WVYxKQR3z2deKw4Fre6LCf05va4x+1q/rSGgfvKD5dZ9o5rHnbE4od0FVvTXJjgekkzCUgy6ztdSgH/LoAYFHEwA1wlQz4TUxtNItTcVX007TpGWQyf8TbE3TWkoA7CnNteh5PCAY7AdLzcYJYpnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cdt3RJxOxcMbtAEu7bDPGqgxJ+n1A5Yn6MX6nOrHGNl+le5IOllm432/8SzN02HyGX/eMJlyDOnk6/0N9kEZe6exkWZhQrLSuLibSgmYE6el9EoSGp56P6Dz4tFZleK4zF9YJmzW2DBwTwBpVdxH19sPM5ToTCp3iHZ8ZeUNvhk=
Received: by 10.142.125.4 with SMTP id x4mr725354wfc.324.1211929211564;
        Tue, 27 May 2008 16:00:11 -0700 (PDT)
Received: by 10.143.10.16 with HTTP; Tue, 27 May 2008 16:00:11 -0700 (PDT)
In-Reply-To: <6IRlPIxadiyIIPsto-MFx6wInl0VvCRxVSaI3-OglmCjLt5obfbiww@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83059>

On Tue, May 27, 2008 at 10:43 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:

> Shouldn't we be encouraging the use of 'git log -g' rather than 'git reflog'?
> git-reflog seems more like plumbing than porcelain to me.

I had no idea, but then again, the man pages don't mention whether
something is plumbing or porcelain anywhere... But I guess 'git log
-g' is easier to use (since it supplies the user with most of git
log's features) than git reflog. I was introduced to reflog by someone
advising me to use it, so I was merely "passing on" that advice,
unknowing of 'git log -g' :).

-- 
Cheers,

Sverre Rabbelier
