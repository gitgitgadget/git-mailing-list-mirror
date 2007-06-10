From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: fatal: serious inflate inconsistency
Date: Sun, 10 Jun 2007 12:50:07 +1200
Message-ID: <46a038f90706091750x446c96bfkdc1d5dd0cc59e5d2@mail.gmail.com>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
	 <alpine.LFD.0.99.0706080931330.12885@xanadu.home>
	 <20070608135054.GK2335@cip.informatik.uni-erlangen.de>
	 <20070608153722.GL2335@cip.informatik.uni-erlangen.de>
	 <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org>
	 <20070608182412.GQ2335@cip.informatik.uni-erlangen.de>
	 <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0706081202580.4205@woody.linux-foundation.org>
	 <20070608193319.GS2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Nicolas Pitre" <nico@cam.org>, GIT <git@vger.kernel.org>,
	"Michael Gernoth" <simigern@cip.informatik.uni-erlangen.de>
To: "Thomas Glanzmann" <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxBdO-00088M-Mj
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbXFJAuK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXFJAuK
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:50:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:22853 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXFJAuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 20:50:08 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1066430wxc
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 17:50:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q01VDuSUqVzBvnhNcTvfl964Hg1lEKfVWgDh3iQx//8yO+F4v0dkyN9X6H17+WBsn7yodGdaZz/Qq+rXqag05iCVvnpy0pgyBb/juZftN1RZhdBUwyr817W1L40mdQ9z3DNVemqQV3Ua4xACLaNi9kAGjtzt+JUt2d8RxVg5vuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P8V1eQPl3FqinNBO+1fyqAd0chPT0lIzMsDWnLjrkPP4utmENaoRxyAE+vJS8YXL6P2MoETViDkP+c9BM3JRzxPNRrt/mjnezkyx6oQiAz2idBzCPiirc35gRtwvsrkticq8WiAIh9ulvK5HcD14mI8dAviym2aV+JxQNJ15/BU=
Received: by 10.90.78.9 with SMTP id a9mr4166262agb.1181436607957;
        Sat, 09 Jun 2007 17:50:07 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sat, 9 Jun 2007 17:50:07 -0700 (PDT)
In-Reply-To: <20070608193319.GS2335@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49648>

On 6/9/07, Thomas Glanzmann <thomas@glanzmann.de> wrote:
> I have a very similar machine. For this one it works. It has 32 bit kernel and
> userland. Debian etch again. v2.6.20.

Wanted to mention -- we've been using git on debian sarge/etch on
several arches a lot and never seen any lib compatiblity problem.

> Does someone know a command for debian that checks the checksums

apt-get install debsums
man debsums # sorry, I don't use it often enough to remember ;-)

cheers,


m
