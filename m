From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking in git.git (May 2010, #04; Wed, 12)
Date: Sat, 15 May 2010 11:04:58 +0200
Message-ID: <20100515090458.GA7712@localhost>
References: <7vzl057dt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 15 11:05:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODDJJ-0006yH-Pf
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 11:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab0EOJFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 05:05:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60563 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0EOJFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 05:05:21 -0400
Received: by fxm6 with SMTP id 6so2221020fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=O5gcDwilCesWkjeDbOFojpoAI8sqlhJTfkdI2nMdLK0=;
        b=myBbhyKfhxLMYkwvHH1cOdot/tBZXZIOaOQLFdXGLj86gr7GPQIq+v5+epY/YAKdzQ
         eHa9VGN8ef+ec5yYz5dQ8k+wIhpDBUsGNFOZwZXTsOLoyRRZABx16WVl5C4/XXkWdWev
         z1gDQlyX0I0zUmH9k4w+0SWchrv4PhPbPURpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=bgxFCc+RKWh1c3KLVgs3zFPXSerjKP4iIBYS3eGDX/PzdkKMWBlXa7ro+kSozJkR8P
         sKj4nfBMUXpp6o2NWoy4n39JqCSAjYFSbKbOLS81f8AI7lTB2mCrDWuxhA42nHj46Waj
         RLoGcAXk4BLwIz/jrs1acr+ncRmB5kqMqOUQ8=
Received: by 10.223.63.17 with SMTP id z17mr2850080fah.66.1273914319946;
        Sat, 15 May 2010 02:05:19 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id g10sm15000761fai.0.2010.05.15.02.05.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 02:05:19 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1ODDIo-000245-St; Sat, 15 May 2010 11:04:58 +0200
Content-Disposition: inline
In-Reply-To: <7vzl057dt9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147135>

Hi Junio,

On Wed, May 12, 2010 at 12:57:06AM -0700, Junio C Hamano wrote:

> [Cooking]

> * cb/assume-unchanged-fix (2010-05-01) 2 commits
>  - Documentation: git-add does not update files marked "assume unchanged"
>  - do not overwrite files marked "assume unchanged"

Without this patch, git silently overwrites work tree files, while the
documentation claims it's safe.  I was therefore expecting this to go to
master, possibly even maint.

Is there something controversial about these patches that I'm not aware of?
If so, we should at least fix the documentation in the meantime.

Cheers,
Clemens
