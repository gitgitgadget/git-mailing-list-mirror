From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] Remplace "remote tracking" with "remote-tracking"
Date: Sat, 23 Oct 2010 13:31:20 -0500
Message-ID: <20101023183120.GF21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:35:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9iw5-0004au-5M
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123Ab0JWSfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:35:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59475 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563Ab0JWSfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:35:11 -0400
Received: by gyg4 with SMTP id 4so1341500gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K6wWO9JxO8+hSBZMM4ZWG3OiTaa3oO6pShi+6qLWkFU=;
        b=AqYSURRNgEaDwanuECNKz/ykFQPcWPzxBwnUu0Rie7eEEBDMkjXICWayl+PcHKTw4S
         o7XWHpe4enUSCNud1MUG6nEylDbV7yKGESkFllqI5EIp3/HdZEvgHscFsuikh1Et6upm
         3DmgEnK218f4794jeKhj57BeaiqLRTwNXALVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U4xVs74ch511YeDYskO2T4shHdYi8PkIIX+dPKZqXUuyHMPXIwRkSQaqdCpm2Mz4DO
         XrMtjOSCgm2U38oMeiYylPkmihru5GIwOkyANHG9K1jE7E+qnevdU4qGU9BnImLissVw
         xgALKAfdxApVxvxbCeQYM12Augr0Wznq9dPV0=
Received: by 10.150.195.8 with SMTP id s8mr6313621ybf.408.1287858910502;
        Sat, 23 Oct 2010 11:35:10 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w15sm5600175anw.33.2010.10.23.11.35.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:35:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-3-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159807>

Matthieu Moy wrote:

> [Subject: [PATCH 02/10] Remplace "remote tracking" with "remote-tracking"]

I think this should say "Replace".

> "remote-tracking" branch makes it explicit that the branch is "tracking a
> remote", as opposed to "remote, and tracking something".

All changes in this patch look good to me, for what it's worth.
