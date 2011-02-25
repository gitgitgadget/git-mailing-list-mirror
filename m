From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 27/73] gettextize: git-commit formatting messages
Date: Fri, 25 Feb 2011 15:35:05 -0600
Message-ID: <20110225213505.GD4580@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-28-git-send-email-avarab@gmail.com>
 <20110225094342.GJ23037@elie>
 <7vd3mgar5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 22:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt5Jt-0002dE-S7
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118Ab1BYVfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 16:35:21 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53544 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab1BYVfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 16:35:20 -0500
Received: by vxi39 with SMTP id 39so1769719vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tDp/zXsYkbDArOCCw3NJMe7ihgjW9RmGGYZ7Gc6XkaU=;
        b=uSl7+G347epjUrO/7PywhmXeLJeEEqdSktU/+u/qTkBEYG62A/7ryYeIvMesR2dHly
         9KDflDldqbKDg9nqVZkQWgSZpSRFhvaZGX7woAMMTLzUUHUMHZL9fKDQFyWtC3vkuv2s
         bPqsqsD0rHuI7XMm/8YjKeizFmBOxK3540Hs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XodmBbXJZMyuKyEeerZpDBis1JEaO9NM+y3L/Khozhn8zEq9hi49DkqWL/QgAeyIb4
         Vr/qiJoILFCIm1XgA9JKaKTqBx5qufUvOJPBSMPMjcXKbMbiUv3jArN8vSGxM46JymNI
         QuN9Lzfqw2Ta1F0dgKT4wvdwQtoC4evresKe0=
Received: by 10.52.157.74 with SMTP id wk10mr5073015vdb.114.1298669712076;
        Fri, 25 Feb 2011 13:35:12 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id b26sm796766vby.3.2011.02.25.13.35.10
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 13:35:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd3mgar5g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167944>

Junio C Hamano wrote:

> It might be a good idea to introduce status_print{,_ln,_more} wrapper
> functions around color_vfprintf()

My main obstacle to sending this was lack of good names for the
relevant functions. :)

>  - Another advantage is that this makes it easier for us to drop "#"
>    prefix in "git status" output in later versions of git if we wanted to.
>
> In "git commit" template, these lines need to be made into comments, but
> there is no reason, other than that we are sooooo used to seeing these
> lines prefixed with "# ", in "git status" output.

Good point.  Expect patches soon (for the status_print*, not "#" removal
from output).
