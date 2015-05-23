From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within transactions
Date: Fri, 22 May 2015 17:52:47 -0700
Message-ID: <xmqqegm8dsio.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu>
	<xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>
	<5551BA88.3090900@alum.mit.edu>
	<CAPc5daVQEMv-QPDpyNVGzcjrjrw20QLzm8dkC0ZYAX=Y4zGaBQ@mail.gmail.com>
	<5553B1E0.9080008@alum.mit.edu>
	<xmqqr3qj857t.fsf@gitster.dls.corp.google.com>
	<555FB219.3090300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat May 23 02:53:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvxgO-0006fn-Bw
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 02:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525AbbEWAwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 20:52:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33895 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485AbbEWAwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 20:52:50 -0400
Received: by ieczm2 with SMTP id zm2so42368747iec.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yMDs0G1B0TM1QNoPHuEmNT6Du9BX9jpWq1sBzUOPdKs=;
        b=N3SbyH/YXebkuqfluXNXDLzwh16xjNjqq90dmUoWdtk7Y8egOepC1Ls1WiY+4JpYWK
         UXtJZjefu2zozK8o1uTOBtza0VdlpS6+5AnYTmd/+GPEGvx2aKkV1R6a794iGNNH3rej
         7iFmbV+seQYV2jKN9d/U/Tn9LSeZsXjkhuLFlp9l3kRyBxxvG3VWsZCSIrB036MRmCn0
         pD3bIgjPTwv9hHPCsOxvbgh3eEZvpklP+rwPa3D1wFQyY9Q5A2YHVS3p8+QQ+gzhTBdL
         g2GdIYvmxKe4QGBJY53vIgPFTWiwL1BtlHAnPOKGdBGF6/jfl5cj5iw/u4lYcHWTEtgr
         giKg==
X-Received: by 10.50.78.170 with SMTP id c10mr9057669igx.0.1432342369499;
        Fri, 22 May 2015 17:52:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id g1sm3070503iog.4.2015.05.22.17.52.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 17:52:48 -0700 (PDT)
In-Reply-To: <555FB219.3090300@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 23 May 2015 00:47:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269783>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think using 'grep' is OK for now, and if they are internationalized in
> the future the breakage will be pretty obvious and straightforward to fix.

Yeah, I think so, too.

Thanks.
