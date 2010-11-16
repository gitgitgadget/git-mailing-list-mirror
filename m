From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] [WIP] Allow running git init on a remote repository
 specification.
Date: Tue, 16 Nov 2010 06:33:50 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1011160632280.20293@ds9.cixit.se>
References: <cover.1289561504.git.peter@softwolves.pp.se> <ba28273f7efb0fa3e403a8a9d7b923b61bb62ce3.1289561504.git.peter@softwolves.pp.se> <AANLkTimqLeyDW9sJVR8NPOXQ1Xdz+kRmu9-8fPn1yj_j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 06:34:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIEBO-0001GF-BZ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 06:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab0KPFeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 00:34:04 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:59809 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754882Ab0KPFeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 00:34:00 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oAG5XpDa020791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Nov 2010 06:33:51 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id oAG5XorU020786;
	Tue, 16 Nov 2010 06:33:50 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTimqLeyDW9sJVR8NPOXQ1Xdz+kRmu9-8fPn1yj_j@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161543>

Hi!

Sverre Rabbelier:

> I remember the idea of a new remote service (e.g., in addition to 
> 'git-upload-pack' and 'git-receive-pack') to create a new repository. The 
> reason for making this a new service was so that (among others) the github 
> guys could make that do something sensible for their service.

Right, that does indeed make sense. I guess that means I need to read up a 
bit more on how to hook things together. It wasn't quite as obvious on a 
cursory glance :-)


Any objections to the first part of the patch (that detects attempts at 
remote init and rejects them)?

-- 
\\// Peter - http://www.softwolves.pp.se/
