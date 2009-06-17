From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: Using git for code deployment on webservers?
Date: Wed, 17 Jun 2009 19:27:18 +0200
Message-ID: <200906171927.18435.ioe-lkml@rameria.de>
References: <200906160111.47325.ioe-git@rameria.de> <200906161001.33678.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Wed Jun 17 19:31:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGyyy-0005Bp-4V
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 19:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879AbZFQRa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbZFQRa4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 13:30:56 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:35875 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbZFQRaz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 13:30:55 -0400
Received: from [91.62.59.75] (helo=axel.localnet)
	by smtprelay10.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ioe-lkml@rameria.de>)
	id 1MGysM-0003ue-Cj; Wed, 17 Jun 2009 19:24:42 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; x86_64; ; )
In-Reply-To: <200906161001.33678.thomas@koch.ro>
Content-Disposition: inline
X-Df-Sender: 849595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121763>

Hi Thomas,

On Tuesday 16 June 2009, Thomas Koch wrote:
> Would it help, to share a read only GIT object store among all webservers via 
> NFS?

NFS on hundreds of web servers has severe scaling problems. That is by design and is solved
by alternative file systems or soon pNFS.

We tried such a setup already.


Best Regards

Ingo Oeser
