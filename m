From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 12:30:47 +0200
Message-ID: <fabb9a1e0904100330u61a7e252he546f0edc4e016a7@mail.gmail.com>
References: <loom.20090410T084314-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Digulla <digulla@hepe.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 12:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsE2x-0002sG-3S
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 12:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbZDJKbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 06:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbZDJKbH
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 06:31:07 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33787 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbZDJKbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 06:31:06 -0400
Received: by fxm2 with SMTP id 2so987103fxm.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pjR/kpD13yye764aSsVpFAvyUTXyioWO7ikD4M9U7wU=;
        b=LNqigJW9TrbiXCs+APAycrA7dNFWDji0ayO8MKROzcCmqE5SA9Bc4busC93tp9mQKv
         7ure81zBnMYisNGL5t2Vt+RPpxvKChBQE2+DGl1gKcUM3wMFzECMZyZZg3siX4gM0bDc
         HLWZG5urbsy450ENvhO9RmXN/SF4xwi9PMt2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YwjmgDEWq1llsz7HwaRY21tKhhaAWgiUbun+uACX4vrt4k9zgv6hXIDQ6BKyXZXEdG
         z+l2NMoyxauugP0zh+bsCRuRvD6JT8R68Zqkn4yZoWPLirCwEBuv3a56nqQ7YA5wwBnO
         JX2P0eNyL2vAiDwU0gwSrZ98WbeQnMX0vHxus=
Received: by 10.103.168.5 with SMTP id v5mr1774906muo.77.1239359462399; Fri, 
	10 Apr 2009 03:31:02 -0700 (PDT)
In-Reply-To: <loom.20090410T084314-918@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116251>

Heya,

On Fri, Apr 10, 2009 at 10:49, Aaron Digulla <digulla@hepe.com> wrote:
> I need a way to safely synchronize data between several places using an unsafe
> storage (USB stick, Internet drive). So my question is: How much work would it
> be to patch GIT to encrypt all files in the repository using AES-256?

Encrypt the entire drive flash drive [0], and then use git like
normal, 0 changes required ;). You can also create an encrypted file,
and then use git like normal, also 0 changes required!

[0] http://www.truecrypt.org/

-- 
Cheers,

Sverre Rabbelier
