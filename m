From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/4] Add Travis CI support
Date: Mon, 05 Oct 2015 11:55:16 +0200
Organization: gmx
Message-ID: <8851e0675d432edac6a35cf9f4daa868@dscho.org>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 05 11:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj2UO-0006Kp-3B
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 11:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbJEJzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 05:55:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:64060 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbbJEJzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 05:55:18 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MNO33-1Zh7cL3BfN-006t1u; Mon, 05 Oct 2015 11:55:16
 +0200
In-Reply-To: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:UKzgP7BwiN+ZgZKP4l0QPQif9QLRa0fKFKl75gPkKr0iCr2lUn1
 h7nbtuA+ezSe0yzl1h9P5w2fDuVmXezxTvD8yNj/8ldNwnpVT8x5rV+t4JTFzTG0KU5DgKH
 MAw/pdYyQWDNdfABw4Ac6UvXCAR4LzQgfqzIweN9lKmeCEtrWZIdv9mjEXx9XL++FGARlBA
 7TWZK1Xy/nFnMaAb9wr6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TvRCTLs0ywc=:YaUC9cyT4Q0V+EE2l62W9x
 1T7c2p3K6uxJdp2UGzdsrPlupSLM61ggIVrQGNbAMXdh34fcULvspGeR58ifNhD50fAY3S6DE
 iMVEC3Xjg/dG6oj/2mb90qJQOpDHy+6iOKLDO7S46L69Yzu4DW/j95f2vmYTrjhGT4ca/F714
 eqn30fyZM0GwBaVpRZlFrLdepBeowvlJelIuUVzfh/X5upXFAxKHfrTO1k8NU4wNaB88iEovK
 7mUfAd5jLP5uFNR8FOM3qv3uxAZ8W6bXQKFJcoo8KaRbfe9tr05QAZlNcc1tZKrZmo1YSe2H6
 vmQhnRmAm2ncwGM0Q5Yl5jgWxHXMZP+XJN/W2sXqK6H79qmnJWTOofDhdWXh06HuEhHz7uia+
 OpCvuc6WlOyuTOC3OAABLMlp/RMU248MI/40KqnPpcQYbxIlLkAUnltxcUvGImup5S/yI5SBe
 6FlhZ+5WxjfmktNsLk3pBUVrKakkqHw3oE5ss7vodPMG34DCNWdfQhzjfZJbWaphfR67yKdTZ
 Wpj8b/quX7GesLfjZzw+VHjIeh0MbrUb5xUAbAWjDxebUgPEC57G6iqZU2RCh7ZGS2vBCAgS5
 vj9pDLSFyn97vsNGRcP7opq5ZjiNMdjLjSb+MC/T+VcHPH8FFkUT9LA3gQqV+FKTQCbgHk9/I
 T1M9H5PUf0iWtM52kH8CjrPdEClGeDihKEe+vcT5iG5LpuM0PQfxiOmFBNx255og2J3Or3LIh
 2Tl5SaPI/udLdDP29vKRczSz1MqKn7YphR9wxvVb5ZA6Btmc0q1/nEBagDnHpj+GnacaVMeS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279055>

Hi Lars,

On 2015-10-04 20:06, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> diff to v1:
> * improve readabilty of Travis "before_script" section
> * make OS X Perforce brew robust against changing Perforce builds [1]
> * add a prereq to detect OS X in tests
> * fix t9815 git-p4-submit-fail test case on OS X
> * disable t9819 git-p4-case-folding test on OS X

Nice! I think that this already shows the promise of using Travis CI: more thorough testing, earlier warning when new changes are not quite as portable as we thought they were.

> In a subsequent patch I plan to:
> * add cvs to run t94?? tests
> * add svn to run t91?? tests
> * add apache to run 5539, 5550, and 5561
> * investigate if it is possible to run t1509 root worktree test
> * investigate if it is possible to add jgit to run t5310

Very nice!

Thanks,
Johannes
