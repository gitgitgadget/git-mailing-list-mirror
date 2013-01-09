From: Bruce Lysik <blysik@apple.com>
Subject: git-archive fails against smart-http repos
Date: Wed, 09 Jan 2013 10:52:48 -0800
Message-ID: <6014ED12-17F9-4D57-927F-6AFCD8A51C9D@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 20:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1iN-0008HY-TC
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab3AITxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:53:09 -0500
Received: from bramley.apple.com ([17.151.62.49]:36415 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439Ab3AITxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:53:06 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 14:53:06 EST
Received: from relay16.apple.com ([17.128.113.55])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0MGD00BDYESBTIP1@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 09 Jan 2013 10:52:49 -0800 (PST)
X-AuditID: 11807137-b7f156d000005a91-dd-50edbc817ddc
Received: from blysik-imac.apple.com (blysik-imac.apple.com [17.203.15.7])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)	by relay16.apple.com (Apple SCV relay)
 with SMTP id 3F.C4.23185.18CBDE05; Wed, 09 Jan 2013 10:52:49 -0800 (PST)
X-Mailer: Apple Mail (2.1499)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsUieJqfXbdxz9sAg81nOS26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJWxrXcRa8FFpopjnS8ZGxhnMnUxcnJICJhI3PlxkRHCFpO4cG89
	WxcjF4eQwAImiYMLD7GDJNgEVCSuzmxlBrGZBbQkbvx7yQRha0ssW/gaLC4sYCxx5et+sHpe
	ARuJd//es4HYLEC9Z2a8BouLCIhLvD0+E6pGT+Jw53ZWiMWyEium9jJNYOSZhWTFLCQrZiFp
	WcDIvIpRsCg1J7HS0EwvsaAgJ1UvOT93EyMoMBoKzXcwbv8rd4hRgINRiYf34bQ3AUKsiWXF
	lbmHGCU4mJVEeEO2vw0Q4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsswB6haID2xJDU7NbUgtQgm
	y8TBKdXAeNQ7P5I5dUtBwZOG03WlsRruX7c05PsIMx6xeCkoeCMp4f6F2APv7hrNOtqZJiRx
	hstwD4/PitqG3RNnR9t88q1NSWQ5vDH5zr3l4mKBokdu7cv5Vv0yTTJRdvb1a/E+zRfjTXfN
	FZ4aL/S4JmG34e59Mx32+Mo08jsoFAbLVDF8fnhp1bQsJZbijERDLeai4kQA+SOpdAgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213091>

Hi,

Trying to run git-archive fails against smart-http based repos.  Example:

$ git archive --verbose --format=zip --remote=http://code.toofishes.net/git/dan/initscripts.git
fatal: Operation not supported by protocol.
Unexpected end of command stream

This problem was brought up against my internal repos as well.
