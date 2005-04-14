From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Wed, 13 Apr 2005 23:35:25 -0700
Message-ID: <425E0F2D.4040507@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 08:32:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLxto-00070F-DQ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 08:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDNGfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 02:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVDNGfi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 02:35:38 -0400
Received: from terminus.zytor.com ([209.128.68.124]:56548 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261399AbVDNGfe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 02:35:34 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3E6ZP62029917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Apr 2005 23:35:26 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425E0D62.9000401@zytor.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:

> 
> Actually, the subdirectory hack has the same effect, so you lose 
> regardless.  Doesn't mean that you can't construct cases where the 
> subdirectory hack doesn't win, but I maintain that those are likely to 
> be artificial.
> 

That should, of course, be "... where the subdirectory hack does win ..."

Really, the subdirectory hack is a workaround for broken filesystems, 
and we don't use those anymore.

	-hpa
