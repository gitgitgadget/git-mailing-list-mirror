From: Joshua Juran <jjuran@gmail.com>
Subject: Re: lost connection in middle of interactive rebase
Date: Thu, 30 Sep 2010 18:18:51 -0700
Message-ID: <4F91C587-981C-4429-9FDD-24931BCC9DEA@gmail.com>
References: <i83bg4$rl6$1@dough.gmane.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 03:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1UH5-0005ik-19
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 03:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab0JABSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 21:18:54 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62430 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0JABSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 21:18:53 -0400
Received: by pvg2 with SMTP id 2so646267pvg.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=4hagYIuHBCsOdwRp36QhDfbCzMZKfhE9YFzDnDgPaU0=;
        b=M+dyr49odBuK+f5K/F3PdTaJlk9p4NlU+wPZAWDSgy9oG0hrj5qTzB5v3+3ioaLdN1
         xenaFYn2zUaBfQUYAgts61b+hG5sXFoqjvFiPWhc/KvysTIwXLhM5UttI2E48wkP9SxL
         px4ZUccsYsuCNjDcLckMKZ9STty6vai5hWjlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=ON9UnjgAQexoTMKQ2ozgFrBQXIrCSsFgsFhoU5a6QJFPSif6o+ebYHDWKs6phv6d9z
         RBLnY6dU5la0ipBW3ZAp8lOsKZjmF05hi4qfzsU0OWvLSHUE6/hGAX8TNuw9fyayC/jC
         hAPWgUS3gEvJ8+NQ2dwNIjJnnizWEx/b+Ael0=
Received: by 10.142.252.21 with SMTP id z21mr4057388wfh.111.1285895933107;
        Thu, 30 Sep 2010 18:18:53 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id o16sm547777wfh.19.2010.09.30.18.18.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 18:18:52 -0700 (PDT)
In-Reply-To: <i83bg4$rl6$1@dough.gmane.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157727>

On Sep 30, 2010, at 5:53 PM, Neal Kreitzinger wrote:

> I use a terminal emulator in windows to connect to a remote linux  
> box.  The
> git repos are on the linux box.  If my network connection drops  
> during the
> middle of my interactive rebase, how do I recover?

git rebase --abort

Josh
