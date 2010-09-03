From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] instaweb: ignore GITWEB_CONFIG_SYSTEM
Date: Fri, 3 Sep 2010 18:58:20 -0500
Message-ID: <20100903235820.GC4471@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
 <20100902235429.GB6466@burratino>
 <7vfwxqzqoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 02:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrgBM-0008QH-5J
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 02:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab0IDAAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 20:00:13 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55526 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab0IDAAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 20:00:12 -0400
Received: by qyk36 with SMTP id 36so564244qyk.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cmOJLDy9E2fljJBQnOfS2SkpOheCIPGiXAM71Jia0Ag=;
        b=DyRkMKHBhwYsPp3+RHOz1MZvWE+Wr2mYe3/WDFy+o5JiJ0buYjEHstvf9za8j6gKRc
         yJETwo/hV6KrgNcueWuMOmlZj+Ec5KlkJrx8fWNxrs1b8nL8nb9C5UpIupLcnE8E5ILN
         YKGuuY/T/9Y6DlGnW8igktIIjWoJL4c2UJKCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cDUlaEDfBfGHzYnKzSCH2gcgercl0nNW1dJMGPc1W5bT5URwMMBQSGX+9oAiewDix5
         lZ/8RUd+zKta9Kb0nLxXlYayk1QKhIKk5kSmRiwrYgkLp0cbzG620GfInEdbWT0Hz5K3
         /6pL9GG9C3ncCJlvd0y5azDgrWLpnm6mQpoS4=
Received: by 10.229.213.80 with SMTP id gv16mr1220439qcb.134.1283558411419;
        Fri, 03 Sep 2010 17:00:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q8sm2610385qcs.0.2010.09.03.17.00.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 17:00:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwxqzqoq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155289>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The configuration in /etc/gitweb.conf might specify any old
>> layout; in particular, it is likely not to be identical to that
>> which git instaweb sets up.  Noticed by Uwe Kleine-K=C3=B6nig.
>
> I am not sure if this is a reasonable change by reading the above.  I=
n
> some cases, the file may stale, but in other cases

Ah, I missed your point here.  By "any old layout", I meant "an
arbitrary layout"[1].  Sorry for the lack of clarity.

Jonathan

[1] http://www.google.com/search?q=3Dany+old
