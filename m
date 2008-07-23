From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: HP-UX issues (WAS: Re: [RFC] Git User's Survey 2008)
Date: Wed, 23 Jul 2008 23:38:00 +0200
Message-ID: <200807232338.04340.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <7vsku1gqny.fsf@gitster.siamese.dyndns.org> <20080723074747.GA32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:39:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm3I-0002n0-Es
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbYGWViN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbYGWViM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:38:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:31983 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbYGWViL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:38:11 -0400
Received: by nf-out-0910.google.com with SMTP id d3so981364nfc.21
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GAH9l6brpq6BPAomgzI7GaTDOF5Ci2y0HNUEGQJ0SKM=;
        b=su4SCUqT550S+ZvKvUzceLzMKWsYithDic5pyZb8XEYrWvoiDR7hT++fXd4jzLfj6p
         KEKNzzzcnKgN2zitHeRVFH+CPcZeutxRMC/dMAk8ZVCglyo53UjzDzB9taW1EoPAFFaF
         lJOhkG96h25X2Dsovc784LwibK56rWalWqS8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W2r79/nfdYr3TtekxiUkzuM2olZUjhFJ27TRD7I5ojqGGTaNWJd+4jI/d6GdpkMPud
         V3HlsPZTompJ5OJW+w9VbBs0NXWSNm05s7jchuKbdSLnYSe5qxQsqiiDu7B/zXhqhGqd
         JX+cUEdgZ9aVFKTELNDjpn5QEUG/1VQ2ULGMA=
Received: by 10.210.16.11 with SMTP id 11mr278565ebp.187.1216849089784;
        Wed, 23 Jul 2008 14:38:09 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id h7sm17928968nfh.34.2008.07.23.14.38.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 14:38:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080723074747.GA32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89782>

On Wed, 23 July 2008, Miklos Vajna wrote:

> Being more constructive, what a user using HP-UX is supported to do?
> 
> 1) Use the patched git from HP.
> 
> 2) Have coreutils installed. (But then I think it would be good to list
> this dependency in INSTALL.)

It would be good idea, although "POSIX-compliant shells" implies
coreutils somewhat; shell scripts usually do require some utilities,
like sed, grep, cat, test etc.

> 3) Patch git to use automake's install-sh. (Would such a patch be ever
> accepted?)

I think it would.  It would allow us also to uncomment the
AC_PROG_INSTALL line in configure.ac file to find 'install'
automatically (autoconf requires having install.sh or install-sh
fallback in the sources).

The problem is coming up with minimal yet portable (at least as
portable as git itself) fallback install.sh script.
-- 
Jakub Narebski
Poland
