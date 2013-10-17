From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Thu, 17 Oct 2013 11:48:55 +0200
Message-ID: <525FB287.7020204@gmail.com>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 17 11:49:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWkCU-0001CA-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 11:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab3JQJs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 05:48:58 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:33605 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3JQJs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 05:48:57 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so925718eae.38
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=cBNQGnrHGtGP/pWlz/m9I3ZEf2P2c7K27TwnGQT34/w=;
        b=LHhtFfpko5LEyC5GM5jqVBHYM0UMH6U8N8GfJCG3KG7wAYfCObuv9yYZEhQavAyglg
         nDXmx5NhERAFQohsebAmlcilPEm3JB0IkfZVnnLhpxyctD2sbrdnn8HbcfXHb+Vnsexg
         PitANnayoWdwWteLFoDhtWX6AOgI0DtRF2ltJs3d2pWojqEHC9oH+ZGcC1QL1/GdX+g6
         VTnDLu0xZzkg/s6Yb0PwyD+Il6u9HzSwNGhpbswVOpiaMrB24a7aIL6tc7Nzk7CMUPrn
         5ItBVmxBOltdtcJV+VxSEpHNPqydJ74xW/Hx6f8Yu8E8T+cKQF6vfYviq6j1r4xAtTmF
         MkaA==
X-Received: by 10.14.194.131 with SMTP id m3mr11566900een.45.1382003336231;
        Thu, 17 Oct 2013 02:48:56 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a6sm190740429eei.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 02:48:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236291>

Am 16.10.2013 23:43, schrieb Junio C Hamano:
> * kb/fast-hashmap (2013-09-25) 6 commits
>  - fixup! diffcore-rename.c: simplify finding exact renames
>  - diffcore-rename.c: use new hash map implementation
>  - diffcore-rename.c: simplify finding exact renames
>  - diffcore-rename.c: move code around to prepare for the next patch
>  - buitin/describe.c: use new hash map implementation
>  - add a hashtable implementation that supports O(1) removal
> 

I posted a much more complete v3 [1], but somehow missed Jonathan's fixup! commit.

Btw., the test suite didn't catch the uninitialized variable, neither on mingw nor linux nor with valgrind. Is there a way to run tests with STACK_POISON or something?

[1] http://thread.gmane.org/gmane.comp.version-control.git/235644
