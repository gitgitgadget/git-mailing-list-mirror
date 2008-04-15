From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules
Date: Tue, 15 Apr 2008 10:13:51 +0800
Message-ID: <46dff0320804141913r5585ed9cr25fa3bdae3c2d5a@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
	 <1207859579.13123.306.camel@work.sfbay.sun.com>
	 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
	 <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
	 <1207970038.10408.8.camel@ginkgo>
	 <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org>
	 <1208202740.25663.69.camel@work.sfbay.sun.com>
	 <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 04:14:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlagw-0002ZK-0f
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 04:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949AbYDOCNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 22:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760724AbYDOCNx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 22:13:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:59358 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758503AbYDOCNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 22:13:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1356028wxd.4
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xsEyQyiqctiZ1Zz7Xd1TGWfx8LxrzntDMi1Ionh3BDs=;
        b=fYXG9FT0vxyU4UtfpQM/bSMq7Gzy62p47o/5/I6OyNAIZG9Xbe3bKTWkSrSTP4r9xOrQUzmmR94KCcFbhMJviNvc+zJMxB0hCmP+ezZTlb0IHa8Hl9IFrzrh1vVq719t8i6BwC5UDkQxqENFQpHCqpnV2a5U8HRp5KGZ7NOlcLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tX0Gp3mIa3HKHFK2UYWRj8sAoOtCHedY71HhiJAEJ3b2f+BAKbMi3WZq8vFyREaBjIJd3emdjcR5JLBEVKtoF9DrEdhPQNuku945XpFqE3thAWCX3zqyJH0NPjSYsaaMiyIYtylX/pdfsGgfYgCR3RyWRDoXNyg4pOv2LPt5Mxo=
Received: by 10.100.140.12 with SMTP id n12mr4829217and.137.1208225631512;
        Mon, 14 Apr 2008 19:13:51 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Mon, 14 Apr 2008 19:13:51 -0700 (PDT)
In-Reply-To: <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79558>

On Tue, Apr 15, 2008 at 9:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Roman Shaposhnik <rvs@sun.com> writes:
>
>
>  I'm too lazy to make a laundary list of what you can have in .git/config
>  with the current system (see Documentation/config.txt), but that part of
>  the system is built around the design that the configuration is specific
>  to the repository (and sharing what the user records in ~/.gitconfig
>  across repositories is in line with it).
>
I can give some which can be enforced in a project level

merge.summary
status.submodulesummary
core.whitespace


-- 
Ping Yin
