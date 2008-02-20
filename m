From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 14:49:06 -0500
Message-ID: <76718490802201149w5a7c0b88udef968f4083190ea@mail.gmail.com>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
	 <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRuwq-0002fC-Cz
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbYBTTtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbYBTTtI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:49:08 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:42922 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYBTTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:49:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4151861wah.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wCsM9DtLruWDsfpt4n5/2gIWzrTDhbGKlz3p5xkj1/s=;
        b=UnV9VnUzbxk+Sp01ArweZbEPCZArmbQ/Lm5i0ENL/8Ff61sAZn5m5dC4cUouGh4HeuhXL9TTBqw8SHNJyBVix39yr5dOf6Y64izUvTfsfwzzUCYGrS7xwhdHno0Kc93Y6imTcctoti7kjISoIqz0L661298uGzdPqg+ryO8h5Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZY5tCHVV5LYJfsnICKefLArw7kGqdH/xoT+0DP15tX0OsvqkNVqBJma5FJiqoXKub7QGIiu5pu/Mc9uy0e+4O4IAKTfTONan7ouGIgYLFxTzp/vFMkUJ9jkSdWSj2AqGWTjBVS14dWUKcy5l6zQcoaaPW/zkeTiKjLTLpCz1vGc=
Received: by 10.114.58.1 with SMTP id g1mr8693752waa.91.1203536946280;
        Wed, 20 Feb 2008 11:49:06 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 11:49:06 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74541>

On Feb 20, 2008 2:24 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> This order of values is definitely the right thing, for the mapping
> reasons you saw. And I think "aka" is generally used to indicate
> additional non-canonical names for something with an official name (see,
> for example, IMDB's usage). I haven't been able to come up with anything
> better to indicate "this is a name that I will recognize but not use
> myself".

I think the word you want is "alias", isn't it? I've never really seen
aka used in a technical sense, whereas alias is used quite often (URL
aliases, DNS aliases, etc). So:

url.$canonical_name.alias = $local_name.

$0.02.

j.
