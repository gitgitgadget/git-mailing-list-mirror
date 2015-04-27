From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Mon, 27 Apr 2015 20:58:05 +0200
Message-ID: <553E86BD.7030401@kdbg.org>
References: <553CD3DA.9090700@web.de> <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com> <20150427061115.GB2766@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: Stepan Kasal <kasal@ucw.cz>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:58:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmoEZ-0004cY-Lu
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbbD0S6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:58:11 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:10218 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965045AbbD0S6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:58:10 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lbFjp36LNz5tl9;
	Mon, 27 Apr 2015 20:58:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B28E65236;
	Mon, 27 Apr 2015 20:58:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150427061115.GB2766@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267871>

Am 27.04.2015 um 08:11 schrieb Stepan Kasal:
> Git does not support CRLF as the internal line separator.
> If you commit file in binary mode with CRLF, you are on your own.

When I commit my C source code files with CRLF into the repository 
(because I do not set any line ending options or configurations or any 
'text' attributes or similar), do I then commit binary files or text 
files? Should I expect not to see any diffs?

-- Hannes
