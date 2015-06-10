From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Wed, 10 Jun 2015 15:50:32 -0700
Message-ID: <xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:50:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2opT-0000Bx-UP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 00:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbFJWug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 18:50:36 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36273 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbbFJWue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 18:50:34 -0400
Received: by igdh15 with SMTP id h15so7196182igd.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ubsqa7PY6DSOcX1O0xKxb47hFuu+QYS3hCwovE7my1M=;
        b=MB03HfADu0EwfdTKAaXsuYXz38jOxoeHpbG5DS0REF+uL9xEPeGXQNz17kzau7qOZx
         WkotD8od0lE0pCr6CI0+joGxwdLFkasMWq9cod30tmUfjVaNNmSANke3EQwc/yL426Hx
         kWNGop1tgKLK8YwDBUzDZFdw4z9HVflsUqap8XSJQlT9JCv9542wAbcgxCd5eL7rmuro
         H0WdADZdT2oA6tKvZRo7RT9XJ7VLr4JxLPnrqMsJmrDjK/UI1+hSps9HCj7L5+S6LR3c
         iEoPBbDg+M8U2wGnEpV3g+y4UUGKXrkmx+7l0WQQl5qrEeuarEyB4X4zRT0hN4vcHCbC
         K19Q==
X-Received: by 10.107.38.149 with SMTP id m143mr7478721iom.49.1433976634077;
        Wed, 10 Jun 2015 15:50:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id rr5sm4178290igb.7.2015.06.10.15.50.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 15:50:33 -0700 (PDT)
In-Reply-To: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Tue, 9 Jun 2015 16:28:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271364>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The final piece in this series is the conversion of struct object to use
> struct object_id.  This is a necessarily large patch because of the
> large number of places this code is used.
>
> brian m. carlson (8):
>   refs: convert some internal functions to use object_id
>   sha1_file: introduce has_object_file helper.
>   Convert struct ref to use object_id.
>   Add a utility function to make parsing hex values easier.
>   add_sought_entry_mem: convert to struct object_id
>   parse_fetch: convert to use struct object_id
>   ref_newer: convert to use struct object_id
>   Convert struct object to object_id

It seems that the last one didn't make it...
