From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2009, #03; Wed, 15)
Date: Thu, 16 Apr 2009 10:20:27 -0500
Message-ID: <b4087cc50904160820t58534dbk3e4219c1713676ac@mail.gmail.com>
References: <7v1vrtno9z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:23:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuTQ1-0003x2-08
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 17:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbZDPPUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2009 11:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757432AbZDPPUc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 11:20:32 -0400
Received: from mail-qy0-f111.google.com ([209.85.221.111]:50942 "EHLO
	mail-qy0-f111.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757442AbZDPPUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2009 11:20:30 -0400
Received: by qyk9 with SMTP id 9so822979qyk.4
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kqFtjfVwbJMwXmi/XQx2UzkZvvUoImbph3b/y/7hYCI=;
        b=U1uiHs8WtPNXk7F46vFLVabhCJYX/zZzM0z0yGWACNv0UHRpIJEooSg7R7zAnCJtfB
         zcuOyb7TWDDBuTC+Cnmap20y7Wo+HSaC0xWBGt7le3vWQsuNfYFMNEEKfRRegUCC7QI7
         m0tGlDhT3Fib9v98AjJtQq9Et05S8EUt8KwEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=teKHEAvfMRZZ3n3lq+0+zImKeGWpR+FCkkNr7cyc4WBZsNWyYQ7TIvzjd0NHK7YO8r
         vPnvBKsLRrNCAlHzt5TJ30Q83asLjEgIDmpE2QGdbde1uWPNodFYoQ8oknVouAhiilJA
         KnCVHjtQFVoyfxxGcxRMl8WzSE511x87dDGRo=
Received: by 10.224.54.83 with SMTP id p19mr1881025qag.130.1239895227425; Thu, 
	16 Apr 2009 08:20:27 -0700 (PDT)
In-Reply-To: <7v1vrtno9z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116707>

On Thu, Apr 16, 2009 at 00:47, Junio C Hamano <gitster@pobox.com> wrote=
:
> =A0- Docs: send-email: --smtp-server-port can take symbolic ports

I've done a little more reading, and I think that 'service names' is
better than 'symbolic ports'. Also, the text you added, '(e.g.
"submission" instead of 465)', should probably be '(e.g. submission
instead of 587)' in order to match up with IANA's mappings.

I've got another patch in which these changes are a part, so you can
just leave things as is and let the next patch fix them up.
