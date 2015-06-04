From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Suggestion: make git checkout safer
Date: Thu, 04 Jun 2015 22:14:36 +0200
Message-ID: <5570B1AC.2060108@web.de>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <loom.20150603T114527-151@post.gmane.org> <20150603194756.GB29730@vps892.directvps.nl> <loom.20150604T124827-124@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 22:14:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0bXJ-0004Da-Mi
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 22:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbbFDUOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 16:14:41 -0400
Received: from mout.web.de ([212.227.15.3]:64608 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbbFDUOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 16:14:40 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M0Qxx-1ZLika0s85-00uX5L; Thu, 04 Jun 2015 22:14:37
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <loom.20150604T124827-124@post.gmane.org>
X-Provags-ID: V03:K0:rJqBNnEd8BVFnei4LKbGGyBRkYmQLeGakoOnGYeD3RITsMiRuql
 HU54upHBGsjwdbykjC2Fmcq1oo+nisRQwcsV+uHWHDUrDiJLMmMJVH/r7z0sFajdL6XSje9
 S+cSFTt6GGzqrffh7UlCIrSAOh46ox4eIeKLf28YsuPcS3e864ySFyS9Zg9AIrHgyTrSdZY
 ii0WjaqlXF9O1/UkBv1iw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270796>

On 2015-06-04 13.00, Ed Avis wrote:
> 
>     >Updates files in the working tree to match...
I think that this had been written with
"git checkout <branch>" in mind, which is different
from "git checkout -- <paths>" (or "git checkout .")

Do you think you can write a patch to improve the documentation ?
