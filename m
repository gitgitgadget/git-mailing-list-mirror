From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 06/13] Add guide-list.txt and extraction shell
Date: Sun, 24 Feb 2013 22:12:54 +0000
Message-ID: <512A9066.3040204@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-7-git-send-email-philipoakley@iee.org> <20130224145113.GJ1361@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:13:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9jpB-0001zD-GC
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759368Ab3BXWNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:13:11 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:53893 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758762Ab3BXWNK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 17:13:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAEmQKlFZ8rke/2dsb2JhbAANOMFQgSeDEgEBAQECAThAAQULCxgJFg8JAwIBAgFFBg0BBwEBiAkSqjeSLY8OB4NAA5dakk8
X-IronPort-AV: E=Sophos;i="4.84,730,1355097600"; 
   d="scan'208";a="409998620"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 24 Feb 2013 22:12:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130224145113.GJ1361@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217009>

On 24/02/13 14:51, W. Trevor King wrote:
> On Sat, Feb 23, 2013 at 11:05:54PM +0000, Philip Oakley wrote:
>> +# Usage: ./generate-guidelist.sh  >>common-guides.h
>
> Following David's recent series, it's probably better to use a
> lowercase 'usage' [1].
I prefer the Initial capital version to suggest the start of a sentence, 
but I can go with either way.

>                     Also, I'd expect '>common-guides.h' would make
> more sense than appending with '>>'.

My mistake. Will correct.

>
>> +/* re-use struct cmdname_help in common-commands.h */
>> +
>> +static struct cmdname_help common_guides[] = {"
>
> This is probably just copied from generate-cmdlist.sh, but maybe it
> would be a good idea to #include "common-commands.h" here?

I was trying to avoid nested includes. Eventually, if the series is 
accepted, I'd want to refactor the guide generation into the existing 
command generation so that .h file would then disappear.
>
> Trevor
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/216961
>
Philip
