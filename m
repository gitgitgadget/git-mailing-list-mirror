From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Tue, 04 Dec 2007 22:22:46 +1300
Message-ID: <47551C66.4010202@catalyst.net.nz>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>	<7voddl24b7.fsf@gitster.siamese.dyndns.org>	<47464A90.4030509@catalyst.net.nz>	<7vhcj387jh.fsf@gitster.siamese.dyndns.org>	<475479C6.3050506@catalyst.net.nz> <7vodd66dzw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, francois@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 10:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTzV-0000HM-Rj
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 10:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbXLDJWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 04:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbXLDJWh
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 04:22:37 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:33248 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbXLDJWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 04:22:36 -0500
Received: from 203-97-235-49.cable.telstraclear.net ([203.97.235.49] helo=[192.168.69.233])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1IzTz0-00056L-P5; Tue, 04 Dec 2007 22:22:26 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vodd66dzw.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67030>

Junio C Hamano wrote:
>> Subject: [PATCH] Add remote.<name>.proxy
>> As well as allowing a default proxy option, allow it to be set
>> per-remote.
> 
> Thanks.
> 
> I was very tempted to rename them to remote.*.httpproxy, but ended up
> keeping the name of the variable.  We might want to allow tunnelling the
> git native transport over the named proxy when remote.*.url is native
> transport.

Also, it controls proxy for all of the curl-based git transports, not
just http.

Sam.
