From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Syncing a git working tree with Dropbox?
Date: Thu, 14 Jan 2010 13:39:10 +0800
Message-ID: <be6fef0d1001132139p56944cdax22674ca773af0199@mail.gmail.com>
References: <20100113235718.GA7033@dulip>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: chombee <chombee@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:39:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIQO-00073L-CQ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab0ANFjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956Ab0ANFjM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:39:12 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:59429 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0ANFjL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:39:11 -0500
Received: by iwn32 with SMTP id 32so236856iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=b3CfDujr7zCGDLu90wdPjZYSrFUaMb6pUL5qB9RthKg=;
        b=KNO2MaH710RPxmkHzsIEDOg19PTZFztLdWs5x+jg/bPKoLiRZNw4yiqBxtnPmDWKYZ
         IpWZb+XjUuSdGTbhO1rgnxU+lXw3gNNa/IRwFeo7/Qz6jzqGij4h13tEheIvu2W3HF21
         qtxDWiv+yBAG8zaiSRT06xrcse48A56hkkT5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pFkfH7+xRyqh7qIn+meRPDa5axS7SfEIoTjxztufGcJnLmyps+7PXAQEPSjc/osvUw
         xBANVqanaNlRsPKmb5romxpa0vJecsKKM1avOF2nHkGalawvfcwzqZLMkJDoD+ilyrZ8
         6FBVxTvN687ksqWtisVZM2IjLbqY1Lit/kbXg=
Received: by 10.231.120.136 with SMTP id d8mr396667ibr.14.1263447550728; Wed, 
	13 Jan 2010 21:39:10 -0800 (PST)
In-Reply-To: <20100113235718.GA7033@dulip>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136932>

Hi,

On Thu, Jan 14, 2010 at 7:57 AM, chombee <chombee@lavabit.com> wrote:
> My idea is that I keep my .git folder safely outside of my Dropbox
> folder, but my git repository has a detached working tree that is
> located in the Dropbox folder. On machine B it would be the same setup.
> So the two machines each have their own clone of the git repo and these
> are synchronised by git push and git pull with a 'central' remote repo.
> But the two clones share the same working tree, or more accurately their
> working trees are synced by Dropbox.
>
> The working tree is just files, I don't see how it's different from
> Dropbox syncing any other files. Dropbox and git ought not to collide in
> any way. So this should work fine shouldn't it?

Your changes in git (like new commits) won't be synced.

-- 
Cheers,
Ray Chuan
