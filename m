From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to update a submodule?
Date: Sun, 2 Jan 2011 11:57:26 -0600
Message-ID: <20110102175725.GC13358@burratino>
References: <20101231222438.GA28199@cs-wsok.swansea.ac.uk>
 <201012312342.oBVNg1lx021930@no.baka.org>
 <20110101203957.GC26920@cs-wsok.swansea.ac.uk>
 <4D2061C7.5050405@web.de>
 <20110102155514.GB32745@cs-wsok.swansea.ac.uk>
 <4D20B629.8000107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Oliver Kullmann <O.Kullmann@swansea.ac.uk>,
	Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 02 18:57:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZSBY-0006G3-Fc
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 18:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab1ABR5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 12:57:34 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37354 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab1ABR5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 12:57:33 -0500
Received: by iwn9 with SMTP id 9so12803552iwn.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7KzeoI2lgIT1yGnyNSGu5Kh0Z7LLe4G+aEyiDo+IKcA=;
        b=KtewRAIOiaywHuJTuToGra5rEC32MgHyVXmrz9Z8u0pdY9oZTE07x2ZwO4xzWVHVYw
         /ec/Dw/++gRt91tCDtHhYSZ6yQuLRDjbx3W9eBjCos2qo0g1TjYJp8j1Aa1osOPhO6xi
         98h5jiAG4k+PmMSFjFxjH7H8jVYgJwBAwoAfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q0a56aCOrN9SOVx/L7Ht4ljUxw98XfH34DMWFsJTd1YZZB4wB9XEWJgIM0wGOuQ6mh
         YNMwmDib+QTp9WugvBz/COfrc/hx8Iqg1vVkZ7x8gT4c1tp5AbWwvPJywRIKmueStxhL
         F5JAhYJtdNV6b23b2wMurRktuS0kBSJAchrwQ=
Received: by 10.231.167.201 with SMTP id r9mr3447329iby.46.1293991052853;
        Sun, 02 Jan 2011 09:57:32 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id d21sm17913236ibg.3.2011.01.02.09.57.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 09:57:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D20B629.8000107@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164423>

Jens Lehmann wrote:

> Submodules don't work very well when you change URLs (that can result
> in forcing your coworkers to do a "git submodule sync" in their repo
> every time they switch to a commit with a changed URL).

For the future, it is probably most convenient to use URLs starting
with "../" or "./", which would rarely need to change.  That can even
work with passing around a tarball of bundles and a script to
reconstitute them, I think.

Thanks for some food for thought.
Jonathan
