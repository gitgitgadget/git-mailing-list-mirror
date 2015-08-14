From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git svn clone fails
Date: Fri, 14 Aug 2015 13:54:59 +0200
Message-ID: <55CDD713.1050205@web.de>
References: <mpa8th$m80$1@ger.gmane.org> <mppsku$h97$1@ger.gmane.org>
 <mqk6mb$qi8$1@ger.gmane.org> <55CDA784.7080809@web.de>
 <mqkgee$ju3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?J=c3=b6rg_Schaible?= <joerg.schaible@swisspost.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 13:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQDZq-0001TT-9m
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 13:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbbHNLzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 07:55:07 -0400
Received: from mout.web.de ([212.227.17.12]:53509 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbbHNLzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 07:55:06 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MOAjQ-1ZTUp645wK-005YQk; Fri, 14 Aug 2015 13:55:01
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <mqkgee$ju3$1@ger.gmane.org>
X-Provags-ID: V03:K0:yeHj4r63hU6A6w7xDQ+hQTI/3DgTJ2Ju3505ewuqBEnoz4Tv6gt
 rAdpygf9CVf+hhWePSlQckWw8Nuq5cDFu3P75vptgN7POZSd4ykmbq6+/P5OkWd0PUPAgu9
 Rx++WvCxQsi3ArxsDccHY6+z/8WpkidOqwb3NNtazNume78Pbollg+4gXA5wf5lBlyc9a47
 Gc2BgXUuHKUVFaaFtfClQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S3d6qEVs+qU=:8babr3GDWleOp6BwYTn2kN
 QeGK5QA01EYZkusC9wK+GUctSo0pbgfsSC7d8/CXrtZ6OgCxWIMuR5OS87ur3kqlDINlmF+wO
 uQ1CBATHP4Ub7YpknE9Vu0TR0F86EbH/Hv/3QEAdH2q3QSoDuhT9v6aNq+C9KcPG4qhcEB0g8
 P/1FzgAgX3YFgWDMP0wA2hdcTXWOM1ZmAuvqxLXed3SZzry7eoXmSsdcaV8JWHBChGDWeqvQv
 bxaotB4g+5fzxzNB0PkPvCCRqZfuJYlSyRVWnwyysDyUsyod1b7bPOZKpzsqdy2XzcIkw+kxc
 Qx3h7bhQGIvVsVHHzAvedVCXN3DZVmTYiou/tu/CwbZB2y/Mu9j0UemIhsEfxYqUidSDbTTyr
 4X4yFGEEeB/1tXLtJNk5MqEM7sjYDOK456BjQM1syn4LUHpBswIpjLiRXyAT3Pmwgq+cYobQB
 z/mIPDBjTvgvbqmxHOF8HUhqnM8LqajQEKnswRZ3oVWjx580zrnJjhkRMNoyiMsU47t0GTkSb
 QwR5JJvoTk4yynrfRltFiYRx18K8rq+RRLu1xBtQHP++zFhWg8GqfW7CT/dgf2baGkgN/X7FB
 7iKKE/7tIMoGvXhtobiOO9l5Rq/m1n6zyq4WEGbK7aQF910stgtr90IeftuwF+31v/yDOSzWm
 AmH8eWUS6ewrRq+G5f8FQed13HGoPgAA4CjK3yoJ5/cETMD6eKqOHntmHPV1zS9JR+YPeMsS1
 KARIVNVmtjI3yJob/bwIJEC1ml4LRrNYJGTTfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275901>

On 2015-08-14 12.38, J=C3=B6rg Schaible wrote:
> Any idea how to proceed?

Git itself doesn't version empty directories at all, only files
(and soft links, sub modules....).

Git creates a directory as a "side effect" to be able to store files
there.

May be I am off-topic, but would it be possible to fill the empty
directories with a dummy file ".empty" ?
Add those to svn and force Git to create a nearly empty directory.
