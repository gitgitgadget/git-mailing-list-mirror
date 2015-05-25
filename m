From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/56] Convert parts of refs.c to struct object_id
Date: Mon, 25 May 2015 12:34:59 -0700
Message-ID: <xmqqa8wsbgd8.fsf@gitster.dls.corp.google.com>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon May 25 21:35:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywy9U-00072k-NM
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 21:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbbEYTfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 15:35:04 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36125 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbEYTfC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 15:35:02 -0400
Received: by igbpi8 with SMTP id pi8so42367325igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XiXeyG3pzrmwsTq4xFl3KczlgVFbbHaWJorXuopxUK8=;
        b=VsDrMW4cRYdtbEKcKnRsAEWo1w1DgcDsk6Wc4oPyiTLfgnbEh2pj09GNYcWb27fBXW
         XNwLP91BSp11dEZu0RrLTRTwYJIHn1Gr6I45G5LE1u7HYYM593ZiP0gJxTJTnfGMZCbY
         6mPYAOCttRzR8OAKl02yWMXeWR//au94KneOdeb5XJc8p+LROH9fnQXcQQ9Y8Bni9TUz
         PKmlhPyHOPtikpoYtbF91itqTv0ksrYBmoy5lMGJric+ZMn1K1CK+DehAeBYkuZg3YBR
         FfbF7UB1ESNwvzsIjkSR4JHgtNvmlzQFZyGTFQ3DFsAXNvFfKM5VGKiDr+StJT2fVmUN
         svfA==
X-Received: by 10.42.154.201 with SMTP id r9mr20872371icw.77.1432582501913;
        Mon, 25 May 2015 12:35:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id f126sm9355845ioe.21.2015.05.25.12.35.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 12:35:00 -0700 (PDT)
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Mon, 25 May 2015 18:38:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269907>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Changes from v2:
> * Adopt Michael Haggerty's patch series that uses an adapter function.
> * Squash some of these patches together where it makes sense in order to
>   reduce the quantity of patches.
>
> This does only slightly more than my original series, just in a
> different way, with a larger number of much smaller patches.  If the
> quantity of patches is too large for people's tastes, I can do a v4
> based off of v2 that has less of this problem.

Thanks.  I think these all look good.  And clashes with in-flight
topics seem to be manageable ;-)

[PATCH 01/56] was authored by you but has Michael's sign-off, which
looked somewhat odd to me, though.
