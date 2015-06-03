From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC] Week 1: Unification of 'for-each-ref', 'tag -l' and 'branch
 -l'
Date: Wed, 03 Jun 2015 22:12:02 +0530
Message-ID: <556F2E5A.90700@gmail.com>
References: <556DDC21.5050801@gmail.com> <vpqh9qoepv1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 03 18:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0BkB-00026L-U3
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 18:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbbFCQmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 12:42:10 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33591 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbbFCQmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 12:42:08 -0400
Received: by pdbqa5 with SMTP id qa5so11256114pdb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Sx24wtNGToeFNRHM4/i2LvAX9sGjkUo/SbXn3jRxKAY=;
        b=DRjTeQLede179hgr7qqzlaG2bn6GPUm6zQ0vJYpgJHkDGqs4Mxr7pbPCcSfokkCCvW
         BFQw0WxJ1oVErgQ1FapTeb6PPwHz7Bp7kqD3tdInN2tuf0MHps+PPTW31kHwvIIXGtS5
         2FEHVgPJdols7MzIo0rYfjJFWP0d/qSX9l/QBQM9aJbD7ayku+r0klMpfkzMUJfJvB1l
         eVuH3iUdHyd8bIRaZi11yPkmNDG/O/tkULEecVRys0toSOQtBi7/abx7EDiNksE+u0DV
         zR8uDar6EIDS0T7rDJaUbDkHRAhS8+p22p0r2CErhWfWH34LNhVDAHyQyLE6fiCupWAg
         xdkQ==
X-Received: by 10.68.130.98 with SMTP id od2mr8532632pbb.73.1433349728260;
        Wed, 03 Jun 2015 09:42:08 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ld1sm1274412pbc.26.2015.06.03.09.42.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2015 09:42:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqh9qoepv1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270695>

On 06/03/2015 09:38 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Matthieu Moy suggested that I work on the unification of these
>> commands let both the implementations stay where the user can select
>> the implementation to be used
>
> Just to be clear: my advice is the above with "user" = "caller of the
> API", not "human being using Git". In other words, "git branch
> --contains" and "git tag --contains" would still be using two different
> algorithms, but the user wouldn't notice (except for performance).
>

Thanks for clearing that out, I should have said "caller of the API."

-- 
Regards,
Karthik
