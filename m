From: "George Spelvin" <linux@horizon.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: 31 Jul 2009 10:05:32 -0400
Message-ID: <20090731140532.18327.qmail@science.horizon.com>
References: <20090731132702.GY12813@osiris.978.org>
Cc: linux@horizon.com
To: brian@ristuccia.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 16:05:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWsjt-0001ke-Dj
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 16:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbZGaOFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 10:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbZGaOFd
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 10:05:33 -0400
Received: from science.horizon.com ([71.41.210.146]:46213 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751390AbZGaOFd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 10:05:33 -0400
Received: (qmail 18328 invoked by uid 1000); 31 Jul 2009 10:05:32 -0400
In-Reply-To: <20090731132702.GY12813@osiris.978.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124564>

> The revised code is faster on Intel Atom N270 by around 15% (results below
> typical of several runs):
> 
> $ ./586test ; ./x86test 
> Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
> Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
> 500000000 bytes: 4.981760 s
> Result:  a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
> Expected:a9993e36 4706816a ba3e2571 7850c26c 9cd0d89d
> 500000000 bytes: 4.323324 s

Cool, thanks!  I hadn't optimized it at all for Atom's
in-order pipe, so I'm pleasantly surprised.
