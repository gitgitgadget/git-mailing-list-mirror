From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 21:13:56 +0200
Message-ID: <8c5c35580705241213y64f8ec5eg1f1afbdf25413769@mail.gmail.com>
References: <Pine.LNX.4.64.0705241039200.4648@racer.site>
	 <Pine.LNX.4.64.0705241230410.4648@racer.site>
	 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241315290.4648@racer.site>
	 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
	 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
	 <alpine.LFD.0.98.0705241105210.26602@woody.linux-foundation.org>
	 <7v7iqyxdp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, skimo@liacs.nl,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Alex Riesen" <raa.lkml@gmail.com>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 21:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIl6-000060-Ji
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbXEXTN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbXEXTN7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:13:59 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:30577 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbXEXTN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:13:57 -0400
Received: by nz-out-0506.google.com with SMTP id n1so111673nzf
        for <git@vger.kernel.org>; Thu, 24 May 2007 12:13:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iYYziLQbTAncMkTmI74XnH1WdzjOmLX3Miw37ImAaZLR3skTyBfaGv7Z1HEbaRR1RgHQdwzN0R2NpHNC/tCupmMa8NX+sIZLBdoIiB4R/MPpGLChhuCpBL9ZUDaxPIgQ7N6/D/nm7Jis8taZJPHMwCvnAh3oxd72YRtuSUiVG0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cZUuMQjpvtKX5Y4jXc53cS1jSSKZa4ney6f8t8YKhT2ZSvQRn3deFPOGwrhOYsY+vsch2h1Fri4QoP8dz6fHVOQwhhVOmEasf4WAaoh6q6NtR/K8efsUi9wTmKTsSkRzdiZIh0QoJCtx17hx8FIRKvVT3KhBo9lBROx3DQtOE90=
Received: by 10.114.61.1 with SMTP id j1mr1091286waa.1180034036936;
        Thu, 24 May 2007 12:13:56 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 24 May 2007 12:13:56 -0700 (PDT)
In-Reply-To: <7v7iqyxdp6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48293>

On 5/24/07, Junio C Hamano <junkio@cox.net> wrote:
> While I disagree with some design decisions Sven's series made,
> I am happy that the series is there for people to comment on.
> It helps us identify the design issues by making the differences
> of opinion people have on them stand out.
>

Possibly offtopic: I'm not so sure there should be any --submodules or
similar options to clone/fetch/checkout/merge/diff etc.

What I think would be nice is some porcelain support to manually init,
update and see the checked out version of selected subprojects, but as
standalone commands.

This would make it easier to start using subprojects, and it wouldn't
force any specific politics on it. And hopefully the experience of
actually using subprojects will make it more obvious how to add
extended support later on.

Just my 2c

--
larsh
