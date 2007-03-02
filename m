From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from,
 when branching off a remote branch
Date: Fri, 02 Mar 2007 12:15:59 +0100
Message-ID: <45E8076F.1050606@lu.unisi.ch>
References: <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com> <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org> <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net> <20070302103240.GA13217@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Paolo Bonzini <paolo.bonzini@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:16:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5kF-0004Em-Pd
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423014AbXCBLQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423030AbXCBLQF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:16:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:2365 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423014AbXCBLQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:16:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1245919nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 03:16:03 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HpnlNnMua+VY9YXqbaRksZJ9gi1scsW2Egb6AZamejMkoe8CzhjnhQJvcFA6Z1S7/bhrbG5bKWYEz1U1LgPd4N5PzSRvtjg59hbQyjKSWHrwcX297koajZSzEqTdszUXv0jD8S5BfGF14fg+s8cGobkrcDTyszdJTBk4lW7KB+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Z8TYr4C4HuLjPJP16i0PgVnqZ6g9A0pRMUP4SkaJWJyUrVTpQ/Vr+jWsQ+d+0fetbZ5iWK9CKTGOjvXrpTWcphzjz24hgCqjSlvydAy3OW+qLP5LeId6n2cKkE5BxoibVchGJJU1zmudLbc991eC5wsi31gfV2YCr7OJMqP1XKg=
Received: by 10.49.41.18 with SMTP id t18mr7499458nfj.1172834163213;
        Fri, 02 Mar 2007 03:16:03 -0800 (PST)
Received: from ?192.168.68.211? ( [195.176.178.209])
        by mx.google.com with ESMTP id y2sm3601472mug.2007.03.02.03.16.01;
        Fri, 02 Mar 2007 03:16:02 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <20070302103240.GA13217@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41191>


> IOW, my point is that branching should write the information it _knows_
> into the config: branch X was branched from branch Y. It should be up to
> the programs to _use_ that information in a reasonable way. As it is
> now, this patch makes the decision about how to use the information at
> the time of branching, which seems to be the source of a lot of objects.

The problem is that this will pollute the configuration file a lot.  I'm starting to wonder if all this branch information really belongs in .git/config at all.

Paolo
