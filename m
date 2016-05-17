From: Michael Heerdegen <michael_heerdegen@web.de>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Tue, 17 May 2016 19:25:31 +0200
Message-ID: <8760ucoaus.fsf@web.de>
References: <87vb2d37ea.fsf@web.de>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 19:25:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2ikc-0002oi-P3
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbcEQRZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:25:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:33998 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbcEQRZm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:25:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b2ikV-0002l6-KI
	for git@vger.kernel.org; Tue, 17 May 2016 19:25:39 +0200
Received: from dslb-094-217-122-112.094.217.pools.vodafone-ip.de ([94.217.122.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2016 19:25:39 +0200
Received: from michael_heerdegen by dslb-094-217-122-112.094.217.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2016 19:25:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-094-217-122-112.094.217.pools.vodafone-ip.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
Cancel-Lock: sha1:iRviAdkcbfgSXYTwh/t12C7Eu8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294881>

Michael Heerdegen <michael_heerdegen@web.de> writes:

> the command
>
>    git log --pretty=format:%ad --date=format:%s
>
> displays wrong unixtime values; apparently how much the printed value
> differs from the expected value depends on the system's time zone and
> whether daylight savings time is enabled or not.

Two more comments:

  - --date=raw seems to work correctly (though the doc tells it would
    also use "%s").

  - When specifying versions like @{N hours}, the result seems to differ
    (by one hour?) from what I expect, too.


Thanks,

Michael.
