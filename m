From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 13:10:45 -0500
Message-ID: <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes> <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes> <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino> <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 20:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7uB4-0007nn-0t
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 20:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611Ab0JRSLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 14:11:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44523 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab0JRSLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 14:11:07 -0400
Received: by gxk21 with SMTP id 21so194098gxk.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=MzXJX0cDvYaP8i/X6xHIaZksMbTBvPuvBHDStiI50i4=;
        b=lV7DnVCmsxXrEX2tnMng09VeblapB6j5hKF73vkT5wGW37dU8GQOE+hbq91toTXOXp
         h/LdrOnkx7a48kIHgfRZo1HHqXEXs7MtKlK4meKRx+u0Z9ib59/KzZ03Q0DczAFpitFl
         DNk1/Uy+wuLrltu57GbbJAafCL38Fy1h2BNaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Ds1V9IVrqSCLLf3tnQ+F0Er7RLGVPyr0Eny7l3wKgJPaG3M8S1ygAA9ambrPbdnSBH
         4R3uroXVdpdUx88Pjem68bKEGU3wwOkIczL+qd62czt6xGGYVc0W1wOgblqQ/ajq6DEF
         J3L9fT8kWfdqdTYQ7QSdJPC3J7e4cXDPMJdVE=
Received: by 10.151.10.12 with SMTP id n12mr7322627ybi.148.1287425466195; Mon,
 18 Oct 2010 11:11:06 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Mon, 18 Oct 2010 11:10:45 -0700 (PDT)
In-Reply-To: <20101018172810.GA6877@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159274>

Heya,

On Mon, Oct 18, 2010 at 12:28, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I mean that rejecting a fetch because upstream has weird history
> would make no one happy.

Agreed. What about when the remote's history is rewritten, do we want
to just transplant the new history, or do we do a forced update of the
remote?

-- 
Cheers,

Sverre Rabbelier
