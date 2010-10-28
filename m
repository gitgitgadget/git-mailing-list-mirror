From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] Replace "remote tracking" with "remote-tracking"
Date: Thu, 28 Oct 2010 14:52:28 -0500
Message-ID: <20101028195228.GA16006@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYWj-0002AW-5G
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0J1Twi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 15:52:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59681 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0J1Twh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:52:37 -0400
Received: by fxm16 with SMTP id 16so2304180fxm.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=w7xv/IrYLhfpzgt6T/YvZqNr3Iw/1nsX3+5c+C6YK7o=;
        b=SG4V0peqkVdiERIOtw3dtB6Y33HPZZFmH5F+LbaeKkgr95tmm+aizbeb9cK7YyP139
         vs3RHUusLiLCtDMMRd3MfRJK/sE9LxIF7fawiW5aLuloJwHXhH5jCIwwDgDxdJibvMVC
         wwPBPZ6Swea9wXNFZnET4oH8oQqXhXVbvbBzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XyjqLuEja8XDEDcG1xy7kXa2mvPVchUmtyk5Xmbp5FDBZ5aojKknod6KvJ/b4Hv+oO
         x04HTj3soUavkjfCeMIf2YzOjadroD6oBwnJha5c45q/K9/BLNjOFvFycoWsIUkVx278
         F9xzKNYc4DYFvBa7Jr14d12/d7arSCcdUdZv0=
Received: by 10.223.96.15 with SMTP id f15mr4341411fan.10.1288295555720;
        Thu, 28 Oct 2010 12:52:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j8sm687868fah.6.2010.10.28.12.52.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 12:52:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-3-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160216>

Matthieu Moy wrote:

> "remote-tracking" branch makes it explicit that the branch is "tracking a
> remote", as opposed to "remote, and tracking something".

Yeah.

[...]
> This patch is a straightforward application of
> 
>   perl -pi -e 's/remote tracking branch/remote-tracking branch/'

Thanks, that makes it very easy to review.  The patch is obviously good.
