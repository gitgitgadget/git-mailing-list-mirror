From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 15:13:22 +0200
Message-ID: <537DF7F2.8000401@web.de>
References: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 15:13:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnSoR-0003mE-4j
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 15:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbaEVNNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 09:13:31 -0400
Received: from mout.web.de ([212.227.15.4]:51309 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbaEVNNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 09:13:31 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Mb8d1-1WTsOJ2UG3-00Khum; Thu, 22 May 2014 15:13:28
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
X-Provags-ID: V03:K0:0nAkTZLAF/z//dY9GUBGpudy7am0sfVHI7A0Fp9zuib7ZZeA0Jk
 sDHYJSZgKlSZ5nPLg9fbwoOrFcqNIoaJvc9jUvEB7Z47Km0aYuPMQ8V4kF8kQZbFae/ZdQ5
 etg9trdg/tcQUwXgz18y4hSEwzLs7cQ2otPU4TQpNecNC4CjgjeTytZVzcHTPTPnBunm6uP
 1/qXxM5aTHfO6CTxiJp9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249900>

On 2014-05-22 14.48, Elia Pinto wrote:
> Found by check-non-portable-shell.pl

Thanks for picking this up
> -export TEST_DIRECTORY=$(pwd)/../../../t
> +TEST_DIRECTORY=$(pwd)/../../../t && export TEST_DIRECTORY
Minor remark:
Both commands should go on their own line, like this:

TEST_DIRECTORY=$(pwd)/../../../t &&
export TEST_DIRECTORY


And, unrelated to this patch, 
there seem to be a lot of && missing in git-remote-testgit.sh.
But this should be a seperate patch, I think.
