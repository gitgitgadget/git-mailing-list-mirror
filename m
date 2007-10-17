From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to Import a bitkeeper repo into git - Had a few questions on Qgit; I like the GUI.
Date: Thu, 18 Oct 2007 01:26:21 +0200
Message-ID: <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
	 <47159779.6010502@bluelane.com>
	 <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>
	 <200710171800.37345.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: pete@bluelane.com, piet.delaney@gmail.piet.net,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, "Piet Delaney" <pdelaney@bluelane.com>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiIHe-00056V-Ra
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbXJQX02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbXJQX01
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:26:27 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:57764 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761238AbXJQX00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 19:26:26 -0400
Received: by ag-out-0708.google.com with SMTP id 35so2094206aga
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gs8aIYci2AowxLDxF4XQsm+qxmi71yQqhYcf64f5cF0=;
        b=Namy1+UBYh5D3aqH7ZPAY9qoGeCf3jBYLQnELFzgcBDhf18z9iM/eW8vKCDpomYPwNt2NTZGOCNw+Fb5eWJSIqy+PNRdkqM0tbywofxeMPN3USTQ9fFhtrti1IKFFyFLY8P4yhzwDquXBQ9u3l0OdNASatf2isfuuorKlUs4lWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYfdEfIDUVNezg2Z6GyjOu9409aSXKFgDEoD9Zc53Zp/vHqN9fonzaWByQQKk0pK5/qUpDuDfIqnnPdJg5P+KzDW9esr/Gzc53rEXUEBix9VpUYLqGTDw+nbDTNChF1/Xb+fHewSb4hIUtxBZLnDtI7x395DEkYT5t/qZbDwW0g=
Received: by 10.141.178.5 with SMTP id f5mr4576586rvp.1192663581055;
        Wed, 17 Oct 2007 16:26:21 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Wed, 17 Oct 2007 16:26:21 -0700 (PDT)
In-Reply-To: <200710171800.37345.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61438>

On 10/17/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>
> You could avoid the temporary files if you just pipe the diff to kompare. That
> would require an option to tell qgit that the external viewer can read a git diff.
>
> At the time qgit 1.5 was written, kompare could not handle git diffs.
>

So does the other tools I have checked at that time.

But I don't know if this fixes the problem of slowness reported. A
little test Pete may do is just as I have written in the former email:
try to save the big files that cause troubles where he prefers and run
Kompare on them directly from the command line.

Is kompare faster? If no probably the 'pipe' technique will not solve
the problem and shrinks the applicability of the external diff
launcher to tools that handle diffs directly.

Marco
