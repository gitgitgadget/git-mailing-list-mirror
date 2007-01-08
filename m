From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Mon, 8 Jan 2007 16:18:59 +1300
Message-ID: <46a038f90701071918y4a8078can90ae69dd1d9f9ffd@mail.gmail.com>
References: <1168218683853-git-send-email-martin@catalyst.net.nz>
	 <7virfiz3at.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90701071813g7b892af1y2cfa620ef2656657@mail.gmail.com>
	 <7vd55qz2d1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 04:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3l2R-0000ko-D1
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbXAHDTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbXAHDTA
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:19:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:54572 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030465AbXAHDS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 22:18:59 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7889982wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 19:18:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lY6MwyKUvGNdd33kjLmMHikIH41n8gXcJAsgMRCiViUlxCLPInGbz3MFA7j2MFvCf0mIS37L9ttJFWlpoOEzF5sXDjKfck1/9DSKh07xrgN1hmVgNwtwRu5yZEDta6jYktZzquupufqr76IwIHbOVo2U6v28AgVoFdjM6ynTnHI=
Received: by 10.90.118.12 with SMTP id q12mr1765446agc.1168226339272;
        Sun, 07 Jan 2007 19:18:59 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Sun, 7 Jan 2007 19:18:59 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd55qz2d1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36230>

On 1/8/07, Junio C Hamano <junkio@cox.net> wrote:
> Well I meant to say that my conclusion is that that flag is not
> needed in practice.

you are getting soft in your old age, man :-)

More seriously, as soon as I sent the patch I thought of the use case
you describe. Not everyone is as patient as you are, and someone may
have things scripted. If the cvs repo is local/fast and under your
control, it doesn't make sense to be _so_ conservative.

Also -- by having the flag we get an excuse to mention it in the doco.


m
