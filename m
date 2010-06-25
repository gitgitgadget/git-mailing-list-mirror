From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git-gui and gitk-git as submodules (Re: [RFC PATCH 0/2] Teach "git
 status" the "--ignore-submodules" option)
Date: Fri, 25 Jun 2010 14:01:47 -0500
Message-ID: <20100625190147.GA17493@burratino>
References: <4C24C34B.20403@web.de>
 <7vlja3j7hu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 21:02:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSEAI-00032C-4h
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 21:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab0FYTCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 15:02:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39855 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab0FYTCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 15:02:06 -0400
Received: by wyb38 with SMTP id 38so444897wyb.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=66oVcwZwgtUzxfTFaDn1GDkrP/0VdjWhM0e4p2qdRzM=;
        b=Tfj9RiqlhzG3BIZrjhbV61DQQ7OR8Kd06sngdf1zUJqV8dgPV0Or66zHzHrMvWu+li
         OYEGIdpvuo4A0jSL8QVJWWJvLFWJBQsXDGgyJy1EF7cuL8YG9moSGr+VJ3+HtBS55bQp
         Fw/GfkFRNeEGSW1aWNkeBktIGagYcK6GaPDh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pzLQOtHToWg3kQZTTTTdnwgaIw0ivAciFTlvEXAFSnfEF2R2Sbz4lfKkCADONUYvOf
         sueRdV4k7zc0lDMBcVgpkORAYVImSC5hbDToG7tdvlmcM5P+lAJ3nMqQ/4ws4ckUhg8A
         8J6SxCYORwy3A1HpMSxuielYZ/2vqnrdgAuE0=
Received: by 10.227.145.197 with SMTP id e5mr948172wbv.190.1277492522422;
        Fri, 25 Jun 2010 12:02:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b17sm20335842wbd.7.2010.06.25.12.01.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Jun 2010 12:02:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlja3j7hu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149703>

Junio C Hamano wrote:

> It would be reassuring to hear from
> people who are heavier submodule users than me, though...

Speaking of which, what ever came of the submodule dogfood experiment?
Given a patch to automatically resolve submodule-ejection/subtree-merge
conflicts, do you think a patch series to split off gitk and git-gui
as submodules could live in pu eventually?

Jonathan
