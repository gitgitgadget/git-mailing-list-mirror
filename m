From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 12/13] Documentation/Makefile: update git guide links
Date: Mon, 25 Feb 2013 23:43:26 +0000
Message-ID: <512BF71E.3080304@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-13-git-send-email-philipoakley@iee.org> <7vd2vp3qru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:43:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA7iB-0002xo-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 00:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759938Ab3BYXnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 18:43:31 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:27608 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759631Ab3BYXn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 18:43:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBALf1K1FZ8rke/2dsb2JhbAANOMFcgRyDEgEBAQEDOEABEAsYCRYPCQMCAQIBRQYNAQUCAQG0dJM6jw4HY4JdA6ocDQ
X-IronPort-AV: E=Sophos;i="4.84,736,1355097600"; 
   d="scan'208";a="63817559"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 25 Feb 2013 23:43:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vd2vp3qru.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217119>

On 25/02/13 05:29, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> @@ -35,6 +37,8 @@ MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
>>   MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
>>
>>   OBSOLETE_HTML = git-remote-helpers.html
>> +OBSOLETE_HTML = everyday.html
>> +OBSOLETE_HTML = user-manual.html
>>   DOC_HTML=$(MAN_HTML) $(OBSOLETE_HTML)
>
> If you are keeping track of inventory of "guides" in a new static
> array, do you still need to look up "giteveryday" or "gituser-manual"
> when the user asks for guide documents?

I'm only keeping track in the new static array of the 'common guides' 
and I'd hoped that these two could be included.
>
> In other words, can't you change the side that launches the document
> viewer so that we do not have to rename anything in the first place?
>

The current help code will only show either 'git-<cmd>' man pages, or 
'git<guide>' pages so the current everyday and user-manual pages aren't 
served by the existing help code.
	$ git help everyday
	No manual entry for giteveryday
Hence the need for the rename and 'obsolete page' entries.

I'm guessing that serving any old .txt or .html page from the 
Documentation directories isn't sensible (rather than being prefix 
based), but it is a possibility.

Philip
