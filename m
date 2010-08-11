From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 03:29:53 -0500
Message-ID: <20100811082953.GA16456@burratino>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com>
 <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
 <20100809234620.GA6418@burratino>
 <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
 <20100811075503.GD5450@burratino>
 <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:31:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6ig-0007C7-JH
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab0HKIbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:31:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48356 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab0HKIbX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:31:23 -0400
Received: by gxk23 with SMTP id 23so4024230gxk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f+9yloboCJB2WBFntddZQc6JPV1oTaZNlO9utLYLpgg=;
        b=Cs5/zQZze/TxI48H0Bp+/aSi7xidU/3j0LDmmQFGwKr4NlmEQZ5mbPsOTqsrwpBnWb
         eozQzTjH8AJxnI8ZpdVx/bT+ZBdimOvlJYA0pYnNG8xJvSxSrmPmdxCroAvFkdeOi3cT
         H/FSn6RJo1ZfJWD89dlupalTha400gkmkRpUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jEmNmL94dC50rDPV9M3iXtKe4af05V76mH8J2KM+itiUpH3plpnHb6kiEGxv2EJjX2
         TT6dJEfEZqxZHoQSjriPKtKf6NL4ZBqgY1szR8UoVmVb+OWUtggSrilPjlfZvAvi3CQh
         jg9YF4Lx+m3JQKdpjDGVlIjnLER9fyzTpdwXo=
Received: by 10.150.134.5 with SMTP id h5mr5311486ybd.405.1281515482906;
        Wed, 11 Aug 2010 01:31:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 18sm390235ybk.19.2010.08.11.01.31.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:31:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153202>

=C4=B0smail D=C3=B6nmez wrote:

> [~/Sources/git/t]>  sh t4201-shortlog.sh
> ok 1 - setup
> not ok - 2 default output format
> #=09
> #		git shortlog HEAD >log &&
> #		fuzz log >log.predictable &&
> #		test_cmp expect.template log.predictable
> #=09
> ok 3 - pretty format

Oops, my bad.

	sh t4201-shortlog.sh --immediate
	cat "trash directory.t4201-shortlog/log"

is what I meant.  The idea is to get the log that that log.predictable
is based on, by fetching the log from immediately after the failing tes=
t.

Sorry for the trouble,
Jonathan
