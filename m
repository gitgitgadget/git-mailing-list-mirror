From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git-rev-list diff options broken
Date: Tue, 6 Nov 2007 20:38:39 -0300
Message-ID: <f329bf540711061538l4cdef27co2cb42a9938b2e325@mail.gmail.com>
References: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com>
	 <Pine.LNX.4.64.0711062330220.4362@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:38:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpY0U-000093-SU
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbXKFXil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbXKFXik
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:38:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:5560 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbXKFXik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:38:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2605345wah
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 15:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pwTeUaOzjiVYJjSFV/vclyUINfNCaoxC3r9uIpYxM6E=;
        b=MSPZe2oCZCWw3CMna4+8YnMX671775B47+VSu0zdxkklXu1F42b8QNuEsd7+7LRmotKYMh5y+/Nd2rLKEgbk5nfBRJAzLzJIIOViXklffjL8sHpuJiZVgFo4/Co4NxaRGVn/oIql0X/BzVIXMfK2uURE5FGbgfEKNhNDJG4lNLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tj3W448gY1eRE9HyJB7c7xz2vRWOWsO7OSDXJMjmKyd7wYkpmDLzoYicwVbtlghyqrDo370Nd9DKMT3ymJZOH+/xzkN3kW1XMQjHJyw+bXvqAMI29/ItXk93TBAS8iKbw8KBb6Fgk1Ur3eqCQOT5MLTrZ8O+mLP8AM03NQjhIkY=
Received: by 10.115.46.9 with SMTP id y9mr590937waj.1194392319077;
        Tue, 06 Nov 2007 15:38:39 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Tue, 6 Nov 2007 15:38:39 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711062330220.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63751>

2007/11/6, Johannes Schindelin <Johannes.Schindelin@gmx.de>:

>
> Probably you want to use "git log".
>
> "git blame -L 585,589 builtin-rev-list.c" indicates that 8c1f0b44(Fix up
> rev-list option parsing) was responsible, which in turn indicates that it
> was intentional.

OK. So the man page needs fixing, right?

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
