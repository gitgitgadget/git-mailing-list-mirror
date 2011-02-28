From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: AIX problems
Date: Mon, 28 Feb 2011 20:23:17 +0100
Message-ID: <4D6BF625.70107@dbservice.com>
References: <EFD0AEC9-BEF8-412C-920F-DE6FAADBA544@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 20:23:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu8gx-0004K9-KB
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 20:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab1B1TXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 14:23:25 -0500
Received: from office.neopsis.com ([78.46.209.98]:56037 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab1B1TXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 14:23:24 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.084,BAYES_00: -1.665,TOTAL_SCORE: -1.581,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Mon, 28 Feb 2011 20:23:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <EFD0AEC9-BEF8-412C-920F-DE6FAADBA544@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168135>

On 2/28/11 8:16 PM, Perry Smith wrote:
> make
>      SUBDIR perl
>      SUBDIR git_remote_helpers
> gmake[1]: /usr/bin/python: Command not found
> gmake[1]: *** [all] Error 127
> gmake: *** [all] Error 2

$ make NO_PYTHON=YesPlease

tom
