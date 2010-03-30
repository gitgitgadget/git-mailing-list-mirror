From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 0/2] git-gui: git-gui: change to display the diff with
 the  HEAD in the case of conflicts.
Date: Tue, 30 Mar 2010 08:44:13 +0200
Message-ID: <4BB19DBD.90009@viscovery.net>
References: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 08:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwVBX-00087W-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 08:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab0C3GoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 02:44:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31973 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab0C3GoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 02:44:17 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NwVBO-0005ZA-8m; Tue, 30 Mar 2010 08:44:14 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F25C91660F;
	Tue, 30 Mar 2010 08:44:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143549>

Am 3/30/2010 1:00, schrieb Jon Seymour:
> Resending because my original patch series wasn't whitespace clean and
> I have now removed the configuration to make the safe behaviour
> optional - it is not safe by default.
> 
> If there is any other reason why this patch should not be considered,
> please let me know.
> 
> [PATCH v2 1/2] git-gui: Introduce is_unmerged global variable to
> encapsulate its derivation.
> [PATCH v2 2/2] git-gui: change to display the diff with the HEAD in
> the case of conflicts.

The default mode of diff in the case of conflicts is "condensed combined",
which removes "unintersting" changes from the display. AFAIK, there also
exists a mode that is only "combined". I would think that this mode is
much more useful here because it shows the diff to both HEAD and
MERGE_HEADs at the same time.

Only that I don't know how to invoke this mode...

-- Hannes
