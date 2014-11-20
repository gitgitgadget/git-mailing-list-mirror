From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 1/1] refs.c: use a stringlist for repack_without_refs
Date: Thu, 20 Nov 2014 10:37:57 -0800
Message-ID: <20141120183756.GE15945@google.com>
References: <20141120021540.GF6527@google.com>
 <1416506666-5989-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:38:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWcP-0004jQ-1k
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbaKTSiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:38:08 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44562 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402AbaKTSiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:38:07 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so3321744iec.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 10:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SCw/HeTAJjYX8+XSuPXYoUFXn0ETDGTCOfI9DFiSb3g=;
        b=BTuZTYnL0a4uv42r3DQUHRgohXbqimu53ThR7JKBuyf9Uv15nL48MmkKA8tDgLcMEB
         QdQN8UuvPC7sCEd4+I7eZyXeWPfRaSGPAhdMe82vcsKfyfgIeWSjvTHesQrXupqXSVU4
         5FUKnR/SRxtb1u0AYKBXtKa0q6TFnmmIMkwWri8FPWghlvdxPdD7HQ9v18SZC6DPACZG
         sQdp1jhfIW2SKMX55W9+yx4DtT56fy2I5sWDeF2zk7At0dA+jcTmJgl9y6r3CKmwFOQQ
         ZOBsZVxpRo62zxspRdoBgcLrVajFHRR6ku2JOy78v79YzCgnZwJOhzaxrNS2F92IZQNa
         O4XA==
X-Received: by 10.50.98.101 with SMTP id eh5mr18079205igb.31.1416508686589;
        Thu, 20 Nov 2014 10:38:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id xb4sm1896739igc.11.2014.11.20.10.37.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 10:38:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416506666-5989-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 10:04:26AM -0800, Stefan Beller wrote:

> [Subject: refs.c: use a stringlist for repack_without_refs]

One more nitpick. :)

s/stringlist/string_list/

Thanks,
Jonathan
