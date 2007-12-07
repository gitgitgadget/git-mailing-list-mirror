From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 21:36:38 +0100
Message-ID: <e5bfff550712071236t26fe77cchf75ca64adf6a33@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Dec 07 21:37:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0jwV-0004aY-GS
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 21:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbXLGUgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 15:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbXLGUgk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 15:36:40 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:24178 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbXLGUgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 15:36:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so812553rvb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HTbJpNum8sl2SgZsySG35J8yMf9+/z3uaduv2NOesS8=;
        b=XvQr+U958BrlJOFxvWaZp4RuAO8pyIWz6wKVMPqIaDdprBzNqY1eorn2ZN1f3h80q6m0C+CS4pv27geUeIplgF3X+8mm9feb/oWmACJr5t3/UqVbf8zrtB10vGPlo5N7KZM1ThA1ZEkoq8CKo2z2BkdMHH4gmrfbW0hcji7sr+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UBsnI/7Xl7HmD/8BjpbKy9uOsngD2cT/13J6Vn3AgsnTjHt40XNL9TRZr9lqNTxfbttwTQZm2dDDK8AyMb9wgmSK4S1GaVhxuw1CL3ylIG7g3Dgcrk5WO189j1wpjh7K/r5TsrhTv8i4cZVGXymFTFum5vyJA/c6BTe5yDZxukk=
Received: by 10.140.169.6 with SMTP id r6mr2921302rve.1197059798337;
        Fri, 07 Dec 2007 12:36:38 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 7 Dec 2007 12:36:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67454>

On Dec 7, 2007 10:24 PM,  <david@lang.hm> wrote:
> On Fri, 7 Dec 2007, Jon Smirl wrote:
>
> keep in mind that that 330MB file is _very_ heavily compressed. the simple
> zlib compression is probably getting you 10:1 or 20:1 compression and the
> delta compression is a significant multiplier on top of that.
>

If the delta is good the zlib is poor and the contrary stands too.

It is very difficult to _guess_ in this cases.

Marco
