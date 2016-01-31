From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [bug] Possible Windows 'git mv' bug
Date: Sun, 31 Jan 2016 16:52:31 +0100
Message-ID: <56AE2DBF.1010502@web.de>
References: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Aaron Gray <aaronngray.lists@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 16:52:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPuIt-0003ex-Bn
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 16:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbcAaPwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 10:52:39 -0500
Received: from mout.web.de ([212.227.15.14]:65300 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882AbcAaPwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 10:52:39 -0500
Received: from macce.local ([79.223.121.144]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MVcvn-1aZZTX25hH-00Z0p5; Sun, 31 Jan 2016 16:52:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
X-Provags-ID: V03:K0:pDAS7mCwvx4i7/sGi3KtXV3JrXLpZ3EfFCMBkOYlJq1KvNPF/2x
 YnnSZN2J7REv3qcLCH3PUHqbkrxtMkT8+sSmtqANsktsMIP9d50Jc3EWdclsxMq2Ht6Ttbo
 1wWg8T+RaddJ0yY42HZ/p9Nn5OVk61kzQt+HrLe/8CvKWwIME2fumcjCmzjSqJzrnOGZKau
 ObQV5foFCvZzkXgRNw/UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hKToFB4hviw=:M/55Guxu2J26f5jIV3SkuU
 eswZ2HhjM/Aox0czBxf//XL2wvu5/qO+bft8jS2sycRSuX4ckWtDwcPysG6e5JN6ucmspYDzV
 uRcpRT+kg9SaYJEjm1Dv7weHKHCbgAW3nrTxXpOhHTzzwvoF8MvnmNA5bD6ed6YynXFH521D5
 qPwx2ktfZqQgtqVgWaDzfe0S7iVa8fh87OTrvsaVPk7zaneq7xJkb8ZOMvdzpwAhuZacsj3Z9
 uC+lJEPCCFp7HpVmGbTteIuwSfvWiLuGh0Hy+nvzsQLYjXlj9KqhSBeA66EMSkCBBm2hrSS+2
 rNtSuQVhYt6wFxtYWtk1Wgmvyd/IcoIt5ZhJnJ4mR7tWG7C1hlB2GoCaXyRiuOJ3UeGpc+kfD
 3zWUNK/EgcxkskIw40x2BZIkeYXUjWJc/CZkcjpbL6m1jVdyHQfIzRw6ZqebYDwXLwkQpElDN
 xTPSCu8Pnmqfz04xjqkRDCs8oaiwa+qYl3CXOrFexdpmKssT+v4Yp7J3LM1YDToy73Hhj/v+z
 LcrIRLKU/Ln+ybwhfbeytlip7F3zUT/UB3YZ5j3zI3ZWs1sBWCbIA9eCl1U/SRHIoHqugrTHt
 r7BDJzV7GH0nbxcZ+zoBMHWIlE2q/FmwS344oNL2RL/BlqvayBA7D5eMAdROHf+cTI/Yx1PlF
 iAnGlDzXLM66hl87FpjoTf+bI32yW6habfEigKdY+003W6WvXnu9HCfT0mfZl1Aw9SM/Q7D7C
 iRpiEXYgXmBrc9mRHbMk2TtXYrZ0j+HslphdBvZqLWWMhCts1cc9LCb9/ktWpvcnqye/F3qx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285153>

On 2016-01-31 15.03, Aaron Gray wrote:
> Hi,
> 
> I think I have found a possible difference in behaviour between
> Windows git commandline distro and Linux git
> 
> basically If I do a :-
> 
>     git mv logger.h Logger.h
> 
> I get the following :-
> 
>     fatal: destination exists, source=lib/logger.h, destination=lib/Logger.h
> 
> It looks and smells like a bug to me !
Which version of Git are you using ?
Because it is fixed in the latest version in Git and Git for Windows.
