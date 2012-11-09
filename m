From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Rename edge case...
Date: Fri, 09 Nov 2012 14:17:06 +0100
Message-ID: <509D0252.8070901@viscovery.net>
References: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com> <1352453243-ner-1164@calvin> <CAEBDL5WeQEWdyaJuuNbnnQbbsLYv8NO1ZSj3eHHpjW+ToS9X1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWoSc-0004QB-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 14:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2KINRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 08:17:13 -0500
Received: from so.liwest.at ([212.33.55.23]:3400 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2KINRM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 08:17:12 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TWoSJ-0001QQ-Fe; Fri, 09 Nov 2012 14:17:07 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1ABA91660F;
	Fri,  9 Nov 2012 14:17:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CAEBDL5WeQEWdyaJuuNbnnQbbsLYv8NO1ZSj3eHHpjW+ToS9X1A@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209215>

Am 11/9/2012 11:25, schrieb John Szakmeister:
> On Fri, Nov 9, 2012 at 4:27 AM, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> [snip]
>> When merging two branches, git only looks at the tips. It doesn't inspect
>> their histories to see how the files were moved around. So i doesn't matter
>> whether you rename the files in a single commit or multiple commits. The
>> resulting tree is always the same.
> 
> I guess I figured that when I saw the final result, but didn't know if
> there was a way to coax Git into doing a better job here.

If the renames are split in two commits, you can merge the first, and then
the second on top of the result.

-- Hannes
