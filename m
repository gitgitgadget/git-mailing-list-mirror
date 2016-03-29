From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 00/19] index-helper, watchman
Date: Tue, 29 Mar 2016 19:09:06 +0200
Message-ID: <56FAB6B2.5000200@web.de>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 29 19:09:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akx8t-0000kn-A1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 19:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757815AbcC2RJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 13:09:13 -0400
Received: from mout.web.de ([212.227.17.11]:52590 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757626AbcC2RJM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 13:09:12 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LiCsx-1Zy5eJ02mB-00nQTD; Tue, 29 Mar 2016 19:09:08
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
X-Provags-ID: V03:K0:mC7O311Yp4SWyRP7EVixgkLcrR22isafUocq3n9ZBVlviw92ZxK
 CfG8pIeAb82hzLmd6bHYXPd4RB3ezPMM38z9EC+n+5Zz3/Gr+Ttr5OlBaWlv78O2vtqDDvi
 xdMnhyjNaQAhKg6BWN7+EoG8k5b3rAFwh0t4yH+dznC68niOdNzdB3GnGpm9nPV9+uYowBz
 CAZ3kLJTiJK79JZl93kNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6LJSiLzEqqc=:XX06Q/Z695eMH3BtlcxFnJ
 aEtXHLAMvEOfDBKNUEx44+TfFB25t8RgoXpxuQfNWAxy+GtI0LtAHTJ+P/TmSiFF68XH2LpyZ
 aSrqp931ALcSKu8AtOaavdELSz3lOHSD7+/hKcRa5ENzw0RC3obW3OVEahylJsrp2p1rlYFrp
 l7pLsArqwMidlsvV71G3tLCSRy2wDc9UVQ0+tOB4BYGeAfwFO2PQZ0OgXes4qKROLiGvpcZpe
 SL4B44ojFSiN/dN4PoUDecFkdv1EPw+pwiChoEHWwPat+f4hgt7VhUNbJjDJnPa+S1BkMkYmm
 EGvmBrEPJhsKPfsSKKmeLD0Ue366MWkkMAlRG9GV9Og3FD9tH0/mhvC9OnyWq0XfXJNy1bv6m
 6T6TDLXMRW61N30JXg9SVXiF6nV0VfDbJ5DMx31VNa9pFlyaFe9YJDiPrlQalgyTCcNBg2hvS
 XR+xbV/Ysw82btdqm7HBXzlVp2z76I5u0Aiu0/Nd7wa+BZPaQRHmrmlOsYCpLZk1+nf5hFhSH
 qdtvKmPZ6aLAscJOy/CX7o5w1S6ap55ffPISWHRvayNpiPEm9cMtXQ748er5/n9F87Al7JDqU
 7W853oxzEd/HyxqXZrR1S5+Y8a5ooFK8EsKwP9Ivwia1AO/S0ECwjzMkecyZhcrcNc4X695Pj
 29HkHRfJcVI5JDi7LgKXKECla/3OqJsKwl22pJz1qBcckXlyrlwXTDcGtXGkpCnECGK//0xYT
 ZxJ84adHm9Wwv0m3Zp2EXTArtmHBbmTUVqJHth0+20FCUSSpLdIHSIMddFlLOlcAh0aBPUnx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290147>

On 2016-03-09 19.36, David Turner wrote:
> This is a rebase and extension of Duy's work on git index-helper and
> watchman support.
>
Somewhere we need to tweak something:
t7900 do all fail under Mac OS, because the index-helper is not build.

The best would be to have a precondition when running the tests ?

t7900-index-helper.sh   not ok 1 - index-helper smoke test
t7900-index-helper.sh   not ok 2 - index-helper creates usable pipe file and can
be killed
t7900-index-helper.sh   not ok 3 - index-helper will not start if already running
t7900-index-helper.sh   not ok 4 - index-helper is quiet with --autorun
t7900-index-helper.sh   not ok 5 - index-helper autorun works


The other thing is to enable SHM on other platforms, but first things first.
