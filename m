From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: What is the pre-merge hook status?
Date: Sun, 19 Oct 2008 10:51:33 +0400
Message-ID: <c6c947f60810182351n444d19bew41f507c04d24fdd0@mail.gmail.com>
References: <c6c947f60810172342n6843b173tb0019d0af706800d@mail.gmail.com>
	 <48FA5BBB.8060406@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paolo Bonzini" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 19 08:59:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrSFl-00082c-K7
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 08:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbYJSGvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 02:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbYJSGvf
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 02:51:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:52830 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbYJSGve (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 02:51:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1293862rvb.1
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7LE0SY9yNmP/zumM/ezxcdHfbEwt4pxymUNUovXFPTw=;
        b=PGfpEP6i6e2znbhVNNgF1Jymm+2z7T4K1qmUvwxvXmyNZikiLpMa+U0oD03/6dHhOe
         EJ/SE1K7L1xX5OJLw41tU7Ik39dCanpaNoEBK2oFC+sQBtF+X3cwKi4ccqTgBxT/ojUX
         jzC1gwHYM1pSifmJxk8QcVwHBUyKiwMihCHmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u5TI1XBrsVOIo3Bk0mwKg25aUoHjj7hs6JFrQgAh2Lu+nDLgyIPJv7YqPxlUphmuPf
         l4N/SktX2SVWhqoDJS/XX83v5I4B3kf0S5TBE9Bk5gjlZGVO1fWmGvbdz0zrWyIVBXKX
         jz965UOozOdlbbwdvS8lWEcDILsPVUZcqJmdA=
Received: by 10.141.197.21 with SMTP id z21mr3846431rvp.91.1224399093698;
        Sat, 18 Oct 2008 23:51:33 -0700 (PDT)
Received: by 10.140.188.5 with HTTP; Sat, 18 Oct 2008 23:51:33 -0700 (PDT)
In-Reply-To: <48FA5BBB.8060406@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98595>

On Sun, Oct 19, 2008 at 1:57 AM, Paolo Bonzini <bonzini@gnu.org> wrote:
> > What is the status of your pre-merge hook patch?
> >
> > http://article.gmane.org/gmane.comp.version-control.git/93888
> >
> > I think it can help me greatly with my repository management process.
>
> I decided that it was a bad design for me at least, because the control
> had better be implemented on the server (using an update hook).  But I
> can submit it if you need it for something.

Please do. I've found that things in newbie user repo may become way
too entangled before branch gets to server. My users need an
early-warning system.

Thanks,
Alexander.
