From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 12:46:32 -0400
Message-ID: <CALs4jVFpr=YVAagJSEkAJ6qGJmYWNdu4ZXXvMYQRd0KYQXcVQA@mail.gmail.com>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com> <5320818C.8070200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:47:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNmJ1-0001eW-CB
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 17:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbaCLQqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 12:46:54 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:36523 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbaCLQqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 12:46:53 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so11675101wes.31
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9g2YCrV/SPtNJ7g3CYlbvRUGtbqwd8sCRot+LyvkNZU=;
        b=DhON3RvPNa19MInqRtfJxBJ2rChrT5Dm3DArTHWazMfvEMkGOl06K3gSENoZ11INLM
         HR2hp4dIlJ9Vbf+DYx8/tBIe1IkokhZBo1dbcJHhoR4ciz0dS6Ps4wY2M6yr+VLLEKRX
         wshYyOCGDXFZvva3jxx/+EhGhvBidD5QopEbFEATEv+SxAbcTCeXVAsUalpr4SPBH6ge
         q6uwR8q8gCRUJNUEa8iBBl37N7IQ/yMYCG6XMl90ToeTQ6z/1HMjBJV24lLCWhQfbgtk
         AQRBPwsp1NS/eVCPIy5EVLyFqfy4MAWUqqyyuIcHMFVGeYnx5w2sf19RCHiCWHWPX8+Y
         pMEw==
X-Received: by 10.194.192.132 with SMTP id hg4mr17420481wjc.28.1394642812740;
 Wed, 12 Mar 2014 09:46:52 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Wed, 12 Mar 2014 09:46:32 -0700 (PDT)
In-Reply-To: <5320818C.8070200@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243943>

2014-03-12 11:47 GMT-04:00 Jens Lehmann <Jens.Lehmann@web.de>:
> I think this hunk should be dropped as the memcmp() here doesn't mean
> "starts with" but "is identical" (due to the "ce_namelen(ce) == 11" in
> the line above).

There is an issue with negation in this patch. I've submitted a new
one [1] to the mailing list. The subject line of the new patch is
"[PATCH] general style: replaces memcmp() with proper starts_with()".

Let me know if you still think the hunk should be dropped there.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243940
