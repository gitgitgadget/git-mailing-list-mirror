From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Wed, 16 Sep 2009 13:11:26 +0200
Message-ID: <4AB0C7DE.7030109@viscovery.net>
References: <20090916103129.GA21430@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnsQM-00020x-KH
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbZIPLLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 07:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbZIPLLh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:11:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65037 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbZIPLLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 07:11:36 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MnsQ2-0001oy-Nb; Wed, 16 Sep 2009 13:11:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 74C55A4A1; Wed, 16 Sep 2009 13:11:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090916103129.GA21430@feather>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128641>

Josh Triplett schrieb:
> I considered adding a -f/--force option, like gzip has, but writing an
> archive to a tty seems like a sufficiently insane use case that I'll let
> whoever actually needs that write the patch for it. ;)

How about '--output -' instead?

-- Hannes
