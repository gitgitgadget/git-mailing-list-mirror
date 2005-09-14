From: sf <sf@b-i-t.de>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects by
 proxy servers
Date: Wed, 14 Sep 2005 19:17:24 +0200
Message-ID: <43285B24.7050907@b-i-t.de>
References: <20050913153858.GB24405@master.mivlgu.local>
Reply-To: sf-git@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 18 21:53:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH5DJ-000663-Bb
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 21:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVIRTwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVIRTwb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 15:52:31 -0400
Received: from main.gmane.org ([80.91.229.2]:59825 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932180AbVIRTwb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 15:52:31 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EH5BW-0005ih-5Y
	for git@vger.kernel.org; Sun, 18 Sep 2005 21:50:46 +0200
Received: from ip-213157000067.dialin.heagmedianet.de ([213.157.0.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Sep 2005 21:50:46 +0200
Received: from sf-git by ip-213157000067.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Sep 2005 21:50:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157000067.dialin.heagmedianet.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
In-Reply-To: <20050913153858.GB24405@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8808>

Sergey Vlasov wrote:
> By default the curl library adds "Pragma: no-cache" header to all
> requests, which disables caching by proxy servers.  However, most
> files in a GIT repository are immutable, and caching them is safe and
> could be useful.

Is caching really safe? Because of compression one git object can have 
many file representations.

Regards
	Stephan
