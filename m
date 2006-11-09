X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: Shallow clone
Date: Thu, 9 Nov 2006 09:47:20 +0530
Message-ID: <cc723f590611082017m1104fd66o595ec9db144cb2ce@mail.gmail.com>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	 <45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
	 <7vac31p8om.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 04:17:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RdLgfry3CdGyjxWzo0T2JyR2Otrd6xuaLcx3VIybyfnNwtF1AJaIKmChn9P3qlCnI+2eeESeGCuFf4xopvNtiotW45A9I9fvPwiYPC/HN4oRLVw1CUSpfXrcMFU218XLPKAm9kt0NW6wh6wiUZ9eEse6Wsp4uiXmKrg35QAVTpY=
In-Reply-To: <7vac31p8om.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31181>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi1Ly-000099-QC for gcvg-git@gmane.org; Thu, 09 Nov
 2006 05:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424039AbWKIERX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 23:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424044AbWKIERX
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 23:17:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:33338 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1424039AbWKIERW
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 23:17:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so911350nfa for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 20:17:21 -0800 (PST)
Received: by 10.49.19.18 with SMTP id w18mr3386633nfi.1163045840988; Wed, 08
 Nov 2006 20:17:20 -0800 (PST)
Received: by 10.48.212.18 with HTTP; Wed, 8 Nov 2006 20:17:20 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/9/06, Junio C Hamano <junkio@cox.net> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
>
> >
> But it seems to need some more work.  I just tried to clone
> git.git with --depth=1 and it cauterizes each branch with two
> commits (I think that is what depth=1 means -- the latest and
> one behind it), but it pulled almost the whole repository
> anyway, and it turns out that "git log v1.4.3-rc1" gives me the
> full history leading to it.
>
> Subsequent "git fetch --depth 99999" makes the branches
> connected to the root commit, and I am reasonably sure we do not
> have that many commits, but .git/shallow did not become empty.
>

I tried a local clone with --depth 2 and it showed two commits
in all the branches/DAG. But then doing a  pull --depth 4 listed more
commits than 4. I didn't look much into this.

