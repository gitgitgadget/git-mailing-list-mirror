From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Mingw: verify both ends of the pipe () call
Date: Fri, 28 Aug 2015 11:44:50 +0200
Organization: gmx
Message-ID: <2d4fc3abf0e3d46fc1072f8f05dff0ce@www.dscho.org>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
 <20150827215014.GA8165@google.com>
 <CAEdsdLdEC7KCgYeu8zmPZWm8uORCwshQo2u9FYQKjrq-sV_bZg@mail.gmail.com>
 <d959c5ad8b7f57e76910ececce47b853@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: "Jose F. Morales" <jfmcjf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 11:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVGDU-0004oX-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 11:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbbH1Jo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 05:44:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:54844 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbbH1Joy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 05:44:54 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1Yg2VS1sjF-00sLt3; Fri, 28 Aug 2015 11:44:51
 +0200
In-Reply-To: <d959c5ad8b7f57e76910ececce47b853@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:M2c8VNlaGGhe3raLRP1tCk2hLNSHIKMMmBtp46nKQqBsbzP09em
 H9G4dGUooSjAOsrVntSL2bg1PaIxFJ0DcG5kpav22OyPhQn7MUXh5nGc8+mDvHwa2Y1jK/v
 9oaRPgSDglLuG2al07OxaZnM3umwrL/7ZcipVFyGbtb3V0kUf6gtT+hkWMiGTT0lMErPyVr
 ivJYnF5QXmnIBkXatOaVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p0cL7mpA5XI=:bWx3KvbtA2Fb0DwWeiDU7/
 deXomgapfJZpSxTR3A+46L3nfCRsAi5MTpZNmOt4UbcfYJPmY/W9YhjsXI3qlGimLdJw4gtoa
 Ui37AjrwKVKO2reod2m8I+tyNk+S1qRTcPidKEJR4XXXdlHrWuwwi4XlrgO2wSS3WBbXK131A
 hPE0KWWCvkRE2+mxVDRbqxy3hPd8M8rm1TMfO2H8PTbuTV1ANGO1LGrtmFiOfKwyAkuDs+IVm
 YA5EitPuxW9q2c1mUanxYcd5a5RxylA9zaS+GOe2FkWoz6kh0CbW6MtlpsjSjl/qmvm+myJd1
 NE6hSpDp6xDl9yIN01ipVr2bjpqtu/7c5l6C/vD7FM2X9oEdbBKh+LWv+eIZSOlyYqAjMZKPq
 0BWVwldzjHXtllY8B0nPVN5J3cSPwsx5TX64DTjF/AHARA6QEXPllieWGUddLZtk0HTK5/7+3
 mM+Yy86XnDsuZhpQcG1D1SDAyv0ac3bwK6UzQWmxpWEsHu/myBMikTdR/i8gXYv6ksUwb5y3L
 JnHF+6/YLJEUAMidH05iO23OwjwGvzM+SqpbeAV4YctS1KakpKKxj0WFhduYNI+w7JwDKMHgL
 HICXty9f5FyurIXu77C+g3VBUYQYNNPMVDaHVOAMY1YildES9Ihz56esM9TMxu+EIltVllOf8
 7o5pM6rt4iGBYjWrpjE1Ojvlhy2o6oZ9HMVynhkdFOYTbrEgvTTL0IDue+anK0JlmPjkplJue
 8z57sdJBQEFJ8y4YqzkWsumkin2cumvPIiOrBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276711>

Hi,

On 2015-08-28 11:39, Johannes Schindelin wrote:

> On 2015-08-28 08:37, Jose F. Morales wrote:
> 
>> Could I still amend the commit? (it seems to be already pushed into master)
> 
> It was pushed to Git for Windows' master, but here it was submitted to
> the Git mailing list.
> 
> Junio, would you terribly mind fixing the name on your end?
> Alternatively, I could try to update the Pull Request and give
> submitGit another chance to show just how awesome it is.

Never mind, it was way too easy to let submitGit show how excellent it is.

Ciao,
Dscho
