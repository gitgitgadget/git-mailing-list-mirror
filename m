From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] connect: learn to parse capabilities with values
Date: Fri, 10 Aug 2012 04:06:40 -0400
Message-ID: <CAPig+cT2Dtvbm=mDxYvgn8CA_zBYVcQiiMv+8pPjUvBsFAGLYA@mail.gmail.com>
References: <20120810075342.GA30072@sigill.intra.peff.net>
	<20120810075816.GC8399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 10:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzkGO-0003BM-6H
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 10:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab2HJIGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 04:06:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39752 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2HJIGl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 04:06:41 -0400
Received: by yhmm54 with SMTP id m54so1345846yhm.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RPu79uNGQ7pU++Sm/hlTsF7piYUC9cXlONPWxgJd+ZE=;
        b=IM9OkskFUKkJj0+2B1JBUB8l77SBCoALwQ40UMvpBYj0uIkg9x3xFbsfcuudwDvutz
         iv/HyIZJ7j86gJAiJ9gvfA/W0Z5IqnTtrm7gLyAyztWPi4N4CWIeyFthW4VchWBkqo6p
         cGxgjiHzkhNyXqlqcVe0vAHE77K+KSAEl7eeYp/Kn94uL0o5Y9ZqJE73oSMlvLuhbRxV
         pGqcrw0VlOL5HedI6W6KAi4pun3CeIYcvxWMpT6+VYnS/pA2QV/9QvS2GN1gCe8Ubzcq
         OCXZh8nkzRdMlpvnQGjloPTDtVpqN60LR+4REACalhPjcAMxRgh0zi1n9k3x3OQ+AFrR
         yKbw==
Received: by 10.66.73.98 with SMTP id k2mr4349200pav.73.1344586000693; Fri, 10
 Aug 2012 01:06:40 -0700 (PDT)
Received: by 10.68.24.234 with HTTP; Fri, 10 Aug 2012 01:06:40 -0700 (PDT)
In-Reply-To: <20120810075816.GC8399@sigill.intra.peff.net>
X-Google-Sender-Auth: n9kd--_KSZe0aiT-7TIr9ExfIUU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203211>

On Fri, Aug 10, 2012 at 3:58 AM, Jeff King <peff@peff.net> wrote:
> + * Parse features of the form "feature=value".  Returns NULL if the feature
> + * does not exist, the empty string if it exists but does not have an "=", or
> + * the content to the right of the "=" until the first space (or end of
> + * string).  The cannot contain literal spaces; double-quoting or similar

s/The cannot/The value cannot/

-- ES
