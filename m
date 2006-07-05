From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git reset --hard include/linux/config.h
Date: Wed, 5 Jul 2006 19:05:27 +0200
Message-ID: <81b0412b0607051005s59315296tfb68345959a14c1b@mail.gmail.com>
References: <20060705165801.GA11822@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 19:06:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyAoe-0005uU-Eb
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 19:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWGERF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWGERF3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 13:05:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:737 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964903AbWGERF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 13:05:29 -0400
Received: by ug-out-1314.google.com with SMTP id s2so257637uge
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 10:05:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aTBm7oGQzvHGfvJQr3OypA0sTkg2q+hyWDKw5DWYuWCdkP+htXHt5FiTlymCmwD6mrkp9ep04n7lsbUeAFM0BD+tjPL8aNtw/KgHlSC95f0cZ6fq+jSXNDnKbPLc9zdyJrsQfWrnbRiGPW35wsz8hzVCvx62dcu6W40Z9w0TOi0=
Received: by 10.78.165.16 with SMTP id n16mr2440292hue;
        Wed, 05 Jul 2006 10:05:27 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Wed, 5 Jul 2006 10:05:27 -0700 (PDT)
To: "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <20060705165801.GA11822@mars.ravnborg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23357>

On 7/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> Also what is the right command to bring back a file to the original
> state after doing some modifications that was not needed anyway?

git checkout HEAD include/linux/config.h
