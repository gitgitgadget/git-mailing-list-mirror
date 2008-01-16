From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:04:22 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161600030.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <m37ii9nagt.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:07:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8uC-000414-18
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYAPOFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbYAPOFn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:05:43 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:38517 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752412AbYAPOFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:05:42 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF8tY-0007Nd-A7; Wed, 16 Jan 2008 16:05:32 +0200
In-Reply-To: <m37ii9nagt.fsf@roke.D-201>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70674>

On Wed, 16 Jan 2008, Jakub Narebski wrote:

> You can always tag a blob (like junio-gpg-pub tag in git.git repository),
> but it wouldn't be in a working directory. But it would get distributed
> on clone.

Hm, how does it work?

> BTW. if those large binary files doesn't differ much between version, 
> they should get well compressed even if you would store them normally, 
> all revisions.

Unfortunately this is not the case.  These binary blobs are already 
compressed and/or encrypted and adding even a few bytes ends up storing 
new version in full size.


cheers,
Petko
