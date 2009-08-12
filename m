From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Tie a CVS-aware app into GIT?
Date: Wed, 12 Aug 2009 14:34:13 -0400
Message-ID: <46a038f90908121134u5c109477tdb5152ea1de5d496@mail.gmail.com>
References: <b988339dcd1bf764f0da46db763552d8.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david.hagood@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 20:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbIee-0002hC-0T
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 20:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbZHLSeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 14:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbZHLSeO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 14:34:14 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:36971 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbZHLSeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 14:34:13 -0400
Received: by fxm28 with SMTP id 28so181767fxm.17
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=89mPtVmexfLZt/CoX/azcE6ofQakp3PirAaLIvUpxDE=;
        b=sxcN+tU3Ol7L54MlMsyGiwsHp/l/v0EZSi8bA+GuSe0Pa2qg2+202zxtp1Cl3QOfDV
         3eYwjd7BERx4q+wqxKvkDylTZ5zrE70Nedzgz4Hf0fza/z5w9OSHUclRhJ9uQqX7D4O3
         Rr47wWEi7MwL1vSbQNeRbVmWPho2w4LvdB/xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pOcLSRR85AC6dwxQwrFonD1YtxuaLT0gH5BMXAuBghTjD3mUOBax97sHrZp9qtfZ/X
         jvCRepjKfXG0Uds+dnLtTc99H3m0rhXratoksD7GVmnkSUJmjkGi9Fyva7a8xMEPpPEc
         tCj2M+3yvF0ys0rEPTG97RxSuCQY7uICo88rc=
Received: by 10.223.122.20 with SMTP id j20mr125515far.102.1250102053627; Wed, 
	12 Aug 2009 11:34:13 -0700 (PDT)
In-Reply-To: <b988339dcd1bf764f0da46db763552d8.squirrel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125724>

On Wed, Aug 12, 2009 at 2:01 PM, <david.hagood@gmail.com> wrote:
> I've thought about git-cvsserver as a solution, but I don't know if it can
> be run on a local machine to access a local repository.

Even though the docs say you can't (well, you should have to run it
over pserver) ISTR there is a way to get the cvs client to instantiate
a server using the CVS_SERVER envvar even for local ops.

Worth checking in the more detailed CVS user guide.



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
