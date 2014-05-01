From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 14:22:02 -0500
Message-ID: <53629eda40a52_76612eb2f062@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Marc Branchaud <marcnarc@xiplink.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 21:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfwiq-0006Nm-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbaEATcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:32:41 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:45905 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaEATck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 15:32:40 -0400
Received: by mail-yh0-f53.google.com with SMTP id i57so3304796yha.26
        for <git@vger.kernel.org>; Thu, 01 May 2014 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=IV66srgldwnGtmo1MiiItsfsRSX7G5yrWYOfzvzk9u4=;
        b=prSQiEOR7nss5iCtlpt2Jq6RtP1JqTEiRZFxVFhQMpWuZvOiT3hEyCw9xZo/GLqhZm
         pnRlG5mYUPzpoAfaYZPNbHA2c05DY56dsemfaZTwEgLSgkrB7IziUVggl4scblg0x3IJ
         loRRgivOol3jNMcs3fCsVaB6IsNWY/HbXV10UdmhZ481jUB0+CCol53uFwqZuh/H6Qx/
         EG/pSlBLI3kLBXejGr2cTNOiCv+On3lo792c1Ct8w1XAP+4UQ6R2rQ1p3krnexoy876Z
         AXiY+Fxw+rB+lnbStyGOHgDxlmXC08GQ5+Z1d8VwdHXvwWVc/3tQQs1t3AGY2Q0SYC9w
         hPng==
X-Received: by 10.236.23.163 with SMTP id v23mr17481439yhv.58.1398972759847;
        Thu, 01 May 2014 12:32:39 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j76sm50439001yhi.33.2014.05.01.12.32.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 12:32:38 -0700 (PDT)
In-Reply-To: <5362664C.8040907@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247830>

Marc Branchaud wrote:
> What's more, it seems to me that the only real advantage "git pull"
> provides here is a less typing compared to the non-pull equivalent:
> 
>   git fetch main-repo
>   git checkout main-repo/maintenance-branch
>   git fetch developer-remote
>   git merge --no-ff developer-remote/topic-branch
>   git push main-repo HEAD

You mean `git push main-repo HEAD:maintenance-branch`, right?

-- 
Felipe Contreras
