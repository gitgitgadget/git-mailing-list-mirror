From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Forcing re-reading files with unchanged stats
Date: Thu, 13 Jan 2011 04:12:25 +0100
Message-ID: <4D2E6D99.9060907@dbservice.com>
References: <loom.20110112T150313-103@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Jan 13 04:13:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdDcs-0001Vy-TK
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 04:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839Ab1AMDMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 22:12:35 -0500
Received: from office.neopsis.com ([78.46.209.98]:42700 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524Ab1AMDMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 22:12:34 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.076,BAYES_00: -1.665,TOTAL_SCORE: -1.589,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 13 Jan 2011 04:12:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <loom.20110112T150313-103@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165035>

  On 1/12/11 3:07 PM, Maaartin wrote:
> There are files in my working tree which changes, but their size and mtime
> remains the same (I know it's strange, but it's useful). Can I make git to re-

When can this be useful?

> read them all, so it recognizes the change? Ideally, using a configuration
> variable. The repo is fairly small, so speed is no issue here.

Try git update-index --refresh. I'm not aware of any config option, but 
you might want to look through man git-config.

tom
