From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 23:08:01 +0800
Message-ID: <46dff0320903240808p5ad287d8j9245ee9f79ff6851@mail.gmail.com>
References: <49C8B159.2040600@gmail.com>
	 <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
	 <49C8E074.4030808@gmail.com>
	 <alpine.DEB.1.00.0903241449200.7493@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Roel Kluin <roel.kluin@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 16:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm8G1-0000Zn-Nl
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 16:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZCXPII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbZCXPIF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 11:08:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:12006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbZCXPIE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 11:08:04 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2340105rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vX2ZNh6m1NUeesxLOwjXU3SVumwOuQi/AJ0TnjYHidM=;
        b=pM1dHh81/w7jyhL6cW66dMgpWt0DllocNI2wTrgsPlml8PEXt2dSN0caHpDpKxOxhS
         w765YXIIkly+dXh0V/a8O2gRjwoP5pn9WB5TXu1qKhKRJNAxhSiPDK0ck2hQDHGFFyfv
         Q/h8b1VIRYkuz5TBoKv1mTvG7EBewtQU3MdlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m8EBC0aGmupVmbvMEj9g1e/aapEdGRowm1eDso+qxKv3mnPovdaPOkTYC032CCzQzR
         geSMjS/iVZR8i94trCAt4XTB/rzZuI/fcdoIEhVsEn/W2QSX9dlCudnPN5VYZbWHZujx
         T7s/gsLUNZeWxvHoSp0wq/WlVjdvpy0nI4nxw=
Received: by 10.114.67.2 with SMTP id p2mr5648015waa.208.1237907281721; Tue, 
	24 Mar 2009 08:08:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903241449200.7493@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114465>

On Tue, Mar 24, 2009 at 9:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> Also, what would be more appropriate for this purpose, I think, is a git
>> sed.
>
> Just as it happens, this is a toy I am working on and off these days...
> strbuf_regsub() is already done, and half the needed code is in my version
> git grep.
>

this is my version

[alias]
sed = !git ls-files --stage | grep ^100 | awk '{print $4}' | xargs sed

Then i can do

git sed -i 's/A/B/g'
