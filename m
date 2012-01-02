From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Re: Possible submodule or submodule documentation issue
Date: Sun, 01 Jan 2012 19:53:33 -0800
Message-ID: <1325476413.1718.20.camel@yos>
References: <1325013859.1987.65.camel@yos>  <4EFB725C.7030600@web.de>
	 <1325127030.1681.35.camel@yos>  <4F00780C.7090801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 02 04:54:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhYyI-00083s-LB
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 04:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab2ABDxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 22:53:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38216 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab2ABDxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 22:53:39 -0500
Received: by iaeh11 with SMTP id h11so28646199iae.19
        for <git@vger.kernel.org>; Sun, 01 Jan 2012 19:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=QXiF02fXIegYrpuQvlX+u18SvCHSNQVHWcZtriypDIg=;
        b=QQHIhIwqQ7eZ4f4zwTXXB1UhzedlEUk5c6SRPveU7ydVnbkLoihb2TAcNfy5j4etbK
         cZ9H5mXRFNvKKPaQmIU6GiQq1NmcFgnMZB0DsQMO/eoorzPc2lBAD5RJJmAD2C2X0Zek
         b7PvE63/lv0eb0NKp5e8LGk05PKqjfo6DrRoI=
Received: by 10.50.158.193 with SMTP id ww1mr55489470igb.26.1325476418758;
        Sun, 01 Jan 2012 19:53:38 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id lu10sm80638987igc.0.2012.01.01.19.53.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 Jan 2012 19:53:37 -0800 (PST)
In-Reply-To: <4F00780C.7090801@web.de>
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187833>

On Sun, 2012-01-01 at 16:13 +0100, Jens Lehmann wrote:
> Am 29.12.2011 03:50, schrieb Bill Zaumen:
> >  So what about clarifying
> the docs: ...

Clarifying the docs is a good solution given that a possibly large
number of existing repositories are dependent on the current behavior.

One way of explaining it is to say that "git first appends a
'/' to the superproject's origin URL if that URL does not already
end in a '/'. Relative URLs for submodules' origin repository are
resolved relative to this modified URL." Then the reader can simply
apply the normal URL rules.

I think either is OK - it's simply a judgment call as to which 
explanation is easiest for a typical git user to understand.
