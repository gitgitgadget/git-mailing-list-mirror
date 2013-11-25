From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gettext CTYPE for libc
Date: Mon, 25 Nov 2013 11:31:02 -0800
Message-ID: <20131125193102.GM4212@google.com>
References: <52900FD6.5020202@gmail.com>
 <CACsJy8CMUMdzJyDABFj47oY8j8kKr5K88niXoM0o4dVQkWvkqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	git-malling-list <git@vger.kernel.org>, 698867@bugs.debian.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 20:31:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl1sG-0002qS-SB
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 20:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352Ab3KYTbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 14:31:08 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:33730 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab3KYTbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 14:31:06 -0500
Received: by mail-yh0-f53.google.com with SMTP id b20so3169864yha.40
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 11:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7pjaNExPdYzdVqzv+eHRVHKW+hqH8+eSOw28PWs/dqA=;
        b=zWiiamqtVDmxF50jl+Jzo5Tww+Pk9VdB5cHKMGkTkht6FA3VAFIxv5hzD/nB2lOJLX
         GObRuIgCYu5RaUL/wDh/Nc75yOAMq+SlIiQbiH9L4h4oSbfbc1Zd561ZnJQpwyO+iTym
         J8fMi8cjTxCTX0Wc69fWHnF0mSV8e47cLAWh6yxnZKnfb6Y9Gbhqs9oWqWfAgZYPf/zD
         BeE2ksEGvPlr4dxJSNgA7ErMYYaShWxRUYekLhxcCwr7zcOIiodclQbkXfq42O4/OLsv
         kRjCsszAg3sz7pSM9Bik2Pj5UV6PIb2hPLe8RSodEGCEN3NOE5Tw/+KwA0dO6mSN7NFz
         FgnA==
X-Received: by 10.236.143.10 with SMTP id k10mr69757yhj.116.1385407865401;
        Mon, 25 Nov 2013 11:31:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q44sm33241162yhg.10.2013.11.25.11.31.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 11:31:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8CMUMdzJyDABFj47oY8j8kKr5K88niXoM0o4dVQkWvkqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238332>

Duy Nguyen wrote:

>             Do you think it's ok to revert the workaround if we detect
> the running glibc is fixed (or if it does not run glibc at all)? I
> think we could use gnu_get_libc_version() to detect it.

That would be wonderful.

Thanks,
Jonathan
