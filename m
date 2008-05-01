From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [PATCH] Documentation: hooks: fix missing verb in pre-applypatch description
Date: Thu, 1 May 2008 10:56:16 +0100
Message-ID: <18071eea0805010256j7f442230od4e0483905830b2b@mail.gmail.com>
References: <20080501101759.0f40268e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio Hamano" <junkio@cox.net>,
	"Pieter de Bie" <pdebie@ai.rug.nl>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Manoj Srivastava" <srivasta@ieee.org>, git@vger.kernel.org
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 01 11:57:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrVXg-0000hu-Og
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 11:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758877AbYEAJ4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 05:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759507AbYEAJ4S
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 05:56:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:47061 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758857AbYEAJ4R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 05:56:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so490997fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rCbRTvNBU4b3BLmOwYWoYiJIngP1ZcCtrjIJ1XE5Vus=;
        b=vczEPJHVF1UebtAMtTbJItg0bMnyqrFbFXCwmJqXCBWhsSbywCTUBFYjTSDsgO8GmJw6CaLbQ8mju/ZFp8E2Pcs00JAZU1wFxMQid3zSuDrL8Fy68Hyo9SA0duWo0UQzdnxKj0lrBWj2QZnya6IxxNjnPsUFVPlZ+7UncRn6Cgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJFWfC7QeZOti+KJYE23d/qYbzUDodSlBqO35QcMswzCHGdw9nz8ILhc7fb7fA2JFeH1tMD8KsCtUCIO3PiH6pzAu35Ix9QjMmzWrdt9hZXwWbaeQ+4J6LfcBwKjIFy7QaUASDeuRktvj4tFaZFFQE3f5ZiBlWv9q87YbW8ePKQ=
Received: by 10.82.189.6 with SMTP id m6mr225604buf.4.1209635776625;
        Thu, 01 May 2008 02:56:16 -0700 (PDT)
Received: by 10.82.170.5 with HTTP; Thu, 1 May 2008 02:56:16 -0700 (PDT)
In-Reply-To: <20080501101759.0f40268e.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80895>

On 01/05/2008, Christian Couder <chriscool@tuxfamily.org> wrote:
>  +If it exits with non-zero status, then the working tree will not be
>  +committed after application of the patch.

That's even worse.

"committed after application of the patch".  Too formal, and a little odd.  Try:

"committed after applying the patch."

-- Thomas Adam
