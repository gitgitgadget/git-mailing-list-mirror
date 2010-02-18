From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH 0/3] git-gui: =?UTF-8?B?RG9u4oCZdCB0cmlnZ2VyIGdhcg==?=
 =?UTF-8?B?YmFnZSBjb2xsZWN0aW9uIHdhcm5pbmcgc28gZWFzaWx5?=
Date: Thu, 18 Feb 2010 21:40:55 +0100
Message-ID: <4B7DA5D7.20704@kdbg.org>
References: <20100218143431.GA30486@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Brown <broonie@sirena.org.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiDBR-0007aS-Eg
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab0BRUlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:41:08 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:23259 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751874Ab0BRUlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:41:07 -0500
Received: from [77.119.103.8] (77.119.103.8.wireless.dyn.drei.com [77.119.103.8])
	by bsmtp.bon.at (Postfix) with ESMTP id E3CBBCDF82;
	Thu, 18 Feb 2010 21:40:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100218143431.GA30486@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140378>

Jonathan Nieder schrieb:
> This series does the simplest thing I could figure out how to
> implement: it builds in the heuristic for counting loose objects from
> builtin-gc.c into git-gui (so it will respect the gc.auto
> configuration and by default will trigger much less often) and if that
> heuristic is satisfied, runs gc --auto.

Any improvement in this respect is appreciated.

Minor nit: By all means while you are in this area, please do not carry 
over this silly "your repository has *approximately* 576 objects" message 
(highlight is mine). "576" is not approximate. "500" is approximate, "750" 
is, too, but "1024" etc. is not. ;-)

-- Hannes
