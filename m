From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 42/43] refs: add LMDB refs backend
Date: Thu, 03 Sep 2015 16:16:09 -0700
Message-ID: <xmqqbndjgkli.fsf@gitster.mtv.corp.google.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	<1441245313-11907-43-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXdjr-0002Rn-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 01:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525AbbICXQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 19:16:12 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35445 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbbICXQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 19:16:11 -0400
Received: by pacfv12 with SMTP id fv12so4390272pac.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OZlvT2jLIWTBozWbaGvzc1vr9f5ax0L+fX7Zg9+9KVc=;
        b=LtYmJN+k/DN8ptR21YWsyhwq8QQrkFvHUTmF1Y6AmakJ5q/LsKcxqc03O5lMyr6eli
         sratPihw4cYT+cEfGKj6QiF7QS4ORleaaCu3Ubk2bDoF7JpPSKjUN8mGzLVxLCyjmu3e
         +iicHT8q5S2G3hRRr25BD0zYw4+8aZqnI7Oo1kGzipDH0OF0oBDEdVUZofh0ry+wKm8f
         s63Y0py5khBt9YjdhPRtjH6IFj9tqfj+fDkGzc3zHDd5dIAEOKNHUStyiVKeYmdMvIHd
         gaMLvn4imgJW+zX2ZpK4W1R3Y1Ss99EWTM2Bs2ax2gncM5xI2T35NXyDZGdfpEe8+/P5
         h7jA==
X-Received: by 10.68.133.167 with SMTP id pd7mr1005072pbb.23.1441322171188;
        Thu, 03 Sep 2015 16:16:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id u5sm218155pdr.63.2015.09.03.16.16.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 16:16:10 -0700 (PDT)
In-Reply-To: <1441245313-11907-43-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Sep 2015 21:55:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277280>

David Turner <dturner@twopensource.com> writes:

> Add a database backend for refs using LMDB.  This backend runs git
> for-each-ref about 30% faster than the files backend with fully-packed
> refs on a repo with ~120k refs.

Nice ;-)
