From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Tue, 18 Dec 2007 16:52:22 +1300
Message-ID: <46a038f90712171952i4f53876fv55b0e6993d5f4b0a@mail.gmail.com>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	 <20071215004230.GF7300@mail.oracle.com>
	 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	 <20071217200920.GB19816@mail.oracle.com>
	 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
	 <7v3au16myj.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
	 <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Joel Becker" <Joel.Becker@oracle.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 04:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4TVg-00061S-6D
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 04:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXLRDwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 22:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbXLRDwZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 22:52:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:40927 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbXLRDwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 22:52:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so41489ugc.16
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 19:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e9liCwqqSQKSPYt2vLjBAlYyBZENlMVOJyMlItTtcP8=;
        b=lqNdTM3PJrw7h5MNUD83gv6lPp2C1AhpnUoC+U1C1OkNw3lEd8ZAhvBhFPYrfpNMZ/W6GoiQaY8PiwgD8sR/pwUE7KQxvO1u+u+cKCc+8BUZ8vfUoOkp+wOZAJk6gH9SFp3eFDoSS5k82e+1C1xxk1DNvHQ23DBqt3DtGaWsuXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uRsBLZgkLFnH9b7LBk4bb3Uo/mD0RZYk7KvRW8zt7s/PuqdNTVUEbi6A+Rvj8KA7F589wZo4Tkl+LGltVgK+QOLPuyyF2gl+ek+lqUNy9ZO55OjJslHdxUtuaLHXgn+0qIIr31HKp3t6QNdj/KJLNDzMVTvs5/ufn1b9NLsxUV0=
Received: by 10.66.216.15 with SMTP id o15mr293301ugg.78.1197949942379;
        Mon, 17 Dec 2007 19:52:22 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 17 Dec 2007 19:52:22 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999999.0712172212110.8467@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68695>

On Dec 18, 2007 4:23 PM, Nicolas Pitre <nico@cam.org> wrote:
> Sure, but at some point that's something users mixing versions should be
> ready to cope with.  We try to make it as painless as possible of
> course.

I have to say I agree with the "apparently minor updates should not
break cross-version compat". And I think it's a communication issue
around the version numbering. The fact that this will be introduced
with a v1.5.5 is, IMHO, a good part of the problem.

If cvs 1.11 doesn't talk with 1.12 I'll say there are nuts - minor
revisions should interoperate with end users not even thinking about
it. But 1.5.5 has in its changelog lots of deprecations and interop
changes.

It's not good communication to label it 1.5.5.

Other than that, it's an _amazing_ thing, and I'm in love with git.
But the version number is a bit of a lie -- and is bound to confuse
and anger end users.

cheers,


martin
