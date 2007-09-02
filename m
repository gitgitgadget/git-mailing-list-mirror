From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 07:58:59 +0100
Message-ID: <46DA5F33.2020005@zytor.com>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 09:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRjRF-0001ea-3x
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 09:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933784AbXIBG7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 02:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933627AbXIBG7p
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 02:59:45 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40853 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXIBG7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 02:59:43 -0400
Received: from titan.hos.anvin.org (conf.dow.cam.ac.uk [131.111.195.11])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l826xJe5023457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 1 Sep 2007 23:59:22 -0700
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.88.7/4128/Sat Sep  1 22:54:56 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57299>

Junio C Hamano wrote:
> 
> * For people who need to import from Perforce, a front-end for
>   fast-import is in contrib/fast-import/.
> 

There seems to be an issue with this and RPMS.

In particular, there is no longer a git-p4 RPMS, which prevents git from 
getting upgraded at all by yum.

Anyone who knows yum well enough to explain what needs to be done so 
that yum knows this is obsolete?

	-hpa
