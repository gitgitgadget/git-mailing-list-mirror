From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 17:09:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 17:10:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUmuK-0003UZ-2e
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 17:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVJZPJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 11:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVJZPJh
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 11:09:37 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65156 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964779AbVJZPJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 11:09:36 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B5D9F13F345; Wed, 26 Oct 2005 17:09:35 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9A338B351B; Wed, 26 Oct 2005 17:09:35 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 812B8B0D87; Wed, 26 Oct 2005 17:09:35 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DAC2613F345; Wed, 26 Oct 2005 17:09:34 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86u0f4fjah.fsf@blue.stonehenge.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10670>

Hi,

On Wed, 26 Oct 2005, Randal L. Schwartz wrote:

> Randal> sha1_file.c:1247: error: `ENOTSUP' undeclared (first use in this 
> function)

I thought ENOTSUP is POSIX standard?

What does your man page for link() say? If it is not supported, what value 
will be in errno?

Ciao,
Dscho
