From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 14:37:25 +0200
Message-ID: <8c5c35580706120537y75d7a58esd59bf20b6c4dec6f@mail.gmail.com>
References: <20070611225918.GD4323@planck.djpig.de>
	 <466E7D7E.7BAB2FD@eudaptics.com>
	 <8c5c35580706120412o516ec39p71332d23823d7389@mail.gmail.com>
	 <200706121423.02127.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:37:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy5cy-0005wo-IF
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 14:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbXFLMh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 08:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbXFLMh1
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 08:37:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:32511 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXFLMh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 08:37:26 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1632577nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 05:37:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GUb6kuRJPwpG5jfyZ37uvA3fVVkHibSL+ojTzB+gBEKHg55yTSjnTLuKue8ts52Jr/Jik+qXBOBSnKvPfc+bK+rsrkjLNm/1X/rZjcNijDHp9vtsEGGLJmPb28veAnwfJSb8C55KoBF1AykuImJtOw4IlMToqlRiNokL0vJbuSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BfjvK2hfUIxedF8VU7osNYk/b6iex/u1Xjv6+4jpGiIxgTZgbu/xtlfXX5thVlDPVVmCsLI8AWD5IMMzFCpiz2Ye9524tzInBQ3VlMGYu+xyAyesbFwJ3IT/mcilrH1T8vQybgUTZ5i9a/CTyoGXb3AF83YDwCHAS0WtAVDWjW4=
Received: by 10.114.193.1 with SMTP id q1mr6609681waf.1181651845357;
        Tue, 12 Jun 2007 05:37:25 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 05:37:25 -0700 (PDT)
In-Reply-To: <200706121423.02127.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49956>

On 6/12/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 12 June 2007, Lars Hjemli wrote:
> > I
> > would not expect the KDE 'supersuperproject' to know about admin at
> > all, neither in its index nor .gitmodules.
>
> The admin submodule contains KDE specific things. So of course it
> also would be a submodule in the grand whole KDE superduper module.

Aha! But as you say:

> But that does not really matter.

Exactly.

>
> However, to not have a lot of copies of the admin submodule
> in
>
>  .git/submodule/admin
>  .git/submodule/kdelibs/.git/submodule/admin
>  .git/submodule/kdebase/.git/submodule/admin
>  .git/submodule/kdenetwork/.git/submodule/admin
>
> the just suggested submodule.<name>.repopath to specify a repository
> outside of .git/submodule to be shared by kdelibs,kdebase,... would
> be fine.

Yes, repopath would work out nice for KDE (which btw seems to be a
great test-case for git-submodule)

--
larsh
