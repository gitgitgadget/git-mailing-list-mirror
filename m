X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] gitfs pre-release 0.04
Date: Mon, 4 Dec 2006 20:54:33 +0100
Message-ID: <200612042054.34157.jnareb@gmail.com>
References: <20061204194011.GW47959@gaz.sfgoth.com> <el1tg0$n07$1@sea.gmane.org> <20061204200349.GX47959@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 19:52:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M3yasEZuNUm+bj/T/kRo685npaBK2egXtuvkB7fPVcRmkVqA3V+91Ozi1XtHuj1CfA7/W88jRxEckGo2nkXoLppIsG2v/ZZ0PqeFVkfH6VQse3xuX/dkjeAxuR66hR9WjV6wp+d5O38ZAqsdMG5QcGcCGPZDbYuIBMzw28B1SgA=
User-Agent: KMail/1.9.3
In-Reply-To: <20061204200349.GX47959@gaz.sfgoth.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33233>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJrz-0002Gi-Fp for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937349AbWLDTwt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937354AbWLDTws
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:52:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:42493 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937349AbWLDTwr (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 14:52:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3104211uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 11:52:45 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr12586635ugj.1165261964683; Mon, 04
 Dec 2006 11:52:44 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id g30sm30617448ugd.2006.12.04.11.52.43; Mon, 04 Dec
 2006 11:52:44 -0800 (PST)
To: Mitchell Blank Jr <mitch@sfgoth.com>
Sender: git-owner@vger.kernel.org

Mitchell Blank Jr wrote:
> Jakub Narebski wrote:
>
>> Not true. Symlink HEAD still works, and we have even core.preferSymlinkRefs
>> configuration variable.
> 
> Yes, but it has to be a symlink pointing into "refs/", not just a regular
> file holding a hash value.  Which is fine for most purposes but sort of a
> pain for me.
> 
> I'll probably have it be a symlink to "refs/gitfs-dynamic" or something and
> then have "refs" be populated with that synthetic file and symlinks to
> any of the normal contents of the refs directory.  Not too bad, but will
> take a little bit of code.

You would have to wait a bit. There was talk on git mailing list about
allowing HEAD to point to non-head ref, or even bare sha1, only forbidding
committing to such HEAD (but allowing checkout of arbitrary revision,
not only branch, but also remote branch, tag, or branch~n).
-- 
Jakub Narebski
