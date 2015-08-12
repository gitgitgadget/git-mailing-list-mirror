From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/4] submodule config lookup API
Date: Wed, 12 Aug 2015 10:53:58 -0700
Message-ID: <xmqqio8kl7ex.fsf@gitster.dls.corp.google.com>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
	<xmqq8ubk7idb.fsf@gitster.dls.corp.google.com>
	<CAGZ79kakGg6Ejworq5xVr2QuzLHxh=E6tzU_PoW+0M6AWuKJfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPaE2-0001G9-R2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 19:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbbHLRyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 13:54:01 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35898 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbHLRyA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 13:54:00 -0400
Received: by pdco4 with SMTP id o4so9791952pdc.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n86zD8NSptXlpxtSnfX+MK4O9OqyyZaiq8YXQo+r5l4=;
        b=UdlmvLBkUlftzknVDa9nTSg+AjLthqUmzKW/5CL1UByayqDk3kbMpJUjPVTkj6EAkB
         oGVIi3K2i06Cz+1rDLSEQejqh18AP/wCwgUsPpvWRS4dazP4Vf4xNJM79jvpIpSM2497
         BvV1A9MXkXQxbNu2DGerv9lL+gCOE1gQCgVdsvqY5r1AQPVAGFV2ik+or9L7d4ueWjTk
         C7uy21B3pEhZNsNmnds0GVfggwGs8zx9B1FTuk0zJgQsnlb8qrB+yzgYQiZlh4z7pg7I
         8TV5BP6n12n/w78YDry9TUokUgLvU8P4X+plGLWt0F1fXLBYbDzKqy5ilKmdV/qiMbV2
         53/A==
X-Received: by 10.70.44.228 with SMTP id h4mr14785666pdm.45.1439402039862;
        Wed, 12 Aug 2015 10:53:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id j17sm4187767pdl.59.2015.08.12.10.53.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 10:53:58 -0700 (PDT)
In-Reply-To: <CAGZ79kakGg6Ejworq5xVr2QuzLHxh=E6tzU_PoW+0M6AWuKJfg@mail.gmail.com>
	(Stefan Beller's message of "Mon, 10 Aug 2015 12:23:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275788>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jun 15, 2015 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks.  Will replace and wait for comments from others.
>
> I have reviewed the patches carefully and they look good to me.

OK, I recall there were a few iterations with review comments before
this round.  Is it your impression that they have been addressed
adequately?

Do you prefer it to be rebased to a more recent 'master' before you
build your work on top of it (I think the topic currently builds on
top of v2.5.0-rc0~56)?

Thanks.
