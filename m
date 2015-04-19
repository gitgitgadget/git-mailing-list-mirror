From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Improve client path detection when branches are
 used
Date: Sun, 19 Apr 2015 11:59:49 +0100
Message-ID: <20150419115949.770008db@pt-vhugo>
References: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
	<1429399445-11024-1-git-send-email-vitor.hda@gmail.com>
	<xmqqk2x9ndcs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 13:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjmxI-00038L-CJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 13:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbbDSK77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 06:59:59 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37830 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbDSK77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 06:59:59 -0400
Received: by widdi4 with SMTP id di4so62383316wid.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2015 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nBzV6XidWzE6Hq4K2l+hY2vq4X4Cy+YERgSNyQnThhA=;
        b=W12apqBljQeY/yV5LGAkI+KKWQlkZ0xdJ79EbhdBwBD8R2UxF+JgzBaMvRcog7ywRs
         X8j5DNGLHdhFVQvgTYcASN+aNtV97Pkzei5XYOY/00VdUWBSq8+mAuDdYDcYzFa2+E15
         EDdBR87K32S6IjLIs0eCV5wnhG9NoD35xWeIj0Ey4Jp666lHm2Cz89bJr79YuJRwBzip
         OBIyewytBEUpwGyPc9wWo4V8S5QfN30WIWigLhYxPj4ad+JX+/KPjRg9ug3XXjTmshZf
         RAv1vY/ZIEaYl+qYYbbM5PG1Hre86Wb91scT8KHFuaZwJIRAb4qxVN+3VxIQ03jhREmp
         axkQ==
X-Received: by 10.180.78.136 with SMTP id b8mr16034737wix.76.1429441197995;
        Sun, 19 Apr 2015 03:59:57 -0700 (PDT)
Received: from pt-vhugo (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id gy8sm10586648wib.13.2015.04.19.03.59.57
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 19 Apr 2015 03:59:57 -0700 (PDT)
In-Reply-To: <xmqqk2x9ndcs.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267438>

Junio C Hamano <gitster@pobox.com> wrote on Sat, 18 Apr 2015 17:58:11 -0700
> Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> This patch makes the client path detection more robust by limiting the valid
>> results from p4 where. The test case is also made more complex, to guarantee
>> that such client views are supported.
>>
>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>> ---
>
>Was this designed to be squashed into the previous 2/2 patch?  I
>do not think either 1/2 or 2/2 is in 'next' yet, and if this was
>to correct mistakes in the 2/2 that was posted earlier, it would
>be nicer to have a replacement patch with corrected log message.
>
>Thanks.

Hope I got everything right this time :)

Thanks for your help,
Vitor
