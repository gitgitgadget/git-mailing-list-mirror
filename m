From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 10:03:43 +0100
Message-ID: <200701151003.44498.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <20070115070826.GB939@localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2M-0000Qa-Lw
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:26 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9I-0003eK-6A
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbXAOJDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 04:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbXAOJDa
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 04:03:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:53150 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbXAOJD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 04:03:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1293241uga
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 01:03:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=akUjFRtI4tBJ/RIapJsUtGT2bcpgxXbN6D9O44kNwXMkVrn17rz8h+EwVO23ufDrVmmzFQHSsu9C07zRn5Wnd0hfKlT7csVnmiC1Q0ByLQ9rD7IsqvhUMfNQ2Z2OrdI4AS8+SNCdFLYhORP6t74uWq1FUkvP83MEXSx0NFKGvzI=
Received: by 10.66.216.20 with SMTP id o20mr5070776ugg.1168851807730;
        Mon, 15 Jan 2007 01:03:27 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id w40sm5295444ugc.2007.01.15.01.03.20;
        Mon, 15 Jan 2007 01:03:21 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20070115070826.GB939@localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36860>

Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> To make gitweb faster I thought about adding to it, or to Git.pm,
>> simple nonvalidation config file reader. Nonvalidating means that
>> it would accept some input which git-repo-config considers invalid.
> 
> How about something like git-for-each-ref that dumps the entire output
> of a config file into an eval()-able string?  That way we don't have to
> deal with corner-cases and subtle differences between C and Perl
> implementations.

The idea is (at least for gitweb) to avoid cost of fork. And I think
if the format gets documented properly, there should be no differences
in config file parsing.

Please remember also that is first draft of git config file reader
in perl; an alpha version.
-- 
Jakub Narebski
Poland
