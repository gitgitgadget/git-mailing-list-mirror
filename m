From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:25:40 -0800
Message-ID: <20160225232540.GU28749@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5I3-0001oT-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbcBYXZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:25:44 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33982 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcBYXZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:25:43 -0500
Received: by mail-pf0-f178.google.com with SMTP id x65so40816277pfb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HWiqLbfA0D1b/e8mACr02T7hgi2m8taEvHd1jP4FYxs=;
        b=GhKGpKTJhYUmznd4zXeZ+kFTeBuRJHtg3WZCWFCDdW4+mJM5AuC95q7X5dsywpal2r
         WLAuittYK2fTl3tH4ngffeMu7uT7c2wf+MymtR7S8BrAgxciaNAPYMCk8fZuHTyYef9r
         fHxkAAQg/U/pYVvGezrg00aV/EzhtdQW9r/1zl4F7kd2mjSbtBf9obgNAYLYmvxAIQDJ
         B/aOqrEAwBBc23TlMdt9bbK7mMncCJT/omDge3HEaubPEvkxeqpjKoLArI75+k6DvnMU
         PUIOHT7VH+zRKYvIhU9WOKLazkZMxQ6nxNqOs/zSsGqOfbRLCESFHbaIx2CNgtAlUf82
         hPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HWiqLbfA0D1b/e8mACr02T7hgi2m8taEvHd1jP4FYxs=;
        b=X2c4PF9jbnOB1LLuthSBcwH4z9zo9IQaUbqtL5DkxxtYVKQ6Xzl3tWDsnqZvpyRLPh
         Vszrh3uxoo5ez59jMzagdQP9yYl3YvS1PoMylM68wU/ue4mLa9DZlhfrErTNh/0eG1pc
         sgSyEY/tMcxtmVGdBpKpvIcYMBfCgVrGG52E4uKZ5rgbW9PIUc1nKmi4CuBD6hPeWUaN
         XBCZ9CdmC6K/pAKgUJfJG8Bum/fft43CKh1YBTowAIF5yLDo0gjJTr+KDyDiNPMzw2B/
         hsy5XfNt68I9/bolq0BiaKo1N+r9jZ41fV4/W7TjYG/zyNHABXscL8xjv7QktmACoLiy
         eGeg==
X-Gm-Message-State: AG10YOS4UhbfWW+HIuhtt8lIrnTFucc7kVEA0WXIMVu0bmGxOd8q/DETF8SXZbBtbV7zaw==
X-Received: by 10.98.80.80 with SMTP id e77mr66864552pfb.126.1456442743011;
        Thu, 25 Feb 2016 15:25:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d4a8:9152:117:98a9])
        by smtp.gmail.com with ESMTPSA id ti6sm14594199pab.4.2016.02.25.15.25.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 15:25:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287491>

Stefan Beller wrote:

> Interdiff to v17:

Except for the bit about 'prefix',

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
