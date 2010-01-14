From: Gavin Beatty <gavinbeatty@gmail.com>
Subject: Re: Problem creating commits/trees with commit-tree/mktree
Date: Fri, 15 Jan 2010 00:18:00 +0100
Message-ID: <f6d77fed1001141518l22987752x5a1c1e84cb68b677@mail.gmail.com>
References: <f6d77fed1001111014g73a06923na05cd14d37968b04@mail.gmail.com> 
	<32541b131001111038m3dacaf72sc12f24aba8c60e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:18:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYxP-0003HM-61
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab0ANXSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 18:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754859Ab0ANXSW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:18:22 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:39844 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab0ANXSV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 18:18:21 -0500
Received: by ewy1 with SMTP id 1so112016ewy.28
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mCx+wg9DVEdmlIHHImtUVe1kyc2AkG4JYO36huMC8bY=;
        b=TpOUvOxzWPF5dYVcOfc8nU3DQe8pYp1eZ8k/dFtI9HdPnlVEOVH/GpGXxY1dUYI+5O
         9SMA/hXrRyC8uszY2YYU+zQYlVW1nCAyH+TmBJ1GcnFMYcVVF/kTF2bDb+w8W87c5mkJ
         +Tv7i9uRVyyY8XFor5LO1wDMDiypRliVxYQHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=E2lqDdYI6e7gqzDsIxGklt3QdY+5GnyjrWEmTl5YTLye72LWcFGOGRKeZXauxoTBWi
         NTvKDvob/UJDnaixSy9ogz5U2A+pVfPBG5LRlP04gOCqgzWcWTyoEkj2TDDR5HevLNN+
         AQ4mEBusBk/sbymcvmvsPirtw8bQMdkKSGSpQ=
Received: by 10.213.96.221 with SMTP id i29mr1513926ebn.33.1263511100126; Thu, 
	14 Jan 2010 15:18:20 -0800 (PST)
In-Reply-To: <32541b131001111038m3dacaf72sc12f24aba8c60e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137037>

On Mon, Jan 11, 2010 at 19:38, Avery Pennarun <apenwarr@gmail.com> wrot=
e:
> When I'm doing similar things, I often prefer just using a temporary
> git index file to keep track of my intermediate trees. =C2=A0Just set
> GIT_INDEX_FILE to point at a temporary file; then you can use
> git-read-tree to read in an old tree, and git-update-index
> (particularly with the --stdin flag) to update it. =C2=A0Then you can=
 use
> git-write-tree to convert the temporary index into a real tree object=
=2E

Your suggestion works well.  git update-index --info-only -z
--index-info takes ls-tree -r -z style format and pre-existing
objects: just as I wanted.

Thanks, git-fast-import was too much for the quite simple git-related
code I need.

--=20
Gavin Beatty

SEMPER UBI SUB UBI
