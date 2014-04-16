From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitignore vs. exclude vs assume-unchanged?
Date: Wed, 16 Apr 2014 16:45:55 -0700
Message-ID: <20140416234555.GA4309@google.com>
References: <b3f480af1c362c615ad9ce85296e2be2@bellandwhistle.net>
 <xmqqy4z5go1y.fsf@gitster.dls.corp.google.com>
 <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: alex@bellandwhistle.net
X-From: git-owner@vger.kernel.org Thu Apr 17 01:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaZWq-0008MT-G8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 01:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbaDPXqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 19:46:03 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34918 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbaDPXqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 19:46:01 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so11493700pbc.27
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XfLRAfkXWtJN/ONW0OxdJK3r7STxO4WFSgidNl1dg+A=;
        b=Ywtd9WfCN7FkUn/+YoSepmZpAd5Y/KSqHsGW88us+QEmnBVKwUy0SiK4C6+Dfdm0v5
         M+xSV++w/H1fDwG+pmJQlKaz8a1ofwrBICE6hqDf/Fzxf8eS+ooE81GyK8wlV5nOzFY3
         8mI7rpVj6jhNm9H427k73WGxQSDvZL1uock1xE57o/mlTsK06jEYYfurWlumMAz/1QpI
         aNSFx+R7a/43nSFLBdUyvXrKVwFmZogd2rczBFDawqE3Kwh71yly8Qy55mJBLylYg9Q0
         Db2iIhv9Y19E/oNuHT8Ko47KvGbPuEp087PN+9XADd+1iHtIO5pOuvkXO9daDivfhmHy
         09Wg==
X-Received: by 10.68.163.100 with SMTP id yh4mr11812613pbb.122.1397691961222;
        Wed, 16 Apr 2014 16:46:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yv5sm49443936pbb.49.2014.04.16.16.46.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 16:46:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dee7ee673c8c4d81fb5aaecea25e9709@bellandwhistle.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246393>

Hi,

alex@bellandwhistle.net wrote:

> In particular, 'exclude' is spottily documented.

Where did you expect to read about it?  I see some mention of
.git/info/exclude in the gitignore(5) page, but I wouldn't be
surprised if there's room for improvement there (improvements
welcome).

>                                                  I realize the docs
> are structured strictly as an API reference,

No, the docs are meant to be helpful, not just to confirm what people
already know. ;-)

Thanks,
Jonathan
