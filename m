From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 11:07:47 -0800
Message-ID: <20130131190747.GE27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zUg-0002gf-EX
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293Ab3AaTHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:07:54 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:33622 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab3AaTHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:07:53 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so997714pbc.25
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OmO7oG9sNFZbBl4H+FSQAfT/ANSuigTLTshXK7ovOA4=;
        b=BAYGds9ybgGFn7i/piBa3dyUIU8M8eyuJNYiICtPpddsTla3xeEVH7m5Caljmc+pYE
         9YlObVVyT4Riq5aEzWi+GRixrnrFm46BrYdlRB8Fm0M14hykBApVP+W2PViY1KL4rttN
         jUx0d55R0q3P6dm0ZSZ+/QOnR7PuLN2dy2jHI9eFgjDhz4UoHtcPN+Y/efbempPFFNS/
         A2NVH93SE40cqIAofG4pNy/p6ss7YBfzYevlGb+naL3DJjJ5sT6NCpx0HMWGwgboWezP
         GefV6KcmSLImv3LvzENEoVRXAn+9kGRfJRK/neKQaU93GtRGyPz38zz9LeapkGLnnANg
         fmEQ==
X-Received: by 10.66.72.198 with SMTP id f6mr23010399pav.42.1359659272277;
        Thu, 31 Jan 2013 11:07:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id t6sm6389817paz.11.2013.01.31.11.07.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 11:07:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvcadgss0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215150>

Hi,

Junio C Hamano wrote:

> Wow, that's a blast from the past.
>
> I tend to agree that deprecating and removing are quite different,
> but a simple "revert" of the change would not be good, either.  We
> still would want to _discourage_ its use.

Hm, I was about to try adding a line in that vein, like

 * `tracking` - deprecated synonym for `upstream`.
 
Imagine my surprise when I saw that that is what you just said
would be no good:

[...]
>>>    `git pull`.
>>> -* `tracking` - deprecated synonym for `upstream`.
>>>  * `current` - push the current branch to a branch of the same name.

I really do think that including `tracking` in the same list would be
valuable.  When I look over a friend's .gitconfig file to help track
down a problem she is running into, it is helpful if I can find the
meaning of each item in a straightforward way.

Is the problem that "deprecated" is not precise enough?  For example,
would it make sense to say "deprecated synonym for `upstream`.  Will
be dropped in git 2.1" or something like that?

My two cents,
Jonathan
