From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Wed, 1 Apr 2009 17:28:36 +0800
Message-ID: <544dda350904010228q93c7425m7ba12e2286617b3d@mail.gmail.com>
References: <20090321154738.GA27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Magnus_B=E4ck?= <baeck@swipnet.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 11:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lowlv-0000cz-7T
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 11:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbZDAJ2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 05:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbZDAJ2k
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 05:28:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:51207 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbZDAJ2j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 05:28:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3531592rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 02:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=oc6N0WWw8EZ+xy66ztWqleLwYQSMGjp9klzByqxc/Wo=;
        b=lJu5AlGOcIxMa2Jham7iSPcPHsqclfr9+3+V6twrJTpxUoVUANunrd/kWQQUpUjFkN
         oigvScVFQlXexsLlFNG5GLu4++/5X5H+2chu8rdkKuPewtDTRGAO2DjpzhqiAxdxhSTB
         oT4WHT32yuPJMvdcf1vpbKm2Ocs+bvhS0+83A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=GjAjx9Uy/FQNCh9r0dm3YS3PES+mGbcR+Cl6Vwgn51vLVkIPRKqk3GPIKdDhWFmK9q
         OXh8Bpdwg/bPVomxoJCrIrjIWvIsmTA9XGhVWAPF97EVAvNFMOkc8JZnvx2HePWBrgGy
         mRQgFsJw8R+EmzdC8IR37FuHx/LjLvzA61SIg=
Received: by 10.142.105.10 with SMTP id d10mr3058085wfc.71.1238578116577; Wed, 
	01 Apr 2009 02:28:36 -0700 (PDT)
In-Reply-To: <20090321154738.GA27249@jeeves.jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115359>

On Sat, Mar 21, 2009 at 11:47 PM, Magnus B=E4ck <baeck@swipnet.se> wrot=
e:
> Is there any reason why compat/win32.h uses GetFileAttributesEx()
> instead of FindFirstFile() to implement the stat() call on Windows?

This blog post explains checking file existence using GetFileAttributes=
(Ex) vs.
=46indFirstFile quite nicely:

    http://blogs.msdn.com/oldnewthing/archive/2007/10/23/5612082.aspx

nazri.
