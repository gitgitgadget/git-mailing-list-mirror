From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [RFC] request-pull with diff body itself
Date: Tue, 28 Jul 2009 10:00:08 +0400
Message-ID: <20090728060008.GA4799@lenovo>
References: <20090727195357.GE17942@lenovo> <7vws5tg8fw.fsf@alter.siamese.dyndns.org> <aa79d98a0907271356l51111uac0884cf148f434f@mail.gmail.com> <7vtz0xerzg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 08:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVfjf-0001g5-7T
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 08:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZG1GAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 02:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbZG1GAT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 02:00:19 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:63573 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZG1GAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 02:00:18 -0400
Received: by bwz21 with SMTP id 21so675284bwz.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 23:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=pa2fl6aozsYLjpXQ4QB7aznW6fq+mJoDelw+CQkggM0=;
        b=LhGTHXYzoFsYUnbkzVep3btgue3RXxQfAQe0fej+eSBbMAMIZfdTlnHDAxLk+woJOQ
         vidhVleYGny/ha3/DGQ4v7AiatS/nqlOhX4DTo959wUaxdIReDqg0T38C01ai8ty6lVV
         gQ11h7b7JvSppICSTlPtPLkLd5UWBJ/9QIrfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C6+gxytqWf9A5QaZCYZ80nopT6G9H0GF6PZTLORp18rnSh335nk5SlxXjg2Xg8pT/M
         Fx2Pa/fCgiZ4OJ+OgfJ3y3eJiGohdXsuWy9cgA9uiUlF8ZTDyVEg1BxzS0MKg2Vvs8GI
         zHizz3ySJDZtSoIT+lAp2vuCVq+9jyyb/y//Q=
Received: by 10.103.24.11 with SMTP id b11mr3741480muj.133.1248760817797;
        Mon, 27 Jul 2009 23:00:17 -0700 (PDT)
Received: from gorcunov (host-219-145-66-217.spbmts.ru [217.66.145.219])
        by mx.google.com with ESMTPS id y37sm31593521mug.49.2009.07.27.23.00.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Jul 2009 23:00:17 -0700 (PDT)
Received: by gorcunov (Postfix, from userid 1000)
	id EDDDAEED; Tue, 28 Jul 2009 10:00:08 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <7vtz0xerzg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124211>

[Junio C Hamano - Mon, Jul 27, 2009 at 02:27:47PM -0700]
| Cyrill Gorcunov <gorcunov@gmail.com> writes:
| 
| > Will post an updated patch in a day or so ( as only get back my laptop
| > back). Or maybe someone could make it faster then me ;)
| 
| Like this, perhaps.
|
...

Yes, Junio, thanks! Please merge it into git repo
(if noone objects).

	-- Cyrill
