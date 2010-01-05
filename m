From: Johan Herland <johan@herland.net>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule working directory in git gui and gitk
Date: Tue, 5 Jan 2010 16:07:45 +0100
Message-ID: <201001051607.46310.johan@herland.net>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de> <20100105142727.GA83546@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 16:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSB1a-00035x-VL
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 16:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0AEPIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 10:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657Ab0AEPIl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 10:08:41 -0500
Received: from smtp.opera.com ([213.236.208.81]:45011 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab0AEPIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 10:08:40 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id o05F51al011704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 5 Jan 2010 15:05:06 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20100105142727.GA83546@book.hvoigt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136192>

On Tuesday 05 January 2010, Heiko Voigt wrote:
> P.S.: Additionally (for my use case) we could add a "hint mechanism"
> which allows git to "guess" a new submodules address. For example in
> case I have all my local clones on
> "git@my.server.net:<modulename>.git". Now when a new submodule gets
> seen in .gitmodules it will infer the address from the hint
> configuration and not take the original one from upstream.

This can be achieved today, if the upstream .gitmodules uses relative 
submodule URLs. I normally place super-repo and submodules in a single 
directory on the server, and use submodule URLs of the 
form "../<modulename>.git". Now, downstream developers can "git 
clone --mirror" the repos from my server, and - as long as they 
preserve the directory layout - provide their own complete server 
mirror, without editing .gitmodules. Granted, the existing submodule 
tools don't make working with relative submodule URLs particularily 
easy...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
