From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 17:33:09 +0800
Message-ID: <856bfe0e0901080133q68d0008ao1abf9d235e70279e@mail.gmail.com>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com>
	 <7vr63e42ke.fsf@gitster.siamese.dyndns.org>
	 <4965C07D.705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKrHi-0003OY-1O
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbZAHJdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbZAHJdM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:33:12 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:4697 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZAHJdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:33:10 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2804426ywe.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=z5A8FxO7oZzlWrHT4u/urcNRIVhJZjlKZKc9+Xu6uz0=;
        b=oxw59fB6MOB9bfG4LyHeGcC3mmAlYmvSGfr8GWc2ksN0+nk9yVjkpWO/Hb/IdIgsTB
         cx/YZ4z8F7HK5jhU/Qb87bj/uTq+2cNdFabfJE+iPOWf55Gqd0WJ8rxX86smMYCsRLt2
         L3j9E3xTvWxRXQUg7rta2PES64IjFxL40QaZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pcMXEtv12uWsb88D+M4+Z/Jw2ooMFvVTaYR5nHAoSYr//j6jLrhj3ItrUCOU7I/tah
         MlC+LblsZSE4FGuw0VlFFiAXMY/0QV9tQkhrP6Bww2G5qdiHepwJUQeww1w9NiTZNbRN
         YBHZuRWOvURBWjo+DZ1kC/pMw78OshcJWe/wE=
Received: by 10.151.111.1 with SMTP id o1mr1653129ybm.88.1231407189462;
        Thu, 08 Jan 2009 01:33:09 -0800 (PST)
Received: by 10.150.204.13 with HTTP; Thu, 8 Jan 2009 01:33:09 -0800 (PST)
In-Reply-To: <4965C07D.705@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104908>

Hannes,
Could you give me a detailed steps on how to wrap git daemon by tcpd?

Junio,
I think gitosis can control readonly or writable, it can't control if
it's can be cloned. Am I right?

Thanks,
Emily

On Thu, Jan 8, 2009 at 4:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Junio C Hamano schrieb:
>> The git-daemon transport deliberately omits authentication, and you cannot
>> restrict when they come over the git native transport using a URL like
>> git://your-host/repository.git
>
> But you can wrap git daemon by tcpd and configure hosts.allow and
> hosts.deny (with all its caveats), if this suits your needs.
>
> -- Hannes
>
