From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation/git-pull: clarify configuration
Date: Thu, 11 Nov 2010 02:31:25 -0600
Message-ID: <20101111083124.GB15525@burratino>
References: <1289373188-32543-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7voc9xhyfx.fsf@alter.siamese.dyndns.org>
 <AANLkTikT4N5JAxRxPCbx=xAokRKOvvxDQ4pAC9CcpObB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 09:31:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGSZV-0001uC-JC
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 09:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082Ab0KKIbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 03:31:48 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52772 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab0KKIbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 03:31:47 -0500
Received: by yxk30 with SMTP id 30so228983yxk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 00:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c+33xLCRGuUY7YWZhwKXPxSen1huIG3NKho2NPcR50g=;
        b=EdkSXZ2PlwsyQVQPok4cb/8MY8DDOQtccS2CWicDiKPX+FeOLBivBfV8Jw7oNLPB3d
         rBirJoji8F51xfHzO3VCLXMrS1tDtZJG7VpMUBVJ/CW5GaPg/j0CHNtxMVlXJHB1T4pf
         1zn/4PbkF8llDxLdvSUqJJi5W+lzHcia6qXP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pGiChlt05PQMN/shmiZmTXRISXbx6KTDLe7UInVIPqyGYxVEQEYjOpTMrAUizWEZj7
         wJqggqx5U+kzKCw4yiNkqiOqZ50jiKR+sMJYpyVNbm+fu3D/bturlPE6oUfQAZ19SzPQ
         ffnwuOa9O5GvJ1kUzIAt2B185XquTdTioWAwo=
Received: by 10.91.45.39 with SMTP id x39mr1057781agj.79.1289464306985;
        Thu, 11 Nov 2010 00:31:46 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 68sm1322914yhl.3.2010.11.11.00.31.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 00:31:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikT4N5JAxRxPCbx=xAokRKOvvxDQ4pAC9CcpObB@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161218>

Martin von Zweigbergk wrote:

>                                           I happened to spot a similar
> problem in the documentation for 'git rebase -s'. It currently says "Use
> the given merge strategy. If there is no -s option git merge-recursive
> is used instead. This implies --merge." and I assume the last sentence
> refers to the first one in this case too. Same question here: Should I
> send a patch?

Yes, please!

In general, carefully written patches that improve the documentation
are always welcome.  (And sloppy patches are not so bad, either.)
