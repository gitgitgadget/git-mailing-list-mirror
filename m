From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/3] git-remote-fd
Date: Mon, 4 Oct 2010 06:25:56 -0500
Message-ID: <20101004112556.GD4738@burratino>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286190258-12724-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 04 13:29:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2jEL-0006pj-K2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 13:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab0JDL3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 07:29:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41060 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab0JDL3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 07:29:11 -0400
Received: by iwn5 with SMTP id 5so6805496iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 04:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LtreZG8OltZ2W0UAMuCS47TZDiyoJ6kLZuMrGtYm55E=;
        b=NWJGCwL416Hf+lla4TYgYNkZRDGw1fIr65vb5RxZ/BulOjOA34xVQk+IITqdHN20DL
         KLt8nTgxv1rP//vY3ODUTCfGZCnY+QTlbqvOCSs4W6hqPheAiI3kDnzE/TayMh3MzUgt
         iudAXX8qYqBXoYEgpHCJnFGUd8EMddNiXQT8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZtAYDnLx6QEc8vOLIM+xqnysEfFrlmEfBi3F99uB9JPeGKNdJ2BR32cZ2wzdNTjOru
         Cs30AINcmVY6z68ktvjHbHITRpir1hbs71xt0srH/lq6PFSdE54fH5FzLWcek4nky1z9
         xwX0ZkJpGYFEeWcNioMRrYleGPp2mpDF5K7fM=
Received: by 10.231.15.203 with SMTP id l11mr9926178iba.182.1286191751037;
        Mon, 04 Oct 2010 04:29:11 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm4855254ibk.21.2010.10.04.04.29.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 04:29:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286190258-12724-3-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158032>

Ilari Liusvaara wrote:

> --- /dev/null
> +++ b/Documentation/git-remote-fd.txt

Much clearer.  The synopsis still does not make me happy; the synopsis
I suggested did not make me happy, either.  Some section headers still
have trailing colons but I'm not convinced that's worth the overhead
to fix.

> --- /dev/null
> +++ b/builtin/remote-fd.c

Looks good.  Probably input_fd and output_fd should be static ---
Junio, can you fix that up?  And now that the documentation makes it
clear this is only for fetch, push, and archive, I guess I am not so
worried about the interface any more.
