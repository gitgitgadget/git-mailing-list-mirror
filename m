From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 12:04:54 +0100
Message-ID: <C66A69E6.205F2%jefferis@gmail.com>
References: <4A44A66B.10906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 13:05:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK9FZ-0005Fr-BC
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 13:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbZFZLE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 07:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbZFZLE6
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 07:04:58 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58363 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbZFZLE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 07:04:57 -0400
Received: by ewy6 with SMTP id 6so3208099ewy.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version
         :content-type:content-transfer-encoding;
        bh=t7OEkg9ZmFcSTqcM/pwgXGqkInqXe92oNU0Aqn5b+xQ=;
        b=WnNGd1gyXJoUDa2jKIFwProCgmYMZHgM28YR7kuvTMeyOeyCONhCXsWGN5srgUjN93
         SbAlTjP728RIvkKMXx8FGeziclB9uqsYgd3PjlQ8cqbBKXnAgaw9BFQ5S9QsEX9wEv6M
         +Gjl/A3tS1ZJ3CTdY2CKoRcd+Ai81QZ3NY4NE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :thread-index:in-reply-to:mime-version:content-type
         :content-transfer-encoding;
        b=ngv0scUNSJXnds4852eM33iFoopmLuIj1GXlRnxs0AVKDpyQAA0YJEcOOunAW/oCR4
         cTKxm3zEfESHXq62sl+LaUYz4Ib0D5ZFsTVsotgc6E7IETgNi6vInGrCTIiH8bC2iNi9
         R6AcU+I15gbJJEUIpuquE89uAfSW8Qhdd+c0E=
Received: by 10.210.43.10 with SMTP id q10mr1983487ebq.2.1246014299476;
        Fri, 26 Jun 2009 04:04:59 -0700 (PDT)
Received: from ?10.6.0.183? (nat.mrc-lmb.cam.ac.uk [131.111.85.79])
        by mx.google.com with ESMTPS id 7sm2849120eyg.32.2009.06.26.04.04.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 04:04:59 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.13.0.080930
Thread-Topic: Choosing a mergetool according to file type
Thread-Index: Acn2Te8IaKTQGQrO7E+wxrVjn3xP8A==
In-Reply-To: <4A44A66B.10906@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122291>

Hi Johannes,

On 2009-06-26 11:43, "Johannes Sixt" <j.sixt@viscovery.net> wrote:

> I don't think that you can choose the merge tool by setting attributes.

OK, that was my impression, but I wanted to check.

 > The reason I write to you is: Can you tell me what 'wordgitmerge' and
> 'wordgitdiff' are?
> 
> I, too, have a number of Word files that I need to merge every now and then.

Ah!  Well they are nothing fancy, I'm afraid, just scripts that call Word
itself, but that turns out to work pretty well.  For Mac (my platform) they
have to be in applescript.  For Windows I imagine they could be pretty much
the same as the scripts here:

http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/contrib/diff-scripts/

diff-doc.js
merge-doc.js

Perhaps tortoisegit already exposes this.  Those scripts include fallbacks
for openoffice so I suppose one could use that on linux.

Best,

Greg.
