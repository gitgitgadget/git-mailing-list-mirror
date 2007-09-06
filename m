From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Thu, 06 Sep 2007 10:49:44 -0700
Message-ID: <46E03DB8.8060809@midwinter.com>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLUG-0002zh-Vm
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbXIFRtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXIFRtq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:49:46 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:50377 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754528AbXIFRtp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:49:45 -0400
Received: (qmail 6032 invoked from network); 6 Sep 2007 17:49:45 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Ru0UUmkSxGtIuUsw+IwglQTk0J0/l9NJUnO285MayFgyB2ABpN1WS9Cz2xkNzQl8  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Sep 2007 17:49:45 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <1189096669534-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57916>

Lars Hjemli wrote:
> This makes git-svn always issue the --first-parent option to git-log when
> trying to establish the "base" subversion branch, so the --first-parent
> option to git-svn is no longer needed. Instead a new option, --upstream
> <revspec>, is introduced. When this is specified the search for embedded
> git-svn-id lines in commit messages starts at the specified revision, if
> not specified the search starts at HEAD.
>   

This is a much better solution -- I can't personally imagine a scenario 
where I'd want anything other than the --first-parent behavior, so 
making it the default is much more convenient. Thanks.

-Steve
