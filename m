From: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
Subject: Re: [PATCH] git-imap-send.txt: remove the use of sslverify=false
 in GMail example
Date: Thu, 11 Apr 2013 18:55:03 +0300
Message-ID: <5166DCD7.2030105@gmail.com>
References: <51657E59.7030001@gmail.com> <7vmwt6mdjg.fsf@alter.siamese.dyndns.org> <20130411152617.GA14264@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 17:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQJqb-0007zc-5W
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 17:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab3DKPza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 11:55:30 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:35682 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3DKPzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 11:55:06 -0400
Received: by mail-ee0-f52.google.com with SMTP id d17so828619eek.39
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2Htin+tP0uVE80p2fZvnNAox6tsLq23H/J7VjJTwaAQ=;
        b=b9Kw6YNEvUectsYWW0z4sukgIfKz+t313GqhCEI4LxmZT/AI/Qs/zNGvxsLDrT5Egs
         GIemwb1QFe6hPW0cBn9X6S53ARYxiLbi8kVFyGI5cHYY1a+/yasEQ4feucX/qs1bhNRz
         eQuKIcjgyywqt/QC6cSocEyM3+y/AOW3Yk8PGGboZjp6MQt2DA2Wt/XyG+66RHv4oLVp
         KOTSZsV1T6KjsdUUulxbYF6bq0b4zDcax30EeHl014Jrmb01hJiIPfvMPIjIPu5NZ+3E
         Xo2CaSF3o81DMEy7R6khEgwGMnltwwxquauyO/TyiqIId1IeSOE5G6rjFhResHunwbe2
         J01w==
X-Received: by 10.14.214.65 with SMTP id b41mr18203506eep.37.1365695704986;
        Thu, 11 Apr 2013 08:55:04 -0700 (PDT)
Received: from [192.168.16.100] (5-15-249-103.residential.rdsnet.ro. [5.15.249.103])
        by mx.google.com with ESMTPS id cd3sm6329816eeb.6.2013.04.11.08.55.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 08:55:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <20130411152617.GA14264@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220884>

On 04/11/2013 06:26 PM, Simon Ruderich wrote:

> I think we should remove sslverify = false from the other example
> as well. "Recommending" sslverify = false is IMHO a bad idea as
> SSL provides no protection without verification.

Yep, that was why I thought there should be at least an example without it.

Should I create a new patch removing them all?

-- 
Barbu Paul - Gheorghe
Common sense is not so common - Voltaire
Visit My GitHub profile to see my open-source projects - https://github.com/paullik
