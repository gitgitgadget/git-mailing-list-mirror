From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 13:59:24 -0400
Message-ID: <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
	 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
	 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJrw-0005bm-VC
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbXDUR7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 13:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXDUR7a
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:59:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:32356 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXDUR73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 13:59:29 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1172656wra
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 10:59:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gN9acE0UnXujvnQ3CEXotf1244XQL2VZjusRTFG7wsn8BVRZS0xIJIYqWcO6oYNjwA2cRyV2ql7g3wmigys/d10xG1teJ2grH57is2+pDRdiDpHQBHdn9/4Kz5wSb3ASZGYu1HkkUFGza1gYm/ywVqlZF34k88r71+kKe5GgOQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiYThG/NJR7SM2VmlSBQ3x0BTVaNuCB2pCfegoTA7nlCT3RWEfXaQoSLjSOPgCn2khYFr2sT7qPk4u8ccNORX826eGLRb8Fcteez012a1+IDCWUqrPvPK2XMYWmhl0/V0ec0uG8EhqR2fzot4vAeYmcy04VFTM9tFBJSC5g4Gso=
Received: by 10.114.52.1 with SMTP id z1mr1770610waz.1177178364827;
        Sat, 21 Apr 2007 10:59:24 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sat, 21 Apr 2007 10:59:24 -0700 (PDT)
In-Reply-To: <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45186>

On 4/21/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 4/21/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 4/21/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > > Well, why to store always the full length SHA?
> >
> > When Shawn gets done with full compression the SHAs would get stored
> > in the packfile once  and then be replaced with a token generated from
> > the compression algorithm. Compression tokens are designed to use the
> > minimal number of bits depending on frequency of occurrence.
> >
>
> Currently in Lunux tree there are about 445.424 objects (git
> count-objects -v), if each object has his 40 bytes name it is about
> 20MB to store sha *once*, probably with no real disambiguate need to
> be that much.

You have to store the full SHAs at least once since they are the
signature against data corruption.

> Marco
>


-- 
Jon Smirl
jonsmirl@gmail.com
