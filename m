From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: new cgi parameter: option
Date: Fri, 13 Jul 2007 02:03:17 +0200
Message-ID: <200707130203.17778.jnareb@gmail.com>
References: <20070708013543.GD29994@genesis.frugalware.org> <200707121211.32813.jnareb@gmail.com> <7vy7hltq98.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 02:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98d8-0001mq-H6
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 02:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381AbXGMADW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 20:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbXGMADW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 20:03:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4033 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758488AbXGMADV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 20:03:21 -0400
Received: by ug-out-1314.google.com with SMTP id j3so458573ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 17:03:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gpirzQHNgXkjvRv7DOQbRrTog5du3wxbvbnwVPGNTUWrrxaAna97m94Na2ITsth60d2iatwZDThjTwpOkgOn4uwzF5h5tgSwy0mVfTx8oCpRrxEMIUpUPD/5y945YZ/56e/uDp94o35rZ/yInjNpipOTDxoJzl/1yfMra22lE7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pEQ9JflfDuqtCLbMmfpl+XdtIkvIKeLtpUhaSOVJrW10OWLX98Z6pIaI2zG2lbx9HvLPFVoHJLG8gffKCBs1sUwH7cmOlVwzks5YFvqDmJiZsSRQ7rnZRmkX7+auGQF6pu+dUZgYFjxd1Gw/dMHh9Kingf30RUmrxHtAKaxEexY=
Received: by 10.86.4.2 with SMTP id 2mr865979fgd.1184284999303;
        Thu, 12 Jul 2007 17:03:19 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTP id k29sm1594432fkk.2007.07.12.17.03.16
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 17:03:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy7hltq98.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52346>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

>> By the way, gitweb uses shortened names for paramaters. Perhaps 'opt'
>> or 'op' instead of 'options' here and in href subroutine (below)?
> 
> Or even 'o' ;-).

'o' is used for 'order'/'ordering', to sort tables for some actions.
-- 
Jakub Narebski
Poland
