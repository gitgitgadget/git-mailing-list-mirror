From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 07:04:09 -0700 (PDT)
Message-ID: <alpine.DEB.1.00.0806100703460.22017@alchemy.localdomain>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <alpine.DEB.1.10.0806092335420.17180@swallowtail> <484E8833.9030302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K64W1-0002Zi-Ot
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbYFJOHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYFJOHJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:07:09 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:42480 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213AbYFJOHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:07:08 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 30914A012E;
	Tue, 10 Jun 2008 10:10:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id 7E4896C010;
	Tue, 10 Jun 2008 07:04:09 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <484E8833.9030302@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84506>

On Tue, 10 Jun 2008, Clark Williams wrote:

> Asheesh Laroia wrote:
>>
>> Peanut gallery question: Why not just always try these methods and catch
>> some format exception if they fail, proceeding to the next possible
>> decompressor (proceeding on to no decompressor)?
>>
>> That way if a file is called .GZ, it will still be handled properly; in
>> fact, all files would still be handled properly.  And these formats
>> leave notes in the first few bytes of the file as to if they should be
>> tried, so it's not as if it would come at some performance cost.
>
> Interesting thought. Do all the decompressors throw an error if the input format
> isn't recognized?

Yup!  (Try it!)

-- Asheesh.

-- 
You might have mail.
