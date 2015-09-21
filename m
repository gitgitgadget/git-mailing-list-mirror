From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4: use replacement character for non UTF-8 characters in paths
Date: Mon, 21 Sep 2015 13:23:13 -0700
Message-ID: <xmqqwpvj8qtq.fsf@gitster.mtv.corp.google.com>
References: <1442825358-90294-1-git-send-email-larsxschneider@gmail.com>
	<56005BDD.6050508@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 22:23:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze7cO-0003R8-4G
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 22:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbbIUUXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 16:23:16 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35347 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbbIUUXP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 16:23:15 -0400
Received: by pacfv12 with SMTP id fv12so128323799pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DkNdgpMp3plsFCSvNbhAtypgTQk2/cV2sPdqU0jgIIM=;
        b=J7mb8aSgnLN36guV8GTMQJPwK4768QTsmDDcWLK5JBo0+uhdu/0A7zAcEKjYGzLhrZ
         /vs1ktr2xOL0FEFQLI6IeMeMOr3DWcwGvH0DAPuqUoJ1AON0IC+9dFdNbllsBZ1lTBui
         Z12xnkD/c1WKjtymTIdIo/7JLHfp64IoXfMebodCRKanYzQ5loX4zLx6c3DpPnDiGIxe
         KxaUGV1nWE+OMzt1MYo6UNojAwnjuElHqd+w+PHaV7nLUx3UBQw9nTAcPPU0EfjWhEJz
         pq0W5paaqgpb6dZduTO1jhXl2+u6PUJBMZP5GiANIYV2Jp5lOnzArI7OlVmUhrjGYia5
         qyIw==
X-Received: by 10.69.26.38 with SMTP id iv6mr26771314pbd.151.1442866995023;
        Mon, 21 Sep 2015 13:23:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id uy4sm26119209pbc.69.2015.09.21.13.23.14
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 13:23:14 -0700 (PDT)
In-Reply-To: <56005BDD.6050508@diamand.org> (Luke Diamand's message of "Mon,
	21 Sep 2015 20:34:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278330>

Luke Diamand <luke@diamand.org> writes:

> On 21/09/15 09:49, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> I broke a test in "[PATCH v2] git-p4: improve path encoding verbose
>> output" on the next branch.
>> This patch on top of next (3dd15c0) fixes the issue.
>>
>> Thanks to Luke for finding the issue!
>
> Looks good to me, apart from using a UTF-8 char in the comment itself,
> which seems a bit unnecessary. Imagine what will happen to someone
> using git-p4 to mirror git-p4 itself into p4!

;-)  Thanks.

>
>
>>
>> Cheers,
>> Lars
>>
>> Lars Schneider (1):
>>    git-p4: use replacement character for non UTF-8 characters in paths
>>
>>   git-p4.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --
>> 2.5.1
>>
