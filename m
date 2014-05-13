From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 17:22:25 -0500
Message-ID: <53729b2150a84_34aa9e5304e0@nysa.notmuch>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLGI-0003iW-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbaEMWdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:33:23 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:32952 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbaEMWdW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:33:22 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so1183419obc.4
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GiYy7T3vMhnMRSPYUZRQCJ9O3+DS1/Dr210L1eHmY6U=;
        b=NeciG02iQuRzHIPrQ18rbxQHX7WW/y77KRi5ckGOLOrNAa8AFTXyIZ40L1W8X+wMyX
         jU2Ymj5d7gy3eeJqHimP01eJmPyYlrzHV3efqIGpRqiGBOhEKAwVh3rVv7+LWgAzKJ35
         f8TVBsI0NN5AKfZI37i5mXg15Zd6XvVQ4NxKtrZqrE7SVH7IE8sioAhwQI9QHiCXJwMU
         XEBdQK1+vcG45eWS8OMessWes2lCRqalazvOk7yAcE4QwahYcUzMsy3auwYrZNsKHIgQ
         ElWvUn/UWdeEpnFCpgss5wYVIylE90slliiFIjgz2QDDZnLqnYbLK+/Czra5XeE+SMgj
         ShSA==
X-Received: by 10.182.5.65 with SMTP id q1mr6390200obq.74.1400020401619;
        Tue, 13 May 2014 15:33:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w8sm55339638oel.14.2014.05.13.15.33.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 15:33:21 -0700 (PDT)
In-Reply-To: <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248875>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The tools are now maintained out-of-tree, and they have a regression in
> > v2.0.
> 
> You seem not to understand at all what a regression is.
> 
> My understanding is that versions of remote-hg shipped with all
> versions of Git did not work with Hg 3.0, so not working with Hg 3.0
> is a regression in v2.0 at all.

I explained to you multiple times already that is a different issue, but
it somehow doesn't get through your skull.

Let me try a different approach.

git-remote-bzr has a regression in Git v2.0.

Did you get the BAZAAR part? That's right, this is unrelated to
Mercurial v3.0 because it doesn't have anything to do with Mercurial.

*BOTH* git-remote-hg and git-remote-bzr have a regression in Git v2.0.

> A recent report was about Hg 3.0 not working with 1.9.3, but I think
> you earlier said all versions of Git does not work with Hg 3.0, and I
> can believe it.  That is hardly a regression.
> 
> You could argue that Hg has a new regression to its external users
> of its API when it went to 3.0.  We actually had a similar breakage
> in 1.5.4, where it was reported late in the cycle after -rc0 [*1*]
> that cgit that linked with our internal API libgit.a was broken by a
> change on our side, which resulted in us fixing the breakage (even
> though technically you may be able to say that it was cgit's fault
> to link with libgit.a in the first place) with 18125644 (Move
> sha1_file_to_archive into libgit, 2008-01-14) very late in the
> cycle.  Calling that a regression in cgit would have been insane,
> even if we did not patch our side up to accomodate it.
> 
> Stop this idiocy.

Sigh, you just don't seem to understand that you are thinking about a
different issue. I don't think there's any other way I can explain it to
you.

-- 
Felipe Contreras
