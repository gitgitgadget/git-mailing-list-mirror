From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: handle symlink replaced by file
Date: Mon, 6 Dec 2010 22:26:10 +0100
Message-ID: <AANLkTi=ZxrnfjoXHHwUC8p7KwXiGgjXwGr=6BMBzjB6R@mail.gmail.com>
References: <AANLkTi=dA+mj1KDpAgGAtg1S5Gt5wXAJ4zLd-tLob=DH@mail.gmail.com>
	<8739rqqb4m.fsf@fox.patthoyts.tk>
	<AANLkTi=P+sKzYSkeS2-N+DerP3zdRgrDnuNuXbK0O89s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:26:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiZx-0000x0-Er
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab0LFV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:26:26 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43364 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab0LFV0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 16:26:25 -0500
Received: by ywl5 with SMTP id 5so6282929ywl.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=y/ZqfZKMUD05TKSmVZFsAZkRi5IiUz3vKsdfQwpopA8=;
        b=KK3OxMSdp8AHMNA4MqfqdP59n5SGnuQGFp117tKnu+zi7d+cKTApDwbXVJkqAw1/LG
         ZdRDTe2HgTGrPlFJGo5ua0NoYP1HqZ0O1jOazv20NyY29x3A/OW8PSkFXjjXLbDYtG7o
         bVV6W3asUSQV7bXJliSb7tS3CLQ5NEy+SydJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TQFxwWmGq/QDxiaSWi7XlxB7ReLkCxoo/rwcuGUgj93s5Vz0Xr8mYaIolFkJ7uOXN8
         zNnoZsUB63JAS1htvQzGPdkP90xPcFKb00AxJYNH46LTTWW1Uxk7cnNjpDNYC585xeY0
         3KocT2sLUAQ13sC2V9F1vP38LCBMz1cXy10iE=
Received: by 10.42.223.138 with SMTP id ik10mr1607035icb.425.1291670770866;
 Mon, 06 Dec 2010 13:26:10 -0800 (PST)
Received: by 10.42.172.193 with HTTP; Mon, 6 Dec 2010 13:26:10 -0800 (PST)
In-Reply-To: <AANLkTi=P+sKzYSkeS2-N+DerP3zdRgrDnuNuXbK0O89s@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163026>

On Wed, Nov 3, 2010 at 21:07, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Thu, Oct 28, 2010 at 14:27, Pat Thoyts
> <patthoyts@users.sourceforge.net> wrote:
>> This patch just handles the second segment without generating the error
>> really. It doesn't attempt to do any pretty output.
>
> Thanks for the patch. I haven't test it yet. Actually I can't find
> documentation, that git outputs two diffs when the path changes the
> type. And I have no idea how to present this in git gui.

I have a better fix for this. But haven't the time to send it yet.

Bert

>
> Bert
>
