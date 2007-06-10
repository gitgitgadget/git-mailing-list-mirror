From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 23:14:27 +0200
Message-ID: <8c5c35580706101414r72c45e84q2b81083f8f88ec40@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070610002802.GD31707@planck.djpig.de>
	 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
	 <7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxUkA-0002sf-8b
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbXFJVO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbXFJVO2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:14:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:58063 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbXFJVO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:14:28 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1081524nzf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 14:14:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rftRlBfj+gFBDDNgPkIj28e0smoUyFp+JqnFQ0d+i59h7fT9tmc1KGecCfuKO6jQm6GqAWENcjKj6w9OBpWhKPXfN0O045Lyv9PHaN2ojTF9iEPTf2wbcBJU5er2QbjwQxIgfPjwXPKhD36nWsuM+H9SR8hnlXlGwt454EQUVp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fiy1FVwCHT3q91as87bUkwCec5JfVs+5BpAEz9pOIOdZhwZKpKFC0Ytbu/9Klmbx5LyF+eVMdEZroRCPf5i5ZKqJvwQLnIhFwy6TulxJTalCwHWYTcuAcsk2CACsDafYDdxhEvPHLnN1kbdy5MpJwhznWcC+BWA2nQpWv7va/eY=
Received: by 10.114.180.1 with SMTP id c1mr4816242waf.1181510067076;
        Sun, 10 Jun 2007 14:14:27 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 14:14:27 -0700 (PDT)
In-Reply-To: <7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49766>

On 6/10/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > Hmm, maybe I should just rename [module] to [submodule] right now? It
> > would be better forward compatible with the proposed extension, it
> > would 'harmonize' the section names used in .gitmodules and
> > .git/config, and it would offer a clean break from what's currently
> > supported in 'master'.
>
> Yes, the difference between '[submodule]' vs '[module]' in
> .git/config and .gitmodules confused me while looking at your
> latest patch series.  I am in favor of unifying them.  We would
> not be breaking any released version if we harmonize them now.
>

Good, then I'll do it that way. And I'll drop the "unless otherwise
noted, name=path" behaviour. If we later decide it would be useful we
can always "re-add" it.

--
larsh
