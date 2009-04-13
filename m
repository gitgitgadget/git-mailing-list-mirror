From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor
 = ...'
Date: Mon, 13 Apr 2009 16:39:52 -0700
Message-ID: <49E3CD48.1010809@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com> <1239647037-15381-2-git-send-email-mfwitten@gmail.com> <1239647037-15381-3-git-send-email-mfwitten@gmail.com> <1239647037-15381-4-git-send-email-mfwitten@gmail.com> <1239647037-15381-5-git-send-email-mfwitten@gmail.com> <1239647037-15381-6-git-send-email-mfwitten@gmail.com> <1239647037-15381-7-git-send-email-mfwitten@gmail.com> <1239647037-15381-8-git-send-email-mfwitten@gmail.com> <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 01:41:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtVmM-0005qG-GK
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 01:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZDMXj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 19:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbZDMXj5
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 19:39:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:52054 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZDMXj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 19:39:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2326107rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aqZhqHPooEZrVPe2QTeNTg++uRTvpN+8xYTAOzzYLGA=;
        b=YlpeWQ5XCd3xMPC9LWZmErCeFRhYiKKYuoYXOeJVZ+/fbM5enqRIrlll+HhONAIrLh
         dTHAQPG9WIFwQh43xtOfFA+LK6UU6hZzE3zWbWyHOhYGBJK3PBmN/MkqcfvMPJ6oSf1o
         1v7n4cKut7j9xJOhruw7mTz8015O5eakArL78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Tk67Hv4oEWGjUVNs61TAOSvypmc61+mRhDjUa/SwBTWMKgn4/B8Il/2b3t0oXlnL3I
         diKZUNOlC4fHAWT7+bN//jaPnCW659Bg3Dvkgx9B2t20CAXjIYA/ME0xuocUXSEgtnTQ
         AypQHOAYlG+eXdB+UhwpL/aRD9oz9Cx+wjDHA=
Received: by 10.114.59.1 with SMTP id h1mr3397331waa.72.1239665995568;
        Mon, 13 Apr 2009 16:39:55 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id m6sm6277112wag.14.2009.04.13.16.39.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 16:39:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
In-Reply-To: <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116504>

Michael Witten wrote:
> -	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";

I don't want to start an editor war, but why is 'vi' here? It seems that one of the previous four should be set at all times, correct?
