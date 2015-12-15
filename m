From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Where does http.sslcainfo get set in Windows (2.6.3)?
Date: Tue, 15 Dec 2015 13:37:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512151336030.6483@virtualbox>
References: <1450107945.1012555.467004601.1D76923E@webmail.messagingengine.com> <74D611CB-89C3-4A5B-A405-1089EB30FB32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Titus Barik <titus@barik.net>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 13:38:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ori-0003RV-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 13:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbbLOMh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 07:37:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:57444 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857AbbLOMh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 07:37:57 -0500
Received: from virtualbox ([37.24.143.140]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M1Fe4-1aSoci1sb2-00tFgh; Tue, 15 Dec 2015 13:37:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <74D611CB-89C3-4A5B-A405-1089EB30FB32@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:393Sc4WSXlpE5YYctpkIo4B3QhOx6LUjuUMzZCvLFT2+zjpTyQQ
 HN/03k8jI8jcC4GAFeCmhC1H6f7COIFzwTh8ubzdV33qd4PDdf0CB2w1YxVtpSNtpILFlRf
 QP1CBHn2+QrvUrNSYQSDDmNpNMFaMmK+LdQsH1o7r6xnSAKFeacxS5sXD6ogQWn/p0P5Kpk
 afC2KIiE5qI+p9pluunpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4tDpkdd6DkU=:U7zRDHPrXRE3AUIgDn+bA2
 mzRp0NrGq2ggp6tUWL1rDvaj+xJavvgXNtgcb3YTuFJW4Z9ocjHBm0YGE9isZgjimtM6xMoJP
 Ez3+9go2yni5iFGGI+EEk65ND5bqF3syusw8y3/l5WzROPdo/tM13/vp2A9At7Pa7+MOzKv1A
 Y0C3C4h1qGpCDeFpeNbkK5KlnQ/NaiR8eA6+zUqj86uAFFXE7HmVrgthi+1+cFhplGgIGuSMn
 VqCuOND72OSKeRBod1Ibc44P45Y5cOmJSHMDwfIuNCwTwsvO9PcO0CljrIoLJDoX/Sje6A9wR
 ilmTKAzEKSZ8Ys8LJDaGxQPwXXuXTxMq5y9FPDkokz28ZxZRsXWi3K5EkpLp9cRoXP4JGFgNC
 zFmOb3OQ9OIcma4ggVRH56370Ng3thZGc3p65fZUPHU8LYNwvpahRpoC3SoLYSekja31AxMkG
 lgJw2gEp/3+XOJBTSWRlsmzUW8SJbeA6dgs/jNh8DoPLuKr8zZ+Ut1Nra5uLoafE0fe92IrG6
 0Mb4bhTuXtqYoz2b6ZoFNr3Lkh7tSO24ibOO9WOVugKr9ZVKmEBogzYeON7xgIf2NpQn5Bq8s
 GNEsHzjky2uYe9YEgizYW50s9ulXn2QlHmrTbbCcGuHi7Y/IHWN4rUlQnQDMY04zfJjfE5elL
 1CSriuvmYFk5Cwmhv8b0n8t3RUZbLO5TPJmPW8FwIS2frrkRywL93MpQ0/D7aR6FkYuMDFQCz
 o8cHgkSLoEovbvE+bnpxe39dRCJA+BO2XinEmc6lhcb7z7gExnzTnA8e+gFp/mILbLm5yFwe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282473>

Hi,

On Mon, 14 Dec 2015, Lars Schneider wrote:

> try to look here:
> C:\Users\All Users\Git\config

The location should be C:\ProgramData\Git\config for the Git configuration
shared between all users and all Git implementations on Windows.

Maybe you are running Windows XP, where C:\ProgramData does not exist, and
where %ALLUSERSPROFILE%\Application Data\Git\config plays that role.

Ciao,
Johannes
