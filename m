From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Tue, 19 Mar 2013 13:34:47 -0700
Message-ID: <20130319203447.GD3655@google.com>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
 <20130319034822.GL5062@elie.Belkin>
 <vpq1ubb3o5g.fsf@grenoble-inp.fr>
 <7v620nl99g.fsf@alter.siamese.dyndns.org>
 <20130319190624.GB3655@google.com>
 <7vd2uvi33w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 21:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI3Fi-0002eV-5I
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 21:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326Ab3CSUex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 16:34:53 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35146 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3CSUew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 16:34:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id 4so312502pdd.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WGd10ppCDL1MYHuzfPEIg7aRzfPNQbFkGgMlzYa3dcA=;
        b=mc39bapq0QxOX07Ix56PeMRobK07+mYKC6mL1VL4nNCHeEdwXrx7powal2NXXg2c1u
         EZSTnqJWu4XqwnCF9PCdtZLRXXY3b+yQAn9z7r59ahLhYc1S9Op8gh2S9PkuSl0zO4i5
         JhrZvRirxcTcEyMpXve4/fLBIgAERkV78M+LyGzTrlqgfqH7a9XucZ2dNkWtfLPb6UzZ
         nokvdmenxzN/xhLvYjbSYJsfweROQ00nfqEmaOt4AEknHZ0f2l4LwoacvoaRMV1V9qh6
         ILBZZ7uaAUI9fzObbnhVRxDl0Ea1m3oombR4+Jrp6ra+R34t3Rekq8HGIxMTdegowWEz
         fUxw==
X-Received: by 10.66.242.73 with SMTP id wo9mr5384464pac.59.1363725292135;
        Tue, 19 Mar 2013 13:34:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rl3sm25468940pbb.28.2013.03.19.13.34.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 13:34:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd2uvi33w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218554>

Junio C Hamano wrote:

> Incidentally, I am rebuilding the 'next' by kicking many of the
> topics back to 'pu' (essentially, only the ones marked as "Safe" in
> the latest issue of "What's cooking" are kept in 'next'), so perhaps
> we can rebuild the jc/add-2.0-u-A-sans-pathspec topic with your
> series at the bottom, or something?  I do not think I have time to
> get around to it myself until later in the evening, though.

Sounds good.  I'll reroll with the use-prefix-not-pathspec tweak and
incorporate the current patches from jc/add-2.0-u-A-sans-pathspec.
