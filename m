From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Diffs "from" working directory
Date: Tue, 22 Nov 2005 10:35:34 +0000
Message-ID: <b0943d9e0511220235kf314b5dy@mail.gmail.com>
References: <200511201817.15780.blaisorblade@yahoo.it>
	 <20051120174359.GA24177@fieldses.org>
	 <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
	 <20051120205855.GA30346@fieldses.org>
	 <4381287F.5080402@citi.umich.edu>
	 <b0943d9e0511211328j7c062c07s@mail.gmail.com>
	 <4382A972.1010801@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 11:37:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeVUz-0003Oh-V3
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 11:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVKVKfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 05:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVKVKfi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 05:35:38 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:54570 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964901AbVKVKfh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 05:35:37 -0500
Received: by xproxy.gmail.com with SMTP id i30so852909wxd
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 02:35:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KOSFhWaH9xXTGNap5EjA+8ce/vFE825wakCUgHcxkbvzN22PnZSeHx3IovGExKU9T+BDX0ubaXUWul0ssCcXBiSpMW9qm/BZK54Ze+DzIZRF1dtAW1S5i2mcaIaJ6qNv+BDGddqLZOFTJ+JfwD6Rc4o921G76iAhT+a4FLDTkWs=
Received: by 10.70.73.20 with SMTP id v20mr3367991wxa;
        Tue, 22 Nov 2005 02:35:34 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Tue, 22 Nov 2005 02:35:34 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <4382A972.1010801@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12542>

On 22/11/05, Chuck Lever <cel@citi.umich.edu> wrote:
> Catalin Marinas wrote:
> > My import command sets the author to the e-mail sender, which was you.
>
> for some reason i was under the impression that it would parse the
> Signed-off-by: fields in the patch description, and take the first one
> as the patch author.

If you import a patch file and don't specify an author (and the patch
is not an e-mail), the first Signed-off-by: line is used. As Linus
mentioned, we could get rid of this assumption entirely and just
report an error if no author information is given.

--
Catalin
