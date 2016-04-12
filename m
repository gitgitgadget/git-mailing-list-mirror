From: John Keeping <john@keeping.me.uk>
Subject: Re: Git config not working correctly with included configurations
Date: Tue, 12 Apr 2016 14:02:36 +0100
Message-ID: <20160412130236.GA11013@serenity.lan>
References: <assp.0910338c53.570CDB33.9020300@itflex.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rudinei Goi Roecker <rudineigr@itflex.com.br>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:11:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apy5s-0004mS-MR
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 15:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbcDLNKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 09:10:50 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:46750 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757186AbcDLNKs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 09:10:48 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Apr 2016 09:10:48 EDT
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 15869230AE;
	Tue, 12 Apr 2016 14:02:44 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 121073410;
	Tue, 12 Apr 2016 14:02:44 +0100 (BST)
X-Quarantine-ID: <bdkipcuDMQim>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.25
X-Spam-Level: 
X-Spam-Status: No, score=-0.25 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, KAM_INFOUSMEBIZ=0.75]
	autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bdkipcuDMQim; Tue, 12 Apr 2016 14:02:42 +0100 (BST)
Received: from serenity.lan (unknown [10.2.0.10])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id AFFAD342C;
	Tue, 12 Apr 2016 14:02:40 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <assp.0910338c53.570CDB33.9020300@itflex.com.br>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291259>

On Tue, Apr 12, 2016 at 08:25:39AM -0300, Rudinei Goi Roecker wrote:
> I'm having a problem with included configurations in ~/.gitconfig, when 
> using this command:
> 
> git config --global user.email


> It doesn't return anything, in commits it works as intended. The 
> configuration looks like this:

I think you need:

	git config --global --includes user.email

or simply:

	git config user.email

See the documentation of the --includes and --no-includes options in
git-config(1).
