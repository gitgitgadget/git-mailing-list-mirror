From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2] Fix remote.<remote>.vcs
Date: Wed, 27 Jan 2010 20:59:27 +0200
Message-ID: <20100127185927.GA22630@Knoppix>
References: <1264614797-22394-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <alpine.LNX.2.00.1001271335140.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaD75-0000wa-9Y
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 19:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab0A0S7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 13:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691Ab0A0S7d
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 13:59:33 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:52254 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab0A0S7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 13:59:32 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 89D25C8004;
	Wed, 27 Jan 2010 20:59:31 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A024AF8705C; Wed, 27 Jan 2010 20:59:31 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 0300B1C63A8;
	Wed, 27 Jan 2010 20:59:27 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1001271335140.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138184>

On Wed, Jan 27, 2010 at 01:39:00PM -0500, Daniel Barkalow wrote:
> On Wed, 27 Jan 2010, Ilari Liusvaara wrote:
> >  
> >  	if (!remote)
> >  		die("No remote provided to transport_get()");
> >  
> >  	ret->remote = remote;
> > +	helper = remote->foreign_vcs;
> 
> Needs to be "helper = remote ? remote->foreign_vcs : NULL", for the same 
> reason that the test below had been "remote && remote->foreign_vcs".

Few lines above that:

     if (!remote)
             die("No remote provided to transport_get()");


-Ilari
