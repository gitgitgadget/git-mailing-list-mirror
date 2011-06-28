From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 20:48:33 +0200
Message-ID: <20110628184833.GA385@sherwood.local>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 20:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbdNY-00053Q-ID
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 20:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760179Ab1F1Sth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 14:49:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32949 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760173Ab1F1Ssl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 14:48:41 -0400
Received: by bwd5 with SMTP id 5so420269bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OMgNpom6FRfZh29GKe/rEyjGJ5X2iPJmlpVqPXSsnxo=;
        b=bgHBQq57Rc6pvRrxj4K1vowu6kTvpz391WS/knTJOJDgXVR9AMqMFzOw30Fm0lW5JI
         OSiNofWLML/DDZoP6ls6OAMD189QvyW5/63JN3dNANNzSuieVeo52VnrvR+HOwD9QKO1
         LyYyrEH3oGv2FQRSY/PCPJdMg+fTfrazkeIMs=
Received: by 10.204.16.147 with SMTP id o19mr5576413bka.168.1309286919849;
        Tue, 28 Jun 2011 11:48:39 -0700 (PDT)
Received: from sherwood.local ([82.113.99.172])
        by mx.google.com with ESMTPS id e6sm433393bka.23.2011.06.28.11.48.37
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 11:48:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176415>

@ Junio C Hamano <gitster@pobox.com> wrote (2011-06-28 20:33+0200):
> [..]
> I thought that we try to disable the progress pretty much
> everywhere when we are not talking to a tty[..]

If Tay Ray Chuan would have Cc'd the list, too, i would have
thought he tried to draw attention onto the fact that this is
questionable design, if you allow me this comment.

It would indeed be more logical to simply "peek" onto progress and
let that decide on it's own wether it is useful or possible to
print any progress indication or not.

--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
