From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: 2 projects 1 repo
Date: Wed, 28 Oct 2009 05:19:40 -0700 (PDT)
Message-ID: <26093640.post@talk.nabble.com>
References: <25530063.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37VC-0000ex-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZJ1MTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbZJ1MTg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:19:36 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33585 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZJ1MTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:19:35 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N37V6-0004py-T9
	for git@vger.kernel.org; Wed, 28 Oct 2009 05:19:40 -0700
In-Reply-To: <25530063.post@talk.nabble.com>
X-Nabble-From: timmazid@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131455>



twzgerald wrote:
> 
> I have a client-server project where I split them into 2 projects to
> separately create the client in one software project and the server in
> another. I registered myself a project hosting at sourceforge.net which
> provides a git repository. How can I put the 2 projects into the git
> repository.
> 
> I want to create some sort of hierarchy like <main-project>--> Client -->
> src --> org.project.client...etc..
>                                                                            
> |
>                                                                            
> +----------> Server --> src --> org.project.server...etc..
> 

You could simply create two branches, master-server, and master-client, and
just never ever cross-merge them, or their child branches.
Or you just create two repos.

Good luck,
Tim.
-- 
View this message in context: http://www.nabble.com/2-projects-1-repo-tp25530063p26093640.html
Sent from the git mailing list archive at Nabble.com.
