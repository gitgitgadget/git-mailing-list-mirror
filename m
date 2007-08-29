From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Wed, 29 Aug 2007 11:50:11 +0100
Message-ID: <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com>
References: <20070826202724.16265.85821.stgit@yoghurt>
	 <20070826203344.16265.66280.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 12:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQL8F-0007on-T5
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbXH2KuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 06:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbXH2KuP
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:50:15 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:29090 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXH2KuN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2007 06:50:13 -0400
Received: by nz-out-0506.google.com with SMTP id s18so121821nze
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 03:50:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l8zWft8aB+Evf54Ez74mMaoFeKmo06wFVf8EwJvDfOwkBI4eIrbMNSSvESj8UtSxViniMduua+aRj/7U00GXWc6DjfCql9rRS5w8eD7VjAwd8SdMfCxBy0iq/wtFnCkDmSGjogUAsedYKGGqsrg+nHBYw5dQD8+nlgCuC8i6Gao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F2qXtGqSF/yjfF4R4iMlpCBtQLGC6fOZVkb710gwxzOu/21TZ812Oq3YTX8Fpjoj9feHZdEmUHJ8ZQBiavrc8lMR0502Cu0lgL9nsgILKX3cXdgDorF/CBvbVRViO8qUqf4rq04C2STX9m5MlB0fXUsNsFO0XtlV9VgEeAOxbUw=
Received: by 10.141.79.12 with SMTP id g12mr272144rvl.1188384611519;
        Wed, 29 Aug 2007 03:50:11 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Wed, 29 Aug 2007 03:50:11 -0700 (PDT)
In-Reply-To: <20070826203344.16265.66280.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56933>

On 26/08/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Now that the subprocess calling has been refactored and is in a nice
> shape, it's quite simple to add some logging facilities. This patch
> adds two separate log modes, switched by the STG_SUBPROCESS_LOG
> environment variable:

Any objection to calling this variable STGIT_SUBPROCESS_LOG? We
already have STGIT_DEBUG_LEVEL (used in stgit.main). I can do it in my
tree before pushing as I already merged your branches.

BTW, thanks for refactoring the subprocess calling.

--=20
Catalin
