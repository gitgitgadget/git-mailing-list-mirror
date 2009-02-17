From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: Re: Blamming a diff between two commits?
Date: Tue, 17 Feb 2009 11:09:52 -0300
Organization: DATACOM
Message-ID: <499AC530.7000408@datacom.ind.br>
References: <499AB8A1.7090909@datacom.ind.br> <alpine.DEB.1.00.0902171452060.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQf3-0007rY-Si
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZBQOJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZBQOJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:09:27 -0500
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:45027 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751479AbZBQOJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2009 09:09:25 -0500
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 07DCC2AD07; Tue, 17 Feb 2009 11:09:20 -0300 (BRT)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id A3B172ACDE;
	Tue, 17 Feb 2009 11:09:20 -0300 (BRT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902171452060.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110384>

Johannes Schindelin wrote:
> 
>> Is there any way to git blame (or annotate) a diff between two commits?
> 
> If you do not mean the diff, but a commit range:
> 
> 	$ git blame A..B -- file
> 
> "Unblameable" lines will be shown with a prefix ^A (not literal, of 
> course, but the short commit name of A).
> 

This work fine for lines that were added or changed, but not for deleted lines.

If a commit in the range just delete a couple of lines and adds nothing, the whole file is marked as "unblameable" as the deleted lines doesn't exist anymore.

 - Samuel
