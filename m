From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Improved git-gui blame viewer
Date: Tue, 5 Jun 2007 12:36:49 +0200
Message-ID: <81b0412b0706050336nc610ea7t98797504ef25cfc@mail.gmail.com>
References: <20070602041723.GD7044@spearce.org>
	 <81b0412b0706040910w1894770bm593e0e54fbb3c44@mail.gmail.com>
	 <20070605043824.GB9513@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWPJ-0007Y8-Op
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763601AbXFEKgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763656AbXFEKgv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:36:51 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:6814 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763601AbXFEKgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:36:50 -0400
Received: by hu-out-0506.google.com with SMTP id 19so695499hue
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 03:36:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3qnuDlya5WLUYF6HmOZWGVx4ZoDlIRBGNYj1UbcV5YvGEJ/ne1bnCVxgKR5CFwqMhHXlcqIBWWvwfTfndhkbA6bKNI8I0bZ6ZzamLTPYUh2AXoFmtxTOBNW9HE1xzKc0xOpNFS/9YYzSR4tUNnbgm5RWDoZ3Xhr60sx4t7/WQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z3DqrlIkZzbsB3o0TSLXAgYPXICq26fskq+uapl+SoAKBPj/0ANbZDRh6FNMnHQCEK5bJ013V/0032/Wets4WmSuM3m+k6tExDwwKzcpWaf/RlDX0nH2g4YaonZ1nrRI6OVxzegngHLmv2d0fTCd7eGu+7NosqTnL4D3BUY+SAs=
Received: by 10.78.200.20 with SMTP id x20mr2379676huf.1181039809088;
        Tue, 05 Jun 2007 03:36:49 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 5 Jun 2007 03:36:49 -0700 (PDT)
In-Reply-To: <20070605043824.GB9513@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49188>

On 6/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Don't we use git-config to edit the config file in git-branch?

Not routinely. Seldom, even

> In git-remote?  git-gui has *always* used git-config to store
> its data.  You are sort of asking me to replace a working config
> system with a new one that hasn't been tested...

Just divert the data someplace else.

> Now moving the git-gui config to say ~/.gitgui-config and
> .git/gitgui-config may have a good argument, as then git-gui
> is editing its own files.

Good argument on its own

>  Unless the user changes user.name
> or user.email through git-gui, in which case we have to edit
> .git/config or ~/.gitconfig anyway...

Yes, then of course (in this case the user is even aware).
