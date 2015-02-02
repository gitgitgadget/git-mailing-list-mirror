From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [RFC PATCH] diff: do not use creation-half of -B as a rename
 target candidate
Date: Sun, 01 Feb 2015 21:52:09 -0800
Message-ID: <54CF1089.6020804@gmail.com>
References: <xmqqegqaahnh.fsf@gitster.dls.corp.google.com> <xmqqfvapuhkk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 06:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI9vm-0003QP-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 06:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbbBBFwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 00:52:13 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47963 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbBBFwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 00:52:13 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so78040632pad.8
        for <git@vger.kernel.org>; Sun, 01 Feb 2015 21:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=2tRlCCnpQ7kps9V096MWTRZ3A/YRc3gwrkUVN1VPszA=;
        b=Z8fnBF/oej96aRsF3K3aw43pmKRJWU3ghyNvjcITVqi3LtDlmEHBUrS9WJRYB208YO
         pAvRRVlqqGoo5vsHk+J9GZroblo6AKwWIFpxSjPNsn1yOJ5gc72KsfYwOnxFlakzk0bj
         Tg3x5BlVxikrtcHrqalQkXuDhTLVDElN/fZejIx/I7gMUKtkb61Qwd8Z8JlU3E6WT8DG
         cWZHrFTsrJKIibI65LxWnjyhF8sCdYCq9y3nveCu2yzQYWEpsZPCOa7Swc4UiIMiKEMi
         jlo1eAmp8r1+9xC+caq1QjYSWecDjhBIA4sYlLge7tLhY4jjozDj1Ry++I2+lxLRaQZN
         ecYQ==
X-Received: by 10.68.209.133 with SMTP id mm5mr27401480pbc.54.1422856332356;
        Sun, 01 Feb 2015 21:52:12 -0800 (PST)
Received: from [192.168.2.3] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id c2sm17562431pdi.25.2015.02.01.21.52.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2015 21:52:11 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqfvapuhkk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263248>

On 01.02.2015 19:18, Junio C Hamano wrote:
> When a commit creates new file B by copying the contents of an
> existing file A and making a small edit and makes large edit to A,

This part is hard to parse
"When ... and making a small edit and makes a large edit"
So large or small? It's a bit hard to parse and understand when just
trying to read the first sentence. IT becomes clear (somewhat) later.
