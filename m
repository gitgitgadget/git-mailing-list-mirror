From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [BUG] git-mv submodule failure
Date: Mon, 22 Oct 2007 19:46:25 +0800
Message-ID: <46dff0320710220446r51a17b34oa0f5c0043cd1076d@mail.gmail.com>
References: <46dff0320710192301p3e1d88d5l3b662b72b051d920@mail.gmail.com>
	 <Pine.LNX.4.64.0710202223590.25221@racer.site>
	 <46dff0320710202248v56af5cb0gcf7dacb32848eca3@mail.gmail.com>
	 <Pine.LNX.4.64.0710211102230.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijvjy-0004xT-Nx
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXJVLq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbXJVLq0
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:46:26 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:23305 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXJVLq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:46:26 -0400
Received: by py-out-1112.google.com with SMTP id u77so2380399pyb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yDvp66yf/I5apnY6s+oE3eeVYVfM6baIjCYeK5qI0aI=;
        b=oSkICaXLcW/0vXtc3b7QM4AqYGWhEwj9i5e0yVRipVjF73Hba2pU6QtG9fioiHoIRUaiciJFF0GY9IxGSUxZKelPg2tvqBECfmdQCj2G3wnkSu6C+nwN1rWgWL0GQi5PxokNAeTA/0HdQiPKBc3rkkt843lKlkUeamkzXE+ksZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AoowpbXSo4KCotOTBQbxpk478zeKYaWvg+RQ6AV8990hMIkqTPUyIquLuL+yUI4+19mGJMudtV3Y4Kz54ie2mt4aSOkAL+wVgLUFmpi56KPFksM9mVH8bK9m8bv6o53sAOl2sQFm0w6NYpQ0IQjIg00NFcbTA2k6+gTnhffAN40=
Received: by 10.35.129.19 with SMTP id g19mr6007896pyn.1193053585213;
        Mon, 22 Oct 2007 04:46:25 -0700 (PDT)
Received: by 10.35.52.7 with HTTP; Mon, 22 Oct 2007 04:46:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710211102230.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61994>

On 10/21/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> No.  If you "git mv" a submodule, it makes absolutely no sense to leave
> .gitmodules as is.
>
 I can modify the .gitmodule manually since git-submodule mv is not
available. Anyway, I just want a command to rename a submodule easily,
not "mv && git-rm && git-add".
>


-- 
franky
