From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 15:19:07 -0700
Message-ID: <20150429221907.GS5467@google.com>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:19:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnaK4-0007rL-6z
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 00:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbbD2WTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 18:19:12 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33608 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbbD2WTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 18:19:10 -0400
Received: by igbpi8 with SMTP id pi8so116465433igb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7r05doeJj3UJNYk6Z1VBRjQU+aS+O/clISUdozfYac4=;
        b=gnPUP4VFuC5p3bQViWz5mPQLJ/HVXqPlztxR75AX+h3anMuzYBbUhrEfRPxLKrZVMg
         lTI87p7ygywAcG79k34lNE3g/Cb1lsH6r+SxNR5RvKqcB8QCizQUPLeWpPFM5a86zf4Y
         omGcvbQktJdUBDiuxejBMYDSz865JFZM+nEveBBLKYv6smRoPCDaFlYqk16LeHuCSCa9
         qluUmxQ4pl12dKfH+US9slxPnG6gXfMBAiegpXqu5NWuCV22lX8LWeVI+abbsSbJohlp
         XdtFLhMQFUGeIdxKK/Ov/e7rUDE5Wp+PhQ1WCxHC5zCxLl90d7QGQZ7eFvhzYBv1HcxL
         A7xQ==
X-Received: by 10.50.77.13 with SMTP id o13mr30908254igw.39.1430345950164;
        Wed, 29 Apr 2015 15:19:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:71e2:5d4a:c0e6:7f1b])
        by mx.google.com with ESMTPSA id n9sm10076289igv.13.2015.04.29.15.19.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Apr 2015 15:19:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150429214817.GA2725@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268030>

Jeff King wrote:

>   1. Git has to make a decision about what to do in corner cases. What
>      is our cwd for relative links? The project root?

I don't follow.  Isn't symlink resolution always relative to the
symlink, regardless of cwd?

Thanks,
Jonathan
