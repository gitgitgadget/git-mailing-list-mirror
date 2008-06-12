From: "Alf Clement" <alf.clement@gmail.com>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 08:32:26 +0200
Message-ID: <556d90580806112332s25f76caajaaafa8e16e895922@mail.gmail.com>
References: <20080611182501.GA3344@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:33:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gN9-0003Kt-1s
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYFLGc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYFLGc3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:32:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:55721 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYFLGc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:32:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2379348fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Am3VzFeZK2msGo2DOJcTWvavLtmeq6QDa0GnCFIz89w=;
        b=aoFztqTDYasRU/Gdn28ovZ+ocaWEQBMMsVI3tviApOdvFVUO+4NbIMLx5FfyA2mhzk
         PnINVlUZpd70xzvUxXP7TMu+CWbCdlRDWTEeCShpw+qALcbN/ctHJnYDtnXgJooMjM9o
         Tx17tYKlHESqVJSFutS1d+FseC13ePTWirmfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=N+5tP7imwX2T2xYcSoS01f9M4o+ZnVg4iRovRoEAsW5gKfJS8tN6ZjcunhE7bhxhE5
         j5RLYnOK94Chiau6IIavUYbrvMQl6PzuS4RL7tXEQK9b7Idlb7+thRO/cnFdgaEzPCAt
         gXoyXNTCq58VDih85kgMtNaxSr5VgBhtDz05w=
Received: by 10.86.52.6 with SMTP id z6mr1604945fgz.18.1213252346594;
        Wed, 11 Jun 2008 23:32:26 -0700 (PDT)
Received: by 10.86.96.14 with HTTP; Wed, 11 Jun 2008 23:32:26 -0700 (PDT)
In-Reply-To: <20080611182501.GA3344@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84722>

Hi Alex,

> +static unsigned char *unquote(const char *s, unsigned *len)
> +{
> +       unsigned char *result = malloc(strlen(s)), *r = result;

are you sure that the buffer is big enough?? Nomally you do a
malloc(strlen(s)+1).

CU,
Alf
