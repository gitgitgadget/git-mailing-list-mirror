From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-gui: Add a search command to the blame viewer.
Date: Fri, 03 Oct 2008 10:29:29 +0200
Message-ID: <48E5D7E9.6060302@op5.se>
References: <1223019414-24643-1-git-send-email-angavrilov@gmail.com> <1223019414-24643-2-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 10:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klg3i-0007Lr-Fq
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 10:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYJCI3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 04:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYJCI3e
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 04:29:34 -0400
Received: from mail.op5.se ([193.201.96.20]:59813 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbYJCI3d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 04:29:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A1AEB1B8005E;
	Fri,  3 Oct 2008 10:21:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogudSCLnM5gV; Fri,  3 Oct 2008 10:21:07 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 006F21B80048;
	Fri,  3 Oct 2008 10:21:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1223019414-24643-2-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97405>

Alexander Gavrilov wrote:
> One of the largest deficiencies in the blame viewer at
> the moment is the impossibility to search for a text
> string. This commit fixes it by adding a Firefox-like
> search panel to the viewer.
> 
> The panel can be shown by pressing F7 or clicking a
> menu entry, and is hidden by pressing Esc. Find Next
> is available through the F3 key.
> 
> Implementation is based on the gitk code, but heavily
> refactored. It now also supports case-insensitive
> searches, and uses the text box background color to
> signal success or failure of the search.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
> ---
> 

What with me being a total tcl nubling, I can't comment on the
patch, but the intentions are clearly full of win and awesome.
I was utterly surprised to notice this functionality wasn't in
there the first time I needed it.

Thanks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
