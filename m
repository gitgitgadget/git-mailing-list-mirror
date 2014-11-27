From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Where is the best place to report a security vulnerability in
 git?
Date: Wed, 26 Nov 2014 17:20:53 -0800
Message-ID: <20141127012053.GU6527@google.com>
References: <175a570ee03dba2828cb7e129c9445c9@davenport.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hugh Davenport <hugh@davenport.net.nz>
X-From: git-owner@vger.kernel.org Thu Nov 27 02:21:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtnlU-0007Wc-QY
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 02:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbaK0BU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 20:20:57 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43107 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbaK0BU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 20:20:56 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so3760938iec.15
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 17:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D45uehUtxap66oU9Of/OPcCP1HnEERZ3bqxFf0UD8dA=;
        b=BJsh4D7IJGdw3AImCdnheJewTTuUUEj3hMABCifpClTQskADoTUqh4bpjKiq+e/ctv
         xVECUCFTfmJKipQv1xegCdaVSt9BtiHvkarm6HweDaTZb/ve0ifO8IxzNPs1noi4u71f
         vJj5ofsLLNimMvFlUJv+68uivbeagOPJKH48CyDDGVdE9BZwwwDLDLW51YDLyMzjbtpM
         VkOxpGiqjA/sRSoXjQ0nivp0P2lM1IrdKGvBe2oxY0ePrByU/BBs4jAcCwaVwYp/RjLJ
         4095YJ/+OA7R5aR3Jmp8QkAN5e8qyUM24LshfspTQCy2vL0Nq6U8fkrL1QxD/JAiOew7
         i/QQ==
X-Received: by 10.42.22.140 with SMTP id o12mr26862054icb.87.1417051255844;
        Wed, 26 Nov 2014 17:20:55 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccf6:cc10:c864:83c1])
        by mx.google.com with ESMTPSA id c62sm2857208ioe.22.2014.11.26.17.20.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 17:20:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <175a570ee03dba2828cb7e129c9445c9@davenport.net.nz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260329>

Hi Hugh,

Hugh Davenport wrote:

> Where is the best place to report a security vulnerability in git?

Current practice is to contact Junio C Hamano <gitster@pobox.com>.
Cc-ing Jeff King <peff@peff.net> isn't a bad idea while at it.

We should probably set up a mailing list to make this more obvious,
but that's what we have today.

Thanks,
Jonathan
