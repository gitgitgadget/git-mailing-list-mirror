From: "Pat Maddox" <pergesu@gmail.com>
Subject: Re: Updating submodules
Date: Sat, 5 Apr 2008 16:08:04 -0700
Message-ID: <810a540e0804051608s6b6580a3vd4bf9ae04c22f3d4@mail.gmail.com>
References: <810a540e0804051546o250bd3e7mf7a20d8f1cc6dcfc@mail.gmail.com>
	 <32541b130804051601w4f7976cawde47a70e04790511@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 01:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiHVP-00061b-Mm
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 01:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbYDEXII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbYDEXIH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 19:08:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:34309 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbYDEXIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 19:08:05 -0400
Received: by wr-out-0506.google.com with SMTP id c48so569698wra.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wOB1ALtkUAP4Gh39Dm8L67p6CjPQvAPA88OyOTPD7PA=;
        b=XsE8n1GfMk77uY6zI63K351ga2pdH+JaayN5WgnOUOoB7JmSvJfcDZ2iKMsiNkEN7M7I1R+d1PS7SP8X7sSUX4LubsLnLgphfNvNtGF+47jS7lNM5olNJxPrPDOopcU9nKU15WcEYWp4SYm55Zp6oPpHRapRoMg6civGdU7IAv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M/qU1Vx46zp/tSviJCQKbmzoRlFpVodSF4S9ePs5axHLj8AdW9AovJJn3ZC5xwooA1qNcxn3a5qPZGXHebZGsXeRQBEqhK60NMvQ9jEqPUJ5UF8sQc+XYpqxRenx5w2Nz1Ov24eneaWEwZ+NStYKw0Du8MMxupXgvhpjwrCqh2A=
Received: by 10.114.145.13 with SMTP id s13mr1156131wad.178.1207436884329;
        Sat, 05 Apr 2008 16:08:04 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Sat, 5 Apr 2008 16:08:04 -0700 (PDT)
In-Reply-To: <32541b130804051601w4f7976cawde47a70e04790511@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78866>

On Sat, Apr 5, 2008 at 4:01 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>
> On 4/5/08, Pat Maddox <pergesu@gmail.com> wrote:
>  > Do I need to cd into each submodule dir and fetch/rebase?  git
>  >  submodule update doesn't seem to do anything, though I would assume
>  >  it's used to update the submodules...
>
>  "git submodule update" updates each submodule to the version that was
>  checked into the supermodule.  It doesn't do anything like fetch,
>  rebase, or pull.

Okay.  So I've got a parent repo with three submodules.  I've been
working in one submodule and have been committing changes.  Now I
wanted to get the latest changes upstream...I have to rebase that repo
individually, right?

Pat
