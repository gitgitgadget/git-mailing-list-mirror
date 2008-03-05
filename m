From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed, 5 Mar 2008 10:13:17 +0800
Message-ID: <46dff0320803041813y2d2acfddjb7f973a54e5d64c9@mail.gmail.com>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
	 <alpine.LSU.1.00.0803041608420.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 03:13:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWj8o-0000M1-ET
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 03:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbYCECNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 21:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbYCECNU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 21:13:20 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:61846 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbYCECNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 21:13:19 -0500
Received: by an-out-0708.google.com with SMTP id d31so235324and.103
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 18:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2VRPEPYCOqKSa8xc43k5/GP83vqT2IMT7tKGi/PmqEA=;
        b=WBbqP98UF0foGaLgTiP/IxwE3HJEKXszP9TST5QXwHWQz2pXC3tKK9RGhJYuG1GEohuQSX0YkC8Y6zhVgnp/kQ/iwyCnCwNbVb2KD6NmMlR1pIRNI0kbWWIMcAKL7Tja0E5SyFu78BgC0+nAODz3OUg1e3CjN5QmSKQoQtdg+zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpGih+xNeDAKfngP79Yxvlr95hWtFf5kLGFzX+2N8/iNtE43iCnM81Tjwy0JVEQhqqGIUcdtNp53OZLgcLr2cJbLffobz5n6JlVTPtqJZjUA+VpSM1/cqBNiMKsR2hGweStFvd3VZJ5QmWz34Q6cS8VUZC3j9CDGL9rRhWAAlpU=
Received: by 10.100.241.17 with SMTP id o17mr5193207anh.107.1204683197569;
        Tue, 04 Mar 2008 18:13:17 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Tue, 4 Mar 2008 18:13:17 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803041608420.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76165>

On Wed, Mar 5, 2008 at 12:12 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  In "git remote", we also have a notion of groups.  It looks much nicer,
>  IMO.  So why not do this?
>
>  [submodules]
>         service = crawler search
>         crawler = util imcrawler
>         search = util imsearch
>
Hmm, it seems more brief.
>
>  However, I think that being able to specify submodule groups recursively
>  is only adding to confusion, so I would even prefer this:
>
>  [submodules]
>         service = util imcrawler imsearch
>         crawler = util imcrawler
>         search = util imsearch
>  [...]
>
This is fine when number of modules is not much, or user may feel
inconvenient since they have to type so many module names.
A hierarchy of modules can help much when having a group of common
modules which should be included in most of role-related logical
moduels.
>  Ciao,
>  Dscho
>



-- 
Ping Yin
