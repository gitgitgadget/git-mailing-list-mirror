From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Re: [JGIT PATCH] 1/2: Externalizable items
Date: Mon, 16 Feb 2009 17:10:03 +0000
Message-ID: <320075ff0902160910v723d077bp5eb3559c1d8f998a@mail.gmail.com>
References: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
	 <alpine.DEB.1.00.0902161758030.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ71P-0006xB-A9
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbZBPRKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbZBPRKK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:10:10 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:40927 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZBPRKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:10:09 -0500
Received: by fxm13 with SMTP id 13so6142489fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 09:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fuNGV/tGt061ed6fr2HsTsBDG5UehDYbpeKhV2Ey+Kk=;
        b=QnRKwurp+zzj9zXtpVHBdZeBRZXS06ijcHlNMK1xPxMgyGqWRg93S1qUCBHni7JN36
         6Jdz6/z2H5Ax7aahkUsKkRUJ3cTojkTP45nMTSJodJrA+IqL659pRqDVQhwE1aaLf6wk
         WqwQS2Ft3ViaublqCeyTqyRDCKYI9twcol9to=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h7hKQoL1cWP++HhvqHieSGit07oiCCTCmANxDswxvyG8pUMzlMBYfJZQgBDsi/j36Q
         Ak2aqa9QMbcxy03IhA1z/9Ndn81pu/KB8C89zFHY+QoBK3gJG/VeZmy7rOrrTd8XZgC4
         kG5x2PbiEAacRObSQ3fZUr8u5Y9EX7oSAUFps=
Received: by 10.103.248.1 with SMTP id a1mr3066883mus.40.1234804203249; Mon, 
	16 Feb 2009 09:10:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902161758030.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110212>

Externalizable is the java standard for Serializable, but controlling
the exact format (rather than using introspection).

http://n2.nabble.com/-PATCH-JGIT--Minor-%3A-Make-ObjectId%2C-RemoteConfig-Serializable-td2286559.html#none


On Mon, Feb 16, 2009 at 4:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 16 Feb 2009, Nigel Magnay wrote:
>
>> Make parts of jgit externalizable, so that they can be marshalled over
>> the wire or onto disk,
>> using formats from git mailing list.
>
> Hmm.  I have to be honest and admit that I have no idea what you mean by
> externalizable.  From the "marshalling" comment, I'd have assumed that you
> mean Serializable, but then I still do not understand what "formats from
> git mailing list" are.  And that being a regular of said list for quite
> some time...
>
> Care to enlighten me?
>
> Ciao,
> Dscho
>
