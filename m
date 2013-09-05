From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 5 Sep 2013 20:26:47 +0100
Message-ID: <20130905192646.GG2582@serenity.lan>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
 <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
 <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
 <20130905080606.GE2582@serenity.lan>
 <xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHfCp-0001Sw-4J
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab3IET07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:26:59 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52628 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab3IET06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:26:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 1735B6064D1;
	Thu,  5 Sep 2013 20:26:58 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 60OGPwpwiebB; Thu,  5 Sep 2013 20:26:57 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 75B576064E1;
	Thu,  5 Sep 2013 20:26:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233986>

On Thu, Sep 05, 2013 at 12:18:45PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Wed, Sep 04, 2013 at 03:59:18PM -0700, Junio C Hamano wrote:
> >> Are there cases where you do not want to either rebase nor merge?
> >> If so what do you want to do after "git pull" fetches from the other
> >> side?  Nothing?
> >
> > One other thing that I can see being useful occasionally is:
> >
> >     git rebase @{u}@{1} --onto @{u}
> >
> > which allows local commits to be replayed onto a rewritten upstream
> > branch.
> 
> Sure, that would make sense.
> 
> I somehow thought that rebase by default looked in the reflog to do
> exactly that. Perhaps I am not remembering correctly.

It just does @{upstream} by default, which tends to get messy if the
upstream has been rewritten.
