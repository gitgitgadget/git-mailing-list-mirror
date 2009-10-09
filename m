From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Smart HTTP Protocol
Date: Fri, 9 Oct 2009 11:09:18 -0700
Message-ID: <20091009180918.GY9261@spearce.org>
References: <4ACF79E0.5000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwJzv-00051r-Uo
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761253AbZJISJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 14:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761248AbZJISJz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:09:55 -0400
Received: from george.spearce.org ([209.20.77.23]:45325 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761010AbZJISJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:09:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE71A381FE; Fri,  9 Oct 2009 18:09:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4ACF79E0.5000606@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129827>

Michael Gaffney <mr.gaffo@gmail.com> wrote:
> What ended up being the status on this? From the last I saw, the  
> protocol and the fallover smart to dumb had all been worked out. It was  
> just that people were waiting on an implementation server side of the  
> protocol before the client was implemented?

Uh, did you read my thread from last night at 10:30 pm called
"Return of smart HTTP" ?

Previous to this week we did not have a working server, OR a working
client, OR even a final spec.

I've started working on smart HTTP full time, and am not touching
any other project until the patches are being carried in Junio's
"next".  I'm not going to rush the reviews on the list, but so long
as there is code for me to write/fix or documentation to write/fix
I'm refusing to touch another task.

I have it full implemented in JGit (client and server).  I have
most of the server implemented in C Git.  I'm working on the C Git
client today.

-- 
Shawn.
