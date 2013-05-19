From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Sun, 19 May 2013 23:29:41 +0100
Organization: OPDS
Message-ID: <42E6711E441F4E7E92B65CC7CCFB897E@PhilipOakley>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org> <1368964449-2724-3-git-send-email-philipoakley@iee.org> <20130519173924.GB3362@elie.Belkin>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 00:29:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeC6w-0001yx-DK
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 00:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab3ESW3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 18:29:43 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:61561 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215Ab3ESW3l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 18:29:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvENAFRRmVFOl3xU/2dsb2JhbABagwiJKrg4BAEDAX0XdIIaBQEBBQgBAS4eAQEhCwIDBQIBAw4HAQIJJRQBBAgSBgcXBhMIAgECAwGHagMTsjQNiG6MSoFtaoJ6YQOIZ4YBhmqOA4UjgxA7
X-IronPort-AV: E=Sophos;i="4.87,704,1363132800"; 
   d="scan'208";a="429373132"
Received: from host-78-151-124-84.as13285.net (HELO PhilipOakley) ([78.151.124.84])
  by out1.ip01ir2.opaltelecom.net with SMTP; 19 May 2013 23:29:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224927>

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Sunday, May 19, 2013 6:39 PM
> Hi,
>
> Philip Oakley wrote:
>
>> The Git cli will generally accept dot '.' (period) as equivalent
>> to the current repository when appropriate. Tell the reader of this
>> 'do what I mean' (dwim)mery action.
> [...]
>> --- a/Documentation/gitcli.txt
>> +++ b/Documentation/gitcli.txt
>> @@ -59,6 +59,10 @@ working tree.  After running `git add hello.c; rm 
>> hello.c`, you will _not_
>>  see `hello.c` in your working tree with the former, but with the 
>> latter
>>  you will.
>>
>> +Just as, by convention, the filesystem '.' refers to the current 
>> directory,
>> +using a '.' (period) as a repository name in Git (a dot-repository) 
>> refers
>> +to your local repository.
>
> Good idea, but I fear that no one would find it there.
>
> Would it make sense to put this in Documentation/urls.txt (aka the
> "GIT URLS" section of git-fetch(1) and git-clone(1)), where other URL
> schemes are documented?
>
> Thanks,
> Jonathan

Sounds an interesting idea. I'll have a look.
Philip 
