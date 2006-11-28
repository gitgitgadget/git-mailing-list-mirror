X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 18:47:50 -0200
Message-ID: <9e7ab7380611281247h723a16fapc5a9898e8a4c7e1f@mail.gmail.com>
References: <loom.20061124T143148-286@post.gmane.org>
	 <20061128054448.GA396@soma> <20061128102958.GA5207@soma>
	 <20061128105017.GA20366@soma>
	 <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
	 <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com>
	 <m2bqmr1rnw.fsf@ziti.fhcrc.org> <20061128201605.GA1369@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 20:48:17 +0000 (UTC)
Cc: "Seth Falcon" <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nOlBFTpKIaEwII2Kn4KTVzRcbAVl3AgoUsfm/sSxxo40S+d97FEuEAt+SnPDG6qqYICAbiHhzz+IS69EZlymg0d9SPDKOg0XPAYVtR/PvOfeIkWwUOsCSVQ8v/Z4YL79wSDtoRFl6Saq7+yDHSkTzLCaWpNfkue7yzJtXRxvQW4=
In-Reply-To: <20061128201605.GA1369@localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: d7888054b8faefa9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32576>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp9rw-0001Lw-Dl for gcvg-git@gmane.org; Tue, 28 Nov
 2006 21:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755296AbWK1Urw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 15:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbWK1Urw
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 15:47:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:723 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1755296AbWK1Urw
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 15:47:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2686644nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 12:47:50 -0800 (PST)
Received: by 10.49.107.3 with SMTP id j3mr13040623nfm.1164746870185; Tue, 28
 Nov 2006 12:47:50 -0800 (PST)
Received: by 10.48.216.6 with HTTP; Tue, 28 Nov 2006 12:47:50 -0800 (PST)
To: "Eric Wong" <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

On 11/28/06, Eric Wong <normalperson@yhbt.net> wrote:

> Git itself cannot easily track empty directories (at least as far as
> update-index and checkout) goes.
> [...]
> Is that something the git community wants?

No, I guess not. I detailed the real problem in my previous message,
and it had nothing to do with empty directories, but with git-svn
recording broken revisions from svn. Did you get it, or Trogdor ate my
email?

