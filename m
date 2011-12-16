From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: How to commit incomplete changes?
Date: Fri, 16 Dec 2011 02:49:57 +0100
Message-ID: <4EEAA3C5.2070907@dbservice.com>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Fri Dec 16 02:50:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbMw6-0008Gs-A3
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 02:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab1LPBuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 20:50:03 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65457 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab1LPBuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 20:50:01 -0500
Received: by eekc4 with SMTP id c4so2745935eek.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 17:50:00 -0800 (PST)
Received: by 10.14.99.197 with SMTP id x45mr2215087eef.114.1324000200069;
        Thu, 15 Dec 2011 17:50:00 -0800 (PST)
Received: from calvin.local (gw.ptr-62-65-141-13.customer.ch.netstream.com. [62.65.141.13])
        by mx.google.com with ESMTPS id a60sm31521763eeb.4.2011.12.15.17.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 17:49:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111123 Thunderbird/9.0
In-Reply-To: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187261>

On 12/15/11 12:24 AM, Hallvard B Furuseth wrote:
> I'm about to commit some small edits which go together with bigger
> generated changes.  It seems both more readable and more cherry-pick-
> friendly to me to keep these in separate commits.
Why do you store generated code? Usually you only store what is 
absolutely necessary. That means generated code should be generated as 
needed (part of the build process for example).

tom
