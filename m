From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 20:12:20 +0100
Message-ID: <e5bfff550711261112s182d9aa8x79e2fc1a0521f2c7@mail.gmail.com>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	 <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	 <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	 <474AC136.8060906@viscovery.net>
	 <7vy7ckgbpf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Benoit Sigoure" <tsuna@lrde.epita.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 20:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwjNr-0005aR-Tb
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 20:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbXKZTM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbXKZTMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 14:12:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:39082 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbXKZTMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 14:12:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so629252rvb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vX5lwYipRnYLubAtXpWa9UwLxLttVy4Gm4ts3dov4g8=;
        b=XlITyiWK7wrGc2v2PfF3Rg8wboEhHw39Bjt3caaOOYRuOIhKupmcSFEHsiiQ8tW6tLpA9t8Zw2cyV7OlQcNtB4W1atJKGaZxjtRBWYt/8IrWHwk8VwwGnwa5dh2joRHMhYslPcCSW+SFlQdGgyqtOnfoT7HtKtFBasNuXWWB6jc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MOsSgAjfRr9G4hUJXaa7VzIMeRCxTgygnH9A+qoBtj58NSXK4JG6gxdc5goNFMs5eT4gfRCtB5H9O2IZWurxmQvvTFEcuca59aiab65AQvr3W4PgMfwqDwBRVEJNKh8yDAuGiQ8Yza+VDCNIKn+8lnjXdswvFErHiDk6u03LK3I=
Received: by 10.140.207.3 with SMTP id e3mr1371813rvg.1196104340318;
        Mon, 26 Nov 2007 11:12:20 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 26 Nov 2007 11:12:20 -0800 (PST)
In-Reply-To: <7vy7ckgbpf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66093>

On Nov 26, 2007 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> (e.g. GIT_INDEX_FILE, GIT_AUTHOR_NAME).  Does any third party tool like
> qgit already use GITHEAD_${objectname} and/or GIT_REFLOG_ACTION?
>

No, it doesn't.

Thanks for asking ;-)

Marco
