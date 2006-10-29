X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 21:19:05 +0100
Message-ID: <200610292119.05626.jnareb@gmail.com>
References: <539418.62803.qm@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:19:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QBs/mbJsPAleiEUjmHYwCCSTFCQvWQ9sXqQPsNNIslacY1ULlEYH7I4cWCD+OWtODNuhgElmXBEoj7Z3YWSI47TBDoH32nEWYl2TVu8sF3TBSCBXhO/QJBw0APlTaQ8Ohfn4qjUwnc4DpgUqZ4jBiU8MRnVPl0NYnI91yC05uJs=
User-Agent: KMail/1.9.3
In-Reply-To: <539418.62803.qm@web31807.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30452>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeH7w-0002xk-IY for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965399AbWJ2UTX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965401AbWJ2UTV
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:19:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:51751 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965399AbWJ2UTU
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:19:20 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1009406ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:19:19 -0800 (PST)
Received: by 10.67.101.8 with SMTP id d8mr2994746ugm; Sun, 29 Oct 2006
 12:19:18 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id q1sm2361304uge.2006.10.29.12.19.18; Sun, 29 Oct
 2006 12:19:18 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> By the way, should we use quoted or unquoted filename?
> 
> For dear life, I cannot understand  *WTF*  is this argument about
> "quoted" and "unquoted".  Can this stop please?  PLEASE?
> 
> Unquoted, natural, normal.
> 
>     Luben
> P.S. I don't want to punish the good people who do not put \n or \r or whatnot
> in their filenames, just for this one ... "person" who does.  UTF8 is a different
> story.

The filenames which don't need quoting are not quoted. Only filenames
which need quoting (which have LF ('\n'), TAB ('\t'), \ ('\\') and " (\"))
are quoted and surronded in quotes to mark as quoted.

The only thing that is questionable is quoting files which have \ and "
and no other strange names.
-- 
Jakub Narebski
