From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: t9118 broken in current master, 9918285, git/git/v1.7.2-rc2
Date: Thu, 08 Jul 2010 10:06:35 -0400
Message-ID: <4C35DB6B.4090002@gmail.com>
References: <4C352EB5.5020005@gmail.com> <68AF81DF-7434-4493-8FBF-6DDEF27BFAB1@silverinsanity.com> <8E6B46F9-41B7-4902-8910-A13144005C12@silverinsanity.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 16:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWrkS-0002gH-Vd
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 16:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156Ab0GHOGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 10:06:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44892 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0GHOGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 10:06:38 -0400
Received: by gwj21 with SMTP id 21so380137gwj.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ake65G5F5uU94NPjPjI53dMKwZP1PFbCrag0aIOZPtQ=;
        b=XexOwKBCnXnG744R8i3SlH8d1GeJ6+DgRMJPbM4saL34Ct8qeDyhe49yHj61SdCkhd
         Pgmipa52h50RcgnuG4ab5/Il35u/g1CU7BpPL0onpxXUVb1z4xZ0cw1Btg14WjWA2uOh
         1GCgEYZxLul92zm6K50sTDvkUUqNuLrD7QaTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=SuxR0Y0rIBoMww52uaRKktP7uk3keg/+Q978brs0x4Kmd0Ki3bp+OVG04OszfutW1E
         nEtBv4fvBIM5Pq8zGdIXy8hTAFYhb8oRzE3+Jp743QtvVzqVu9P5EVKADsnbGzV41pt4
         eCLLjZmw7QwI0j/yRCXUCscP/5Ui/zZl5BsfM=
Received: by 10.150.202.9 with SMTP id z9mr357058ybf.25.1278597997327;
        Thu, 08 Jul 2010 07:06:37 -0700 (PDT)
Received: from [10.0.1.133] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id w4sm8601196ybl.22.2010.07.08.07.06.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 07:06:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <8E6B46F9-41B7-4902-8910-A13144005C12@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150576>

On 07/07/2010 11:42 PM, Brian Gernhardt wrote:
>
> On Jul 7, 2010, at 11:15 PM, Brian Gernhardt wrote:
>
>> I'm getting intermittent errors in t9115 instead.
>
> Okay, but intermittent I mean that I had SVN_HTTPD_PORT defined in one place and not the other.  It actually caused failures in tests 9115, 9120, 9142.  Running tests in parallel appears to break the SVN httpd setup and teardown.

If the test suite now fails if the tests are run in parallel then that's 
a new breakage. As of f526d12 "make -j4 test" was still passed on my 
system. The cut-n-paste in the email I sent last night was from a run 
without the -j4 make option so the problem is not just running the tests 
in parallel.
