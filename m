From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes in detail
Date: Thu, 16 Jan 2014 22:18:06 -0000
Organization: OPDS
Message-ID: <777D3478B53C4A3F8B4326A96B3F048E@PhilipOakley>
References: <20140114224246.GA13271@book.hvoigt.net><4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us> <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git" <git@vger.kernel.org>, "Jens Lehmann" <Jens.Lehmann@web.de>,
	"Francesco Pretto" <ceztko@gmail.com>,
	"Heiko Voigt" <hvoigt@hvoigt.net>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:18:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3vGJ-0007c5-CV
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbaAPWSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 17:18:03 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:39213 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071AbaAPWSB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 17:18:01 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqkYAFJa2FJZ8YEW/2dsb2JhbABZgwuEDIU+slABAgEBgRAXdGkBAYEfAQEUAQQBAQEBAwgBARkVHgEBIQsCAwUCAQMVBQIFIQICFAEEGgYHFwYBEggCAQIDAYU4BwGCEiWpH5wgF4EpjVaCdjWBFASPJZNWhz2DLTw
X-IPAS-Result: AqkYAFJa2FJZ8YEW/2dsb2JhbABZgwuEDIU+slABAgEBgRAXdGkBAYEfAQEUAQQBAQEBAwgBARkVHgEBIQsCAwUCAQMVBQIFIQICFAEEGgYHFwYBEggCAQIDAYU4BwGCEiWpH5wgF4EpjVaCdjWBFASPJZNWhz2DLTw
X-IronPort-AV: E=Sophos;i="4.95,670,1384300800"; 
   d="scan'208";a="598509668"
Received: from host-89-241-129-22.as13285.net (HELO PhilipOakley) ([89.241.129.22])
  by out1.ip06ir2.opaltelecom.net with SMTP; 16 Jan 2014 22:17:59 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240542>

From: "Junio C Hamano" <gitster@pobox.com>
> "W. Trevor King" <wking@tremily.us> writes:
>
[...]
>> @@ -155,13 +155,31 @@ it contains local modifications.
>>
>>  update::
>>  Update the registered submodules, i.e. clone missing submodules and
>> - checkout the commit specified in the index of the containing 
>> repository.
>> - This will make the submodules HEAD be detached unless `--rebase` or
>> - `--merge` is specified or the key `submodule.$name.update` is set 
>> to
>> - `rebase`, `merge` or `none`. `none` can be overridden by specifying
>> - `--checkout`. Setting the key `submodule.$name.update` to 
>> `!command`
>> - will cause `command` to be run. `command` can be any arbitrary 
>> shell
>> - command that takes a single argument, namely the sha1 to update to.
>> + checkout the commit specified in the index of the containing
>> + repository.  The update mode defaults to 'checkout', but be

nit:   s/but be/but can be/  ?

>> + configured with the 'submodule.<name>.update' setting or the
>> + '--rebase', '--merge', or 'checkout' options.
>
[...] 
