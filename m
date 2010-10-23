From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/10] Remplace "remote tracking" with "remote-tracking"
Date: Sat, 23 Oct 2010 13:16:50 -0500
Message-ID: <20101023181650.GB21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:14:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jXn-0001qF-KD
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926Ab0JWTOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:14:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54109 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916Ab0JWTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:14:10 -0400
Received: by gyg4 with SMTP id 4so1350686gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UYpUUIJ2ltQ+uQCTRCPzcOJhVqhjZDahkpzTXhP/PD8=;
        b=RQ3QTU9IvQ1qAbPQK95mjgmYWESJ0D0JgrQeJQVeICh8u4qFonkJKDG4H21LYvPCej
         9qGxIb4InHMkZuTXk3pvqS8ogEV/UMkpXhI/SICRBzZMlONaA7oZ57Ivgk/kSonAERzM
         lTP5Ow3mmulqyk23z61HNb4VHxZdPpXmKcJjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WJ5a6qdMcl8AwEgpL1pKpoYw7hKMrqrhswdz6Sla5ioB56IGqD76TzNIbsyXk1hIR7
         SHhfbXYEKFgFAlxdPvyFCYs6izVvYMu/wfzm50wwEnYjgqWUrO1p9AA7+5/0x3UkfMuM
         2xEX9hJytnp/9UydQY1ACWyRg2oKLB9HHwH4w=
Received: by 10.100.205.15 with SMTP id c15mr3619986ang.215.1287858366362;
        Sat, 23 Oct 2010 11:26:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d15sm5589060ana.20.2010.10.23.11.20.39
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:20:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-3-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159820>

Matthieu Moy wrote:

> [Subject: [PATCH 02/10] Remplace "remote tracking" with "remote-tracking"]

I think you mean "Replace". :)

> "remote-tracking" branch makes it explicit that the branch is "tracking a
> remote", as opposed to "remote, and tracking something".

All changes in this patch look good to me, for what it's worth.
