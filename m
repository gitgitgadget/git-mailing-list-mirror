From: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 02 Jul 2014 16:54:58 +0200
Message-ID: <53B41D42.2090805@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2LwD-00029m-Il
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 16:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbaGBOzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 10:55:01 -0400
Received: from mout.web.de ([212.227.17.12]:60118 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaGBOzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 10:55:01 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M4ZTk-1WhdAF1iPc-00ydvr; Wed, 02 Jul 2014 16:54:59
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Provags-ID: V03:K0:Yxb6yebrS+0gKYvq8W0Cjf4RqGln/cwX7mAygXy7p0sMjT3SMXZ
 rkFdeM1pXkWwzXOZpmBids6NBznwY3HFyocvkpfCSKt82KW6uRe7WxdACth61Wnq3EKHi2P
 nE8jtM+dMiRzfBAK4sP4ctuvaxaR2aJ0YZ6tt3wi87m31OoQXE9Dk3xZAv/w85E2ekLkJ0w
 nPDPlx/ug7iKlXd1Li9FQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252786>

(Not sure if this is the right thread)
(I haven't checked if this is fixed in your latest version)

On what I have on pu 7a0da7902cbbc9a876b90c9, Tue Jul 1 14:51:53 2014 -0700

Many submodule tests are broken.
One problem is here:

lib-submodule-update.sh:264: possible problem: echo -n is not portable (please use printf):                     echo -n >sub1 &&
lib-submodule-update.sh:507: possible problem: echo -n is not portable (please use printf):                     echo -n >sub1 &&

You can remove the "empty" "echo -n" to create an empty file:
>sub1 &&
