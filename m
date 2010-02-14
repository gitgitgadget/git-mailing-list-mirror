From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 06:21:18 -0600
Message-ID: <20100214122118.GA3630@progeny.tock>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
 <20100214064408.GB20630@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgdTi-00049p-8s
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 13:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493Ab0BNMVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 07:21:24 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:43600 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758473Ab0BNMVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 07:21:23 -0500
Received: by iwn39 with SMTP id 39so1368901iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 04:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K4qPBs/Xe32c6L3IVCTDK/eGIZg6ZA90kwlkDRRZI5Y=;
        b=i30tpyob+vrgyuWGzKgEJaSxWROjk8XZbiDJbCKxuNhEEHsveyQqUWEfACl5z8jaAl
         UNMVpt1LdPn+TFLnYuysWK36QSWXpOaZ/clYSogjXnawJuOxALhmRJgsdZsN9AchXzSU
         g8NQUcyNPle4nvLM23yAUeRIyVUgYCVG1CFSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pFRSMOqBktwkG22W4xF1+iP8f9qGqHMPohpGlYcyUP7TabH1JyFToZguobAQpL/nKa
         fINBLdEysFJcqQilS/E07e4CoX4UtrblQWmrlfWByVFJN2LtFbLRfUo5y2Lua2Mb5Cnf
         Mr1PJ5mq1kArRQ56YzKpTSdyRD9Fs3jpmMaNM=
Received: by 10.231.150.142 with SMTP id y14mr2303152ibv.32.1266150082352;
        Sun, 14 Feb 2010 04:21:22 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm5196635iwn.3.2010.02.14.04.21.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 04:21:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214064408.GB20630@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139907>

Jeff King wrote:
> On Sat, Feb 13, 2010 at 05:01:15PM -0500, Mark Lodato wrote:

>> Make git-branch, git-show-branch, git-grep, and all the diff-based
>> programs accept an optional argument <when> for --color. 
[...]
> My only complaint in that respect is that there are no tests.  However,
> I'm not sure we can get a very satisfying test, since the test scripts
> may or may not have stdout going to a tty.

See [1]. ;-)

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/139831/focus=139906
