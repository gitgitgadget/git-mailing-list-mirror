From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 12/13] Documentation/Makefile: update git guide
 links
Date: Sun, 24 Feb 2013 22:31:45 +0000
Message-ID: <512A94D1.3050900@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-13-git-send-email-philipoakley@iee.org> <20130224145831.GL1361@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9k7B-0006SF-B2
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759491Ab3BXWbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:31:48 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:61797 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758625Ab3BXWbr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 17:31:47 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAJqTKlFZ8rke/2dsb2JhbAANOL52glqBJ4MSAQEBAQM4QAEQCxgJFg8JAwIBAgFFBg0BBwEBsliSLI8OB4NAA6op
X-IronPort-AV: E=Sophos;i="4.84,730,1355097600"; 
   d="scan'208";a="409999577"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 24 Feb 2013 22:31:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130224145831.GL1361@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217011>

On 24/02/13 14:58, W. Trevor King wrote:
> On Sat, Feb 23, 2013 at 11:06:00PM +0000, Philip Oakley wrote:
>>   OBSOLETE_HTML = git-remote-helpers.html
>> +OBSOLETE_HTML = everyday.html
>> +OBSOLETE_HTML = user-manual.html
>>   DOC_HTML=$(MAN_HTML) $(OBSOLETE_HTML)
>
> Should be '+=' instead of '='.
>
Well spotted. That maybe part of why my make of the documentation failed.

Though the 'new' giteveryday gituser-manual don't build as man pages, so 
I may simply leave them with their old make process - If I understand 
correctly they are in the right place and just need the 'git' prefix.

However I'm biased by my Msysgit/G4W experience which always assumes 
--web and fires up the HTML version so there may be issues with the 
plain .txt version attempting to be displayed as a man page if it 
doesn't follow the format. (my linux laptop was a repair of a 'scrapper')

Philip
