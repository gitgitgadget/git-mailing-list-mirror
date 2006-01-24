From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 24 Jan 2006 21:23:05 +0000
Message-ID: <b0943d9e0601241323u3cf6fbfbk@mail.gmail.com>
References: <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth>
	 <1137631749.13853.22.camel@dv> <20060119213838.GA27397@nowhere.earth>
	 <1137738224.27911.26.camel@dv> <20060120182255.GD32177@fieldses.org>
	 <1138080623.15105.51.camel@dv> <20060124175443.GA29670@fieldses.org>
	 <1138126671.24415.28.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>,
	Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1Vd9-0003e1-Ex
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 22:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWAXVXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 16:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWAXVXI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 16:23:08 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:64320 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750733AbWAXVXH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 16:23:07 -0500
Received: by xproxy.gmail.com with SMTP id i30so855402wxd
        for <git@vger.kernel.org>; Tue, 24 Jan 2006 13:23:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aCl1fOJX7iLZa2JWGUidzWCK8u1Uc24mn0ck3Fj8+/362u0yqc2Li6N3aZgblC8B2NAKAGLy/hCHRAnauTLZwFNN1/eOuX4Z/EHTMTHGSeu1gwJ48SSIEDgHsbnvr1X39RmLU6p0WFuV9PG/n1zMR7lbVak6GxCanmr5pQnzmy0=
Received: by 10.70.126.14 with SMTP id y14mr7867872wxc;
        Tue, 24 Jan 2006 13:23:05 -0800 (PST)
Received: by 10.70.54.19 with HTTP; Tue, 24 Jan 2006 13:23:05 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1138126671.24415.28.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15106>

On 24/01/06, Pavel Roskin <proski@gnu.org> wrote:
> Seriously, it would be nice to have an editor that would allow to edit
> the patch and see the resulting file and vice versa.  Maybe emacs could
> be hacked to do it.

I think emacs has some basic support via ediff-merge or smerge but
it's difficult to integrate it with StGIT. Refreshing a patch with
StGIT means updating the GIT index files with the latest changes in
the working directory, save the index and create a commit object
pointing to it.

--
Catalin
