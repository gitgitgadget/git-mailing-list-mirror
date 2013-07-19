From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] diff: deprecate -q option to diff-files
Date: Thu, 18 Jul 2013 20:31:26 -0700
Message-ID: <20130719033126.GA27853@google.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
 <1374107406-14357-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 05:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V01Pv-0005Vn-9q
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 05:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759611Ab3GSDbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 23:31:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47532 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759603Ab3GSDbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 23:31:34 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so3905187pad.30
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T4IMOV7BULETeNOxUHoo0K9fKWNgTRyxYC028enDyXk=;
        b=aQrP5864conGsWfeV0e9t61OYvPfuFY6GIim5tVCmDKnLcHjHrLLt29V9uh6NAYgPi
         td/wZsMpRFRXsEpuYGGn4JKGISSDJL8R24kMQeIh/rC3TBOCWjT+/wb4CJS1QHGz97A6
         ddqfw3SkBWist9CJsEWIWdIUgLp8B+p4487ZBISukQ1ryoQ934A0Mh/LHHVfHWgp0ryQ
         I3YYRZgcwEJsA9tfbuVmE7nvsJ/w/zt1RFGpi04pycLc82R0oSu4dMP3Vb5eo/oskcNR
         ffBymjhkwYXmNFX/wXT3CxNreNKrJ2Z/gVqMpfCc7yGEtN9TK+CT8ODQkmkL6jsECym/
         dLEA==
X-Received: by 10.66.149.131 with SMTP id ua3mr15980640pab.49.1374204694516;
        Thu, 18 Jul 2013 20:31:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qb15sm19877345pab.13.2013.07.18.20.31.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 20:31:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374107406-14357-7-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230777>

Junio C Hamano wrote:

> We should remove the support for "-q" in Git 2.0.

Nooooo.  I hope you are teasing.

I don't mind seeing support for "-q" dropped, but I really don't think
it's worth delaying git 2.0 for that.  Would s/in Git 2.0/in some
future release/ be ok?

The patch text itself looks good.

Thanks,
Jonathan
