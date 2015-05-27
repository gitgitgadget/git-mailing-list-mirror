From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/56] Convert parts of refs.c to struct object_id
Date: Tue, 26 May 2015 22:12:40 -0700
Message-ID: <xmqqsiaiioxj.fsf@gitster.dls.corp.google.com>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqa8wsbgd8.fsf@gitster.dls.corp.google.com>
	<20150525194007.GH26436@vauxhall.crustytoothpaste.net>
	<CAGZ79kbxrPhcMUFx3OY1s_qk4TkUcBgscDwqSvrLtDXmF1YwWw@mail.gmail.com>
	<20150527000436.GA4342@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed May 27 07:12:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxTe3-00069g-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 07:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbbE0FMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 01:12:43 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34545 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbE0FMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 01:12:42 -0400
Received: by ieczm2 with SMTP id zm2so5520395iec.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lmPIgod7k+xNBvHC2NDL5NlxvU+wm+SI+djj7QYO7kU=;
        b=q31x33czna0vKmojz2nq08qyplPpOF3y1RGDOwzq7u8U3dr3D89njOw+YQKpDHnKGS
         qgiuTOEUNVEA2DAIadp6I5zUA55bsGU0e9wceykvSbID36dxZ5ycYt73PjWprjchyY4Y
         CnzI96f/GMSmRin57R5A2kFn/KQ8ytUlzur/cE8NFWcfSfdXIhvk/fTOKBGpzkHD9qmn
         V+T7FwxP9mU395dquOvQh3hnkksOB88p0c3/lgY4jzF5lTBsIOC0XaQ4VOBEQ/vSvr6z
         qeR8kf+KKdpEF26o3e55E7zpEhIwxyWJsE8qQc4WA5DNNSu8oSrPIareG7/DP8U8NqvM
         aJcg==
X-Received: by 10.50.164.138 with SMTP id yq10mr1521591igb.29.1432703561980;
        Tue, 26 May 2015 22:12:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id m193sm12756449iom.19.2015.05.26.22.12.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 22:12:41 -0700 (PDT)
In-Reply-To: <20150527000436.GA4342@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 27 May 2015 00:04:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270013>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If Junio would like to add my sign-off to the end, he's welcome to do
> so:
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Heh, too late.

Thanks for explaining the true flow of patches, though.
