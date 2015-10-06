From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] precompose_utf8: drop unused variable
Date: Tue, 6 Oct 2015 05:24:33 +0200
Message-ID: <56133EF1.4020700@web.de>
References: <20151005034126.GA5639@sigill.intra.peff.net>
 <20151005034313.GA25502@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 05:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjIsS-0006ru-Gv
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 05:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbJFDZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 23:25:13 -0400
Received: from mout.web.de ([212.227.15.14]:63311 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbbJFDZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 23:25:12 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Lzrwh-1adpLe0dgh-015505; Tue, 06 Oct 2015 05:24:49
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <20151005034313.GA25502@sigill.intra.peff.net>
X-Provags-ID: V03:K0:FEUbdmafk+o0GjHWWapnlOdBTS/EZA+0XvFktsH2FS+a0vM+mu2
 otLuNKipLuP9UnBxy8vvK6aduDtj3W/IblsaOjR8KVxMRXrCur7b7DJP2Yj20RY3+nntHZp
 VBg6JTktvBOKsBrx80ULQyaNkxxZMfGMzlOrpSUA3edLQ4d+Wiiut8+m7HiaKpYKcO57SDV
 jF45NRimxlHI22gn2v/lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jJnR0IrpJ9Y=:JLYV82cALa7Lfnu6sWcAf6
 F/CxlmtbGXNLKX9CV0jLICAuHt/ppoOkJs1m4Zx83gLJZ4ItBzzrAizmMOTI+ksU6NyxBEc1T
 V8/qW+66QD31vXsv7WowRexVoctFXVG2unLjn+YdWB0iaknxqFi966jQbmpBm4paT/MoVJzjQ
 2AaX0s4DGwsxoVOyTgJKxLFLMpi416b7BTKoByjVRBByhte2s+y6AbRWF2wm1qFSezwIR7jat
 QSGw9husjkBBdj5j1FIWVo/vJrtETseQM+s3p3PQ5Lb1rPXkaLl9uM2XVggFcFlaaFiNMpTFg
 60L270cMVy94CuctU7kG7S3WpsZx+yXrzatMGCOqwOlrWRsKAQmvRDMibQuWkfnBh/yWUhKo0
 SyusoLXno08DHKQCclktdz9jdoSIQCTYPnwsfsm2TZlaz2Zdu1x57MdREyXABA3aXDFMQcY/Q
 r2FBvtQExMvrU7AjOXaPmXuVtk6kcclQ3r5g2Dri9uZ+wnXqH06tisYE9DmwJACbKBzbqDmlc
 s691C0Fbp/yJ1ne/Srcnsl7Q+VMpfEErYPCzllpYZmvR8gEZiSkn41dxWYCQgdLhkfEyI0/Nl
 PZNv8AjmJ6SBQ4xMKtrqV0CvHJMdTtTilsT7yKx45WWUHC65UmnMWZ/igIpTfrCXcFx1LizfS
 YKNq0O0X99KKJfvY/TtZ3hbN0B8IknVJO/Nl0QvAWU3tsvFSi5cCyB4MsA9hFBKlDaRLdsws2
 mSZGts5bKhDmiOCDxHfVfmEZvEcx40g+I8owgAVz2UeIS+7SSzHlPCIzJviPN/aHoh+CTfzQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279114>

On 2015-10-05 05.43, Jeff King wrote:
[]
The whole series looks good, cleans up my mess and passes t3910.
Thanks for that.
