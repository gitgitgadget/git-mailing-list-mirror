From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git diff timing oddity
Date: Thu, 6 May 2010 01:07:59 -0400
Message-ID: <u2x76718491005052207z252008c5sb0d3eafb4a50ada6@mail.gmail.com>
References: <y2j76718491005052204qb6de9c26k58eb1550f1c5346f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 06 07:08:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9tJg-0007CQ-I1
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 07:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab0EFFID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 01:08:03 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:60260 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0EFFIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 01:08:01 -0400
Received: by iwn35 with SMTP id 35so7439197iwn.21
        for <git@vger.kernel.org>; Wed, 05 May 2010 22:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=e/l244lGiNd+9zXIMJmaO99+3t4QJeRAKPGr1chQLYc=;
        b=oBbBkSCJmC77Bv/5pTOOuMCzcLeJH/n3xqbDim+hrzsSACPV+XcF/u8Vbd20YS8EDI
         kU9I3GnK1FfnOT9lvHT8P3sPfIpK+Cjn+lRIGWs/nwAPBt0WRPg9VhB7p+Fs0AvRjzsG
         riFY+y8toIWDIPiPVZP7Sixmz8vXzjcayDRmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=iWVvnocvSVCGH1PRy/jv/K69d6SAVAUxfA+AhuwNB2kWkNJDYq8TtGtUrD70C02z5Y
         YsvByGc0l1kNaQ4PBtne1VFlH5ni59f7vQ9eR67mojMUiQU61h2jQfoDLsSfayKjsjAJ
         dmuH91OL8/7sYGNXol+rR1epLBKyY35lr6TQs=
Received: by 10.231.159.134 with SMTP id j6mr805029ibx.29.1273122479568; Wed, 
	05 May 2010 22:07:59 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Wed, 5 May 2010 22:07:59 -0700 (PDT)
In-Reply-To: <y2j76718491005052204qb6de9c26k58eb1550f1c5346f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146437>

On Thu, May 6, 2010 at 1:04 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> These should be identical commands, so why is the "origin HEAD" form
> running an order of magnitude faster?

Because I'm an idiot. Three times I ran "origin" and thought I was
running "origin..". Sigh.

j.
