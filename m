From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Tue, 12 Oct 2010 13:14:32 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4CB44318.7000305@atlas-elektronik.com>
References: <loom.20101012T114900-532@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 13:14:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5coO-0001ws-Tm
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 13:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab0JLLOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 07:14:23 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:53662 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757184Ab0JLLOW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 07:14:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id A464A10051;
	Tue, 12 Oct 2010 13:14:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 41HYnakjWfbC; Tue, 12 Oct 2010 13:14:18 +0200 (CEST)
Received: from mgsrv01.atlas.de (unknown [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue, 12 Oct 2010 13:14:18 +0200 (CEST)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 1B4C42716A;
	Tue, 12 Oct 2010 13:14:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <loom.20101012T114900-532@post.gmane.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158830>

On 10/12/2010 12:03 PM, Christian Halstrick wrote:
> Can I checkout a certain file to a specific revision without also adding this 
> content to the index? I only want to alter the working-tree - no modification of 
> index or HEAD needed.
> 
> Here is why I need that: I see a bug in git controlled sources. I fix one source
> file and also add one unit test in a separate file. I checked that the test
> succeeds with my fix. The index now contains what I want to commit.
> Now I want to see whether my test fails without my fix. I want to checkout HEAD
> for the source file without destroying my index. In the end, after I saw that my
> test fails without my fix, I just want to say "git commit" without having to.

commit the unit test first, and the fix as a second commit ?

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Help endangered species - adopt a KGB operative.
