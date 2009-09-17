From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Thu, 17 Sep 2009 07:53:35 +0200
Message-ID: <4AB1CEDF.7020105@viscovery.net>
References: <20090916103129.GA21430@feather> <4AB0C7DE.7030109@viscovery.net> <20090917014854.GD3274@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 07:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo9xT-0006F2-EQ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 07:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbZIQFxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 01:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZIQFxg
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 01:53:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62324 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbZIQFxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 01:53:35 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mo9vz-0002qv-Im; Thu, 17 Sep 2009 07:53:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4C47DBC81; Thu, 17 Sep 2009 07:53:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090917014854.GD3274@feather>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128713>

Josh Triplett schrieb:
> On Wed, Sep 16, 2009 at 01:11:26PM +0200, Johannes Sixt wrote:
>> How about '--output -' instead?
> 
> Yeah, that seems significantly better than --force.  Though I don't
> particularly care for the '-' convention to mean 'stdout'; in principle
> that ought to create a file named '-' in the current directory.
> /dev/stdout makes more sense, and doesn't require any work on git's
> part beyond this patch.

Except that /dev/stdout is not portable. You can always say --output ./-
if you want an oddly named file in the current directory.

-- Hannes
