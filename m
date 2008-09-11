From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 08:33:23 -0400
Message-ID: <48C91013.4070907@gmail.com>
References: <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net> <20080910223427.GB22739@cuci.nl> <20080910225518.GA24534@coredump.intra.peff.net> <20080910231900.GF22739@cuci.nl> <48C8A9A4.7030906@gnu.org> <20080911075539.GA27089@cuci.nl>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 14:35:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdlO3-00025a-Da
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 14:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbYIKMd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 08:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbYIKMd2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 08:33:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:24322 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbYIKMd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 08:33:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so105639ywe.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EWM/JBQWA/4IqH9PYgtc/JGuu4UBtOofv/QdFaaspDs=;
        b=o/VOheMMZ2muLHl7ZUd0xNw/zCBXSOYu5n8IxrPhb7kQpkiSqe9CWcitJSaJxRtgTE
         hRVmS09fYEHKnhOMz378WVZoKcyMSlNGFnRHujZqOoUb7PEBwCcT9Q+YKax3XrH5JAOM
         4ZbgvovqEq96vxWwhjHkS3Ixs9SJ/RABD1EQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=s/pLY09oQSf7REUYU8iWtvW4w1EWGlQM/R0IyiZbNSYX/ZERmPFI5yInee4Q7vPp2X
         MWxnm0is98064HIOTutqVOkSG1erNPvLQjIa2wpWQr/8xJvaZA3SRSdHgpY/r9VJ9Zxs
         YT7RyXEZOLdKvD65E8vEK8wqTDbfKTM4P7buw=
Received: by 10.100.111.5 with SMTP id j5mr3407187anc.3.1221136405956;
        Thu, 11 Sep 2008 05:33:25 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id p60sm9301226hsa.8.2008.09.11.05.33.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 05:33:25 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20080911075539.GA27089@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95605>

Stephen R. van den Berg wrote:
> It would fit with a non-mutable version of the notes.  Then again, we
> already *have* the non-mutable version of the notes, it's called the
> header of the commit message.

Almost correct. Remove "header of" from the above and you'd be correct.
