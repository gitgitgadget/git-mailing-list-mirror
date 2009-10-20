From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] am: allow some defaults to be specified via git-config
Date: Tue, 20 Oct 2009 15:44:47 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <4ADD241F.9060004@catalyst.net.nz>
References: <1255650627-17576-1-git-send-email-sam.vilain@catalyst.net.nz> <200910191149.13698.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nigel McNie <nigel@catalyst.net.nz>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 04:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04iT-0008QE-Es
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511AbZJTCoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756832AbZJTCoo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:44:44 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42808 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755475AbZJTCon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:44:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id CAABA3237F;
	Tue, 20 Oct 2009 15:44:47 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgoJPqecpe8r; Tue, 20 Oct 2009 15:44:47 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 646FD3225A;
	Tue, 20 Oct 2009 15:44:47 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <200910191149.13698.wjl@icecavern.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130754>

Wesley J. Landaker wrote:
> On Thursday 15 October 2009 17:50:27 Sam Vilain wrote:
>> +am.*::
>> +	Specify defaults for linkgit:git-am[1].  Currently, the three
>> +	boolean options, 'sign', 'utf8' and 'keep' may be specified.
>> +
> 
> The 'git am' option is 'signoff', not 'sign'. Shouldn't the command option 
> and config option names match?

Thanks for pointing that out.  Yes, it should be.
-- 
Sam Vilain, Perl Hacker, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        PGP ID: 0x66B25843
