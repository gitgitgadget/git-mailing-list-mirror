From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: ssh communication not working
Date: Fri, 23 Jul 2010 13:07:12 +0300
Message-ID: <20100723100712.GA11889@LK-Perkele-V2.elisa-laajakaista.fi>
References: <4C45A7C5.1050601@llaisdy.com>
 <20100720153553.GA2931@localhost.localdomain>
 <4C496419.5070902@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 12:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcF9M-0004ZO-6V
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0GWKGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:06:34 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:36777 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab0GWKGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:06:33 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 220218C522;
	Fri, 23 Jul 2010 13:06:32 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A04B5806CB8; Fri, 23 Jul 2010 13:06:32 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id F165BE51AB;
	Fri, 23 Jul 2010 13:06:29 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4C496419.5070902@llaisdy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151511>

On Fri, Jul 23, 2010 at 10:42:49AM +0100, Ivan Uemlianin wrote:
> 
> I tried cloning over ssh and got an error:
> 
>     $ git clone ivan@myserver.com:/path/to/git/myproject.git
>     Initialized empty Git repository in /Users/ivan/.git/
>     ivan@85.92.88.62's password: ...
>     bash: git-upload-pack: command not found
>     fatal: The remote end hung up unexpectedly

You don't have git-upload-pack in non-interactive $PATH (it is not the same
as $PATH for interactive logins). Edit ~/.bashrc on remote side?

-Ilari
