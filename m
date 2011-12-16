From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: How to automatically correct an almost correct auto-merge?
Date: Fri, 16 Dec 2011 15:39:27 -0500
Message-ID: <201112162039.pBGKdR8H012831@no.baka.org>
References: <20111216203215.GG1868@goldbirke>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Dec 16 21:39:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbeZ8-0000nh-4U
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760677Ab1LPUje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 15:39:34 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:40959 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab1LPUjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 15:39:33 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id pBGKdRDK029388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Dec 2011 15:39:27 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id pBGKdR8H012831;
	Fri, 16 Dec 2011 15:39:27 -0500
In-reply-to: <20111216203215.GG1868@goldbirke>
Comments: In reply to a message from "SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>" dated "Fri, 16 Dec 2011 21:32:15 +0100."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187316>


> How can I teach git to produce the correct merge result when
> performing the same merge later on?

Custom merge driver.

Type `man gitattributes` and search for "custom merge driver"

Your merge driver can have whatever policy you can program, on a per
file basis.

					-Seth Robertson
