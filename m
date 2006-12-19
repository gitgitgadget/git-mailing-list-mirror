X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch rebase and push
Date: Tue, 19 Dec 2006 12:58:53 +0100
Message-ID: <200612191258.55226.jnareb@gmail.com>
References: <45875EFC.5090408@gmail.com> <em8cti$nff$1@sea.gmane.org> <4587BD31.9030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 11:56:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dFTpeI4rPtf7wjATDe1G4g5wDnrNbZnPzmeBpmqhkxlvEQsMRjMgOf05uQup1p9VaI2IHlvNMXwBgoJj84rUxpde+RP+Ep8OCHkDUBbrNltX3HvKG+u0WMmkEEu6MUzuk7BvJ5sP6y5ZFf0RAP6wMCTZoQaywHR1sINgIVh85AE=
User-Agent: KMail/1.9.3
In-Reply-To: <4587BD31.9030804@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34824>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwda7-0001cc-CV for gcvg-git@gmane.org; Tue, 19 Dec
 2006 12:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932763AbWLSL4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 06:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLSL4Y
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 06:56:24 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:37837 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932763AbWLSL4X (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 06:56:23 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1189948wra for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 03:56:23 -0800 (PST)
Received: by 10.82.165.1 with SMTP id n1mr954304bue.1166529382492; Tue, 19
 Dec 2006 03:56:22 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 39sm9018763ugb.2006.12.19.03.56.21; Tue, 19 Dec
 2006 03:56:21 -0800 (PST)
To: SungHyun Nam <goweol@gmail.com>
Sender: git-owner@vger.kernel.org

SungHyun Nam wrote:

> I'm sorry... but could you teach me how I publish the rebased branch?
> I think Junio does it for 'pu' branch.
> Is there recommended workflow? I cannot find.

Either have "Push:+refs/heads/br:refs/heads/br" in your
.git/remotes/<name> file, or it's equivalent config file
version, with '+' denoting that this branch sometimes does
not fast-forward.

Or use git push with --force option when you had rebased.

And of course the server you push to has to not have config variable 
receive.denyNonFastForwards set to true.
-- 
Jakub Narebski
