From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 11:21:34 -0700
Message-ID: <425EB4AE.4010700@zytor.com>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:19:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM8vS-0005aH-Ho
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVDNSWC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVDNSWC
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:22:02 -0400
Received: from terminus.zytor.com ([209.128.68.124]:51341 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261367AbVDNSVx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 14:21:53 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3EILYn8009928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 11:21:35 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> 
> Opinions? Dissent? We'd probably need to escape the filenames in some
> way -- handwave over that for now.
> 

For readability and simplicity I'd suggest using either URL-style %XX 
escapes or octal \xxx escapes for anything bytes < 33, minus the escape 
character.

Although Linus is correct in that an SCM doesn't *have* to handle this, 
it really feels like shooting for mediocracy to me.  We might as well 
design it right from the beginning.

	-hpa
