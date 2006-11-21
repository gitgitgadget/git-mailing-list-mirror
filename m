X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 18:39:56 +0000
Message-ID: <200611211839.58709.andyparkins@gmail.com>
References: <200611211341.48862.andyparkins@gmail.com> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 18:43:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UqYRkaLBLAzUvJSo31J9oQm6DZy1WdVboNykEcQvsXkcOS0uW5idHEZFS0SeKoljBdZ4VhOpJkaxF/DG5g3DIvlA8aqEQVm1EwH1pe9hCqeMonFl7VcNmD4NbglceoyDc09xpZfibj9ecTI7NSYMzmr10urddOywBJhcCpkL+Tc=
User-Agent: KMail/1.9.5
In-Reply-To: <20061121182135.GD7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32018>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmaZy-0003PU-8U for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031296AbWKUSmm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031298AbWKUSmm
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:42:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:41384 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1031296AbWKUSml
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:42:41 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1611485ugc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 10:42:39 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr1637453ugl.1164134558872; Tue, 21
 Nov 2006 10:42:38 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 53sm8199643ugn.2006.11.21.10.42.38; Tue, 21 Nov
 2006 10:42:38 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006, November 21 18:21, Petr Baudis wrote:

> (The answer is usually "create the branch in a separate repo and then
> fetch it to the original one". But it feels a bit kludgy given the
> otherwise seamless support for unrelated branches. (Not that I ever was
> a big fan of unrelated long-lived branches in general.))

Just as kludgy, but I did this today by writing the name of the new branch 
in .git/HEAD then doing

for file in $(git-ls-files); do git-update-index --force-remove $file; done

Before creating the new files and "git-commit"ing.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
