From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 0/6] gitweb: feed metadata enhancements
Date: Wed, 28 Jan 2009 22:48:17 +0100
Message-ID: <200901282248.18611.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <7vskn3m9l1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSIIE-0001P1-PI
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbZA1Vs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZA1Vs2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:48:28 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:48293 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZA1Vs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:48:27 -0500
Received: by ewy14 with SMTP id 14so3593160ewy.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4eNzCP648ZsBq+Y2V6/DRu69P7PuKu7Pw6wur5x8yfM=;
        b=Ipf5yE8SJN6KnTVO89otalm0AjAFnb4CfBxAN8EhgcbI0UIB8j995eiwQUfUwBtOcr
         QlnatZYXd33K/03WO74UVKN/zLc7yTpr6jEaHflzoXBhrKLe8/F5PMgMjrH+ZgDjILvf
         wRjniJnEX9ykbSe4iEhEnlocnnUQeXWESSoyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=c+f5bGZn6vtcb3d/EF044fyN8pcGOVDVbYjI78ksMvlNJCu3ot2cwQ8RP1QmL2xNHN
         LFWvHBlUkM6OFGujunv1gADOEHK320m3LPDKoQEzTB4l1oDyttUnNbYHETGsv4wzrAN1
         qzWW0p1b6JOz1fneKbqfThVXLEWvFByFYGNbc=
Received: by 10.103.238.4 with SMTP id p4mr3676659mur.68.1233179305279;
        Wed, 28 Jan 2009 13:48:25 -0800 (PST)
Received: from ?192.168.1.15? (abwy116.neoplus.adsl.tpnet.pl [83.8.248.116])
        by mx.google.com with ESMTPS id w5sm2022355mue.55.2009.01.28.13.48.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 13:48:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vskn3m9l1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107583>

On Wed, 28 Jan 2009, Junio C Hamano wrote:
> This is independent from your other topic on PATH_INFO, right?

Yes, it is independent on adding BASE for PATH_INFO.

> I am aware that other one is being polished between you and Jakub,

The code (in BASE for PATH_INFO) looks now good, only commit
message might be further improved.

> but is anobody doing anything on this one, or is it already polished enough?

I think it is good, but I do not use web feeds (Atom and RSS)
from gitweb myself, therefore I don't feel competent to tell
if it is good enough. With exception of last one there are
quite simple and feel good; the last one is a bit more involved,
but I think also good (it would be nice to say in commit
message that HTTP::Date can be found in perl-libwww-perl).

-- 
Jakub Narebski
Poland
