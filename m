From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] reset: accept "git reset <removed file>"
Date: Tue, 19 Oct 2010 17:34:42 -0500
Message-ID: <20101019223442.GA5960@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <20101018211522.GA7655@burratino>
 <20101018224840.GA9729@burratino>
 <7viq0z2gxj.fsf@alter.siamese.dyndns.org>
 <20101019002349.GB9841@burratino>
 <7vk4le13z3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 00:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8KpN-0003uE-6a
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 00:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab0JSWi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 18:38:28 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60293 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab0JSWi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 18:38:27 -0400
Received: by qyk9 with SMTP id 9so907719qyk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xuHeElCFbHl7hstSIC4fZHPhcsbVEDtJ32SUbdB/b4c=;
        b=gelo7CLlSh1ALagJJJcyLhgvq3m09s190zlB9rWp6L3Leo4dI4mkPG1R9/EVjUJhvG
         sAArsNPz7GDV7Mzr3Tg2Nnv+6Rd0Wmn29W1/djAxSvPgurGjp8uafJGHbVyx5rSmAFzS
         ezsfAjkh+29ErL9F4/8jydZTu0T2s0gfwBmvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I1B9lsM7NynLWDMXVWpTdpRHziexunBsp9mVJPgJraTTun6DPOZfRgc9JeOd2hmkmz
         JCv4PSC/LFrsTwTdTVxSYzHOPxYLX2bO/T5e1nLQbf5D+ZgNs4P9tSQKzmEId0ihpX5S
         kufUGSr57XjGY83qvCTw4sCT5aFempvKs/Cm8=
Received: by 10.229.98.209 with SMTP id r17mr5687633qcn.241.1287527907133;
        Tue, 19 Oct 2010 15:38:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm7014244qcu.47.2010.10.19.15.38.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 15:38:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4le13z3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159375>

Junio C Hamano wrote:

> It is generally unsafe, I am afraid, and that is one of the reasons why
> verify_filename() does not look in the index (the other one was "it is
> merely a safety measure based on heuristics to help users, and no point
> spending extra code nor cycles", iow, deliberate laziness ;-)), making the
> proposal of this patch under discussion somewhat iffy.

Let's drop it, then.  I'll continue the practice of always including "--"
in examples suggested to new users.
