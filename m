From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] don't append 'opaquelocktoken:' in PUT and MOVE
Date: Sun, 8 Feb 2009 02:38:39 +0800
Message-ID: <be6fef0d0902071038y3e6de33es33a73ab6a068f9ac@mail.gmail.com>
References: <498DA4F9.20104@gmail.com>
	 <alpine.DEB.1.00.0902071801570.10279@pacific.mpi-cbg.de>
	 <be6fef0d0902070952l5818e4b7x3048c667661ce31@mail.gmail.com>
	 <alpine.DEB.1.00.0902071903020.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVs9D-0005Ta-Sl
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 19:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbZBGSil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 13:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZBGSil
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 13:38:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:10381 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbZBGSik (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 13:38:40 -0500
Received: by wa-out-1112.google.com with SMTP id v33so625603wah.21
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1ZmrOhUIu7Jxd0uQgmSDusQOKrFDfg4AJ/HNrkC3Jzk=;
        b=ZpfzUvz8K5+zFyQ6iETtnluuVpmryNrmfl++BsbzvL+A0jv1a0r+ibOT8fD+lapTjm
         QR8VJHrZngj+Tmy78PvSAx4xg8H0M8R7cI86dkj+6IqFbRjMNuKy5EFMDURczbJ61ABE
         Qk9a+3Jv7aHN4RgSAbl/qT2uiVa4jG9/jtZfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VK8+pIwQNJP1kFaaKEwn/hR3WL9EXw/UUTy3Bv+wOcj49X0u4matBUHib2T0jds8Ci
         ye5sEVcvjNRtpO/MEq5LP9ufkQohxqbaatjJuJe+G9bFnD18HyRon9qudrrS2djAkTRz
         Ag3BxAYfsGPaf/Yc3gSPMeizifou8SveVzJt8=
Received: by 10.115.16.1 with SMTP id t1mr2217180wai.58.1234031919369; Sat, 07 
	Feb 2009 10:38:39 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902071903020.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108873>

Hi,

On Sun, Feb 8, 2009 at 2:04 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Why does request->lock->token have the prefix at all?

While typing my reply, I realise it is unwarranted.

Thanks for taking the time to look through this.

-- 
Cheers,
Ray Chuan
