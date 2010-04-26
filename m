From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Mon, 26 Apr 2010 13:37:55 -0500
Message-ID: <20100426183755.GC11378@progeny.tock>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
 <20100425194800.GB14736@coredump.intra.peff.net>
 <20100425220955.GA25620@progeny.tock>
 <20100426172235.GA626@coredump.intra.peff.net>
 <20100426175707.GB11022@progeny.tock>
 <20100426180731.GB4012@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Cheng Renquan <crquan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:37:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6TBD-0000jv-L8
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab0DZShF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:37:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61049 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0DZShC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:37:02 -0400
Received: by pwj9 with SMTP id 9so8638992pwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T9OJFL41eG1Nhw+K+hEGttFBXwp77puCeEtMO+epVR0=;
        b=Gvspeiswu6oKDL59g9RENfJPTLFuCwzsXjeaI6VKMYsB8YClGoqhjJWdVqV7ilxjWX
         EsNjhiTq1PiTe3Yn4MIWafUqrsMWWH5mc5FFXnJzRa5aWzMgp+Nx/OeSzy+NyOOvbCYD
         zmtajrx3OzMr5O7+ZBAfZDktjj10z6beiDqxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=njsdvmgzMi/pTidzTswC5KyzBpple22hIKeyzxrYSPDEtK4I5dXDK3PdeafRpKVgQ0
         ODHAZBmyFx89PEyKTEXM0rfUS9gMvgp2mJWqaED2Pxn4r+EST+4VB1cq5bVKU0triZxL
         udB719QVpekJi6Mwjn/8+eVzCORUFntenx0Q4=
Received: by 10.142.207.19 with SMTP id e19mr2259489wfg.186.1272307021399;
        Mon, 26 Apr 2010 11:37:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4405030pzk.13.2010.04.26.11.36.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 11:37:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426180731.GB4012@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145845>

Jeff King wrote:
> On Mon, Apr 26, 2010 at 12:57:08PM -0500, Jonathan Nieder wrote:

>>  [log "format"]
>> 	changelog = "* [%h] %s"
>
> We usually reserve the [log "format"] for when "format" can be an
> arbitrary string. I'm not sure if we can use some nicer syntax like
> [log.format]; I'd have to experiment.

Alternatively, we could use

 [logformat]
	changelog = ...

which is arguably just as clear and may be closer to existing
practice.  But really, I am happy as long as the configuration exists.

Jonathan
