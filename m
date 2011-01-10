From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 15:33:08 -0600
Message-ID: <20110110213308.GA12030@burratino>
References: <7vhbdg6286.fsf@alter.siamese.dyndns.org>
 <4d2b5c52.68e3cdc2.bm000@wupperonline.de>
 <20110110194242.GA11801@burratino>
 <7v62tw5twb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 22:33:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPMk-0003rE-Gw
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 22:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab1AJVdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 16:33:21 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42088 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab1AJVdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 16:33:20 -0500
Received: by fxm20 with SMTP id 20so19297070fxm.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BU9nYGQv2zkEX8uoAQ3TbYFPtUJDxUlLI8Ws/cg5XIQ=;
        b=bykUhNVjHXJccjy3K/J0JZRnXD/rvRecjVpsMs/8VTZ8sWw8yMdNvydJAqRO4wPiNU
         1suJ5iLSYaBNB8T9sjg8a8sjUGBKVQPZam/ZZmwBNB8HVS8gZLs/EEbNome+ncqbOfFp
         b4C3BHvL+Kzf3piRhkqv6FEN40Q7YUmizvYxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=deXIaurzOXzN8+mRmAKLeNDgwJKcg/fNhb9n+iAeH+aaGyVZtIQXV3fL1ou4OE2m1o
         OKR5qyk5wKIXgA0V0HbGgDvRDplHh2oEQvwICEdFTED6lg7kHJi2YUF1y6OBf5aNg+Qv
         u3QOfXkcIBopEsKKbrYXCBKoQOkswikwA/gdo=
Received: by 10.223.96.139 with SMTP id h11mr1204943fan.82.1294695199401;
        Mon, 10 Jan 2011 13:33:19 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id z1sm7156672fau.45.2011.01.10.13.33.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 13:33:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v62tw5twb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164896>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> Unfortunately, I had a shell alias function named git that interfered. In
>>> fact it passes to the git program (command git "$@") but sadly does not know
>>> about the newly set PATH and (still inexplicably to me) makes the variable
>>> set.
>
> Yuck.  I really do not want to do something like this X-<.

Please don't. :)
