From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 10:46:11 +0100
Message-ID: <81b0412b0703140246h13f6f18fo88395ad603885dc3@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	 <7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
	 <7vfy88dwvw.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140207kf887738od482022497d2a63d@mail.gmail.com>
	 <7vk5xkcgkb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRQ3k-00005J-Kg
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030838AbXCNJqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030835AbXCNJqO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:46:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:39292 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030829AbXCNJqN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:46:13 -0400
Received: by nf-out-0910.google.com with SMTP id o25so143074nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 02:46:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c1qXWj7Gng2ZWut9ah7UZriLWsv14GBOQeIJnG6FE+ecrV0IHrpdCoZTn8L7BnEkCqRiPxSJBD8i4BtDT4SfCiTc0mG1l5B5ajPMSqulUQzcxCGBTEZu4gf5oPp5xw3qIexYS1thxQOTJvwY/N4loKGPoLDbJTQmT36HHIGdFyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aeQnmHsWBGMO2Fnxr+nceGZDxo8sBg0rdiQ8FQib56zf+bGGP2vwI5m+xxrTnVnYbfkhM91swEQazfdJTFfv5kfj6j8udj+JHkU5KygdFTKKo14sP1NmzYcucXCRxgBWgRnJ1HHPbMFxJpEfTvRBE8hn5JqTzt0dXa+n/y676iM=
Received: by 10.78.160.2 with SMTP id i2mr432107hue.1173865571967;
        Wed, 14 Mar 2007 02:46:11 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 02:46:11 -0700 (PDT)
In-Reply-To: <7vk5xkcgkb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42194>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> In the ideal world we would sensibly make our diff to report
> with its exit status.  Unfortunately we cannot for the above
> backward compatibility worries, so a new option is an ugly
> but necessary workaround.

right
