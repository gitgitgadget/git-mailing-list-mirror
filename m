From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Wed, 13 Jun 2007 18:13:36 +0200
Message-ID: <8c5c35580706130913j2d3095d1n649145ff540d1bec@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070613153611.GA11852@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVTa-0008F5-HN
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361AbXFMQNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbXFMQNj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:13:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:28054 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758353AbXFMQNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:13:38 -0400
Received: by py-out-1112.google.com with SMTP id a29so419835pyi
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 09:13:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mEIzQXdw2dwCE+XDL7Q7FEnNisXyeM7J5mTUpnTTdpUy5ZAA0uZEelsf3sVEclNlmWKzl2J3vVw6JldToudPMtC62cp2uCBsnvKw2lqqmeKYxIgaDjHj/QemTPLzDxH3uSgox+346kJRp20z2oxR19TQoaQWZ26cSPF0qZY/VW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g988BtRSNmLHhIK9ubzYkONoy5J95DtyDC6WhpHVHt9Hcd+2A2qXIy+XwuLWp70DgNyaco69z+eVf1FjpTSrbpDs6bPfZPRZsoSgPMnbwEIHxH1FZxfQteZ33hHKgFdn2BnUN4ctQbfL5VWdQTEO4ShK+BazeKsk7D1GAvu/I5U=
Received: by 10.115.75.1 with SMTP id c1mr776058wal.1181751216372;
        Wed, 13 Jun 2007 09:13:36 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Wed, 13 Jun 2007 09:13:36 -0700 (PDT)
In-Reply-To: <20070613153611.GA11852@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50086>

On 6/13/07, Matthias Lederhofer <matled@gmx.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > +SYNOPSIS
> > +--------
> > +.gitmodules
>
> My asciidoc (7.1.2 and 8.2.1) generates an empty refsynopsisdiv from
> this.  xmlto refuses to convert this into anything else:

Sorry about that, I don't have a working asciidoc :-(

But looking through the latest asciidoc-doc suggests that .gitmodules
is treated like a blocktitle:
http://www.methods.co.nz/asciidoc/userguide.html#toc33

Could you please try one or both of the following escape-sequences?

\.gitmodules
#.gitmodules#


Thanks

--
larsh
