From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/2] submodule aware grep
Date: Fri, 24 Sep 2010 19:10:13 +0200
Message-ID: <4C9CDB75.9070405@web.de>
References: <1285276627-7907-1-git-send-email-judge.packham@gmail.com> <20100924134748.GA576@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 19:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzBnT-00079D-Rf
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 19:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab0IXRKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 13:10:49 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54050 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab0IXRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 13:10:48 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 560DD17281C39;
	Fri, 24 Sep 2010 19:10:20 +0200 (CEST)
Received: from [93.240.108.51] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OzBmu-0000o9-00; Fri, 24 Sep 2010 19:10:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20100924134748.GA576@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+ZJxZ81k+x6F0bbgEg/F3v72Hi4CTVXA88ZjO5
	7fxC7+oQeWJvdDQPbWsn9ZsKqSI7i+0gZvBu1px2Fiy8ya+gfI
	Bp0Gs/rQWPB5JX/xzSfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157025>

Am 24.09.2010 15:47, schrieb Heiko Voigt:
>> There are a couple of questions for this. Technically I'm making submodule 
>> grep-aware, should I be making grep submodule-aware instead? I haven't looked 
>> at the grep code yet but I imagine its harder.
> 
> Nice work! IMO it would be even nicer to have it as part of git grep.

I like it too! And yes, me too thinks adding a "--recursive" option
to "git grep" would make more sense than adding a "grep" option to
the "git submodule" script.
