From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: Distribution size
Date: Tue, 29 Sep 2009 11:06:26 +0200
Message-ID: <4AC1CE12.8040406@syntevo.com>
References: <1253962653-sup-1882@nixos> <alpine.DEB.1.00.0909261320370.4985@pacific.mpi-cbg.de> <4ABE3091.5040600@syntevo.com> <4AC0B088.9090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marc Weber <marco-oweber@gmx.de>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 11:06:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsYfJ-0001xc-Op
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 11:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZI2JGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 05:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbZI2JGX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 05:06:23 -0400
Received: from syntevo.com ([85.214.39.145]:41334 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbZI2JGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 05:06:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 3180337CB5F
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AC0B088.9090101@gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129291>

Hi Marius,

> Also, you don't need everything in msysgit to distribute, only for development.

How should I find out what is required to *run* all git commands, except of
trying it myself? Is there a document available somewhere?

--
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com


Marius Storm-Olsen wrote:
> Thomas Singer said the following on 26.09.2009 17:17:
>>> Funny.  Git for Windows is less than 12MB [*1*].
>>
>> Well, the portable Git bundle compressed with 7zip is approx. 11MB,
>> the Git installer (maybe also using 7zip internally) is at approx.
>> the same size. Unpacked/installed on disk they are at 138MB/131MB.
>> If you try to compress it with zip, it will reduce to approx. 70MB
>> which still is quite large.
>>
>> We are interested, too, in having a small(er) bundle, because we
>> want to distribute Git binaries with our Git GUI front-end,
>> SmartGit, so the user will (have the option to) get an
>> all-inclusive-bundle.
> 
> [Please, never ever top-post on the Git mailing list, thanks]
> 
> Most of the git-*.exe are identical duplicates, so most of that can be
> nuked. Also, you don't need everything in msysgit to distribute, only
> for development. You should be able to make a fairly small distribution
> for usage only.
> 
> -- 
> .marius
> 
> 
