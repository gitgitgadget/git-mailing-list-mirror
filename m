From: Jonathon Mah <me@JonathonMah.com>
Subject: Re: [PATCH] mergetool: Teach about submodules
Date: Sun, 10 Apr 2011 03:15:24 -0700
Message-ID: <39B95643-D7FB-436F-B407-D716D43C3922@JonathonMah.com>
References: <1302321570-85987-1-git-send-email-me@JonathonMah.com> <20110409120301.GA1369@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1213)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 12:15:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8rgI-0000Vh-Ql
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 12:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950Ab1DJKPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 06:15:31 -0400
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:4124 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755826Ab1DJKPa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 06:15:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AslJAGiAoU1i6vJRIWdsb2JhbAAMiQedFgEBAQEBAR4XiSy1WIVuBIVb
Received: from c-98-234-242-81.hsd1.ca.comcast.net (HELO [192.168.120.10]) ([98.234.242.81])
  by ipmail05.adl6.internode.on.net with ESMTP; 10 Apr 2011 19:45:27 +0930
In-Reply-To: <20110409120301.GA1369@gmail.com>
X-Mailer: Apple Mail (2.1213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171246>

Hi David,

On 2011-04-09, at 05:03, David Aguilar wrote:

> One thing that could make it better, though, would be if it
> also added tests for the feature to t/t7610-mergetool.sh.
> That will help prevent someone (like me) from accidentally
> breaking it in the future.

Thanks for the feedback. I've shoehorned some tests into the existing ones, and the patch is imminent. It can be squashed into the previous patch if that's nicer.

It would obviously be nice if you could tell mergetool to merge those submodule commits, and then have it recurse into the submodule. Submodules don't feel quite robust enough to me to automate to that extent yet, but I might keep tinkering should the urge emerge. :)



Jonathon Mah
me@JonathonMah.com
