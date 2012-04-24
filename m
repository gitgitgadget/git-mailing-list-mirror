From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply, index-pack and bundle
Date: Tue, 24 Apr 2012 12:50:57 -0700
Message-ID: <xmqqobqggb8e.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<20120424121953.GA25944@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMllP-0007YJ-QU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab2DXTu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 15:50:59 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:61152 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121Ab2DXTu6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 15:50:58 -0400
Received: by yhgm50 with SMTP id m50so122833yhg.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=h+50olxKcrCi8RKcHfXMbs+vcFt87vKhJWtzZ8pXxDA=;
        b=dzNAcTHYWN3IRY8fwx1ywF0m/2wsollEAhdih0sptUqvp1sEyOjr7riOi9dxDHd9uW
         zim8RpNXayj/O11gM5ClN7SGHTG50dkm5IzdzGD4dqSFSeOQZQFTG+NwyNu/7YQa2Kxo
         NqZGhh4mKw8vu98+AFN5tUOVtk7Y4qBI4ws1GttNwMIEkMpdmonRCJ5BX7wxaGjttK3N
         kGuIPM3H1/36fa1D793hEKUKvvUdswgeRUq4iKF4tiGSoKjhZxy6V0bhItWOLlHGUtfx
         VEh2yVIf3e5BPnnjF28U62ZABSvrIKXCLkJppKrSQBieL5iYd5MpVooN7/i6dBXUcbOa
         AOyQ==
Received: by 10.236.125.170 with SMTP id z30mr26227686yhh.4.1335297058385;
        Tue, 24 Apr 2012 12:50:58 -0700 (PDT)
Received: by 10.236.125.170 with SMTP id z30mr26227657yhh.4.1335297058244;
        Tue, 24 Apr 2012 12:50:58 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id v39si2886085anp.3.2012.04.24.12.50.58
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 12:50:58 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 172F910004D;
	Tue, 24 Apr 2012 12:50:58 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id B704CE125C; Tue, 24 Apr 2012 12:50:57 -0700 (PDT)
In-Reply-To: <20120424121953.GA25944@do> (Nguyen Thai Ngoc Duy's message of
	"Tue, 24 Apr 2012 19:19:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmYEJBosb9/MVtSu7TI7rz4QnrduvenKVUMve5uT3rWgQqDQStUgTuAFGveF94gBhtl8lU+e0PdfJAF80iRyJjjdQfR/APz1PhUrB8lRL3fo+hCqdWfNuxeIXIWyFUnKeatPfKY9uVS8RzBn4hBD424FmhFyRjOlwxmsdVYjEwGPOUXXTo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196243>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Apr 23, 2012 at 07:30:20PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> I attempted to
>> convert all struct option, and it turned into a huge series [2]. Not
>> sure how to submit that series yet.
>>
>> [2] https://github.com/pclouds/git/tree/parseopt-i18n
>
> The 62 patch series looks lame compared to this approach, but cross
> compile guys, including myself, will hate me in principle.
>
> The idea is modify all git commands and output all marked strings in
> "struct option" and usage strings, instead of manually marking them
> one by one. The marked strings will be collected by xgettext just lik=
e
> another source file.

Gaah, my eyes, my eyes.

No thanks.
