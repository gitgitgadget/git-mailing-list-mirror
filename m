From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [RFC PATCH] Re: git add -p: new "quit" command at the prompt.
Date: Sun, 12 Apr 2009 19:29:36 +0200
Message-ID: <20090412172936.GA12909@vidovic>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr> <7vws9rdmgd.fsf@gitster.siamese.dyndns.org> <vpqfxgevy58.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Apr 12 19:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt3WX-0000ML-H8
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 19:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbZDLR3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 13:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZDLR3m
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 13:29:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:56618 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZDLR3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 13:29:41 -0400
Received: by fxm2 with SMTP id 2so1745429fxm.37
        for <git@vger.kernel.org>; Sun, 12 Apr 2009 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=6bZrquPy0zKlBh2andcWLHeUo66bwFf4Xf2LDA4Kzb8=;
        b=qlM1SDVvxa52lNIyIzmOTOhU6lgD5zQfWxg+Q6cBV7syLKq7/Hsh7NJaSnqAQN2NxI
         PVF/NVpisXpgQ1KpQ8RBQ5RneRjvlGJjNsXzhpMTVPWb7NlZdfjN+aUY2yVgR5E97kFJ
         L0+5bq7txyO1GFwCl607EkKH5cGLG0jWPST6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QZ11uTLsmwu3hkD4TDdFW0UCadKcoiEWi1iP2zk36R3gmVblcw1568KuNI0NifLtrT
         fv4x0HMc3NZrql0AeR+AknAql+JRy6CHujIg/p2W7Kc0fEtUI8h2/MwYmEg1s/GfslOx
         Z90bs2zuXaIna0gVulQThgCBCDcYUwBLjES6Y=
Received: by 10.86.27.19 with SMTP id a19mr643550fga.58.1239557379816;
        Sun, 12 Apr 2009 10:29:39 -0700 (PDT)
Received: from @ (91-164-145-233.rev.libertysurf.net [91.164.145.233])
        by mx.google.com with ESMTPS id 4sm5818878fge.3.2009.04.12.10.29.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Apr 2009 10:29:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqfxgevy58.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116383>

On Sun, Apr 12, 2009 at 02:45:23PM +0200, Matthieu Moy wrote:

> I thought the situation was common enough to deserve an explicit
> command. The 'd' command is natural for "git add -i" + patch
> subcommand, but for "git add -p", I found 'd' mostly useless, and I
> really want a "quit" command.
> 
> Sure, I can live without it, but if other people would like to have
> it, please speak now ;-).

Acked-by: Nicolas Sebrecht <nicolas.s-dev@laposte.net>

-- 
Nicolas Sebrecht
