From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: error: insufficient permission
Date: Mon, 21 Sep 2009 10:53:19 +0200
Message-ID: <4AB73EFF.50601@viscovery.net>
References: <4AB73A07.3020703@bioinf.uni-leipzig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dominic Rose <dominic@bioinf.uni-leipzig.de>
X-From: git-owner@vger.kernel.org Mon Sep 21 10:53:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpeeG-00049e-H9
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 10:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbZIUIxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 04:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbZIUIxR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 04:53:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24413 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137AbZIUIxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 04:53:17 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mpee7-0004yW-Fh; Mon, 21 Sep 2009 10:53:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 392786D9; Mon, 21 Sep 2009 10:53:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AB73A07.3020703@bioinf.uni-leipzig.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128870>

Dominic Rose schrieb:
> error: insufficient permission for adding an object to repository
> database ./objects
> 
> fatal: failed to write object
> error: unpack failed: unpacker exited with error code
> To /homes/[...]
> ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to '/homes/[...]'

Make sure you have permission to create new files and directories in
/homes/[...]/objects and that you have permission to create new files in
all directories that are already in /homes/[...]/objects.

-- Hannes
