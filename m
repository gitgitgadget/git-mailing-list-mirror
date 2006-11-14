X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: when is a remote a branch?
Date: Tue, 14 Nov 2006 21:36:16 +0100
Message-ID: <200611142136.17517.jnareb@gmail.com>
References: <ej7fra$8ca$2@sea.gmane.org> <200611121831.18851.jnareb@gmail.com> <20061114202835.GJ7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 20:36:54 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MdAXmULxqueZQ2efQgX88UQ6yheDnpIq5hVHG5slPECAZbt+lkM9oGxnSZ13meubTOMsQ+6Zyg2DhowQSnO7ekNJJ4eXKIr2utIPaYXyHfTjdO6Ars2ZeH9b24nKAHKktQsPnjoCvdi1IU/dCpiMv3LzGqJMYPBAu+rLyeP+KQk=
User-Agent: KMail/1.9.3
In-Reply-To: <20061114202835.GJ7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31370>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk51A-0000gb-Kx for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966339AbWKNUfm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 15:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966345AbWKNUfd
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:35:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:54884 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966340AbWKNUfS
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:35:18 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1446120ugc for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 12:35:17 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr1484688ugl.1163536517255; Tue, 14
 Nov 2006 12:35:17 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 53sm6970557ugd.2006.11.14.12.35.16; Tue, 14 Nov
 2006 12:35:17 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr "Pasky" Baudis wrote:
> On Sun, Nov 12, 2006 at 06:31:18PM CET, Jakub Narebski wrote:
>>
>> By the way, with introduction of branches and remotes in config file,
>> you can say:
>>  [branch "localbranch"]
>> 	remote = someremote
>>  [remote "someremote"]
>> 	fetch = remotebranch:localbranch
>> 	push  = remotebranch:localbranch
>> 
>> and that would be equivalent to example branches file from
>> the beginning of this email.
> 
> According to the documentation, this is not really useful since this
> just tells what should git fetch default to when on branch
> "localbranch". But "localbranch" is still just a branch representing a
> state in a remote repository, so you should never be _on_ it in a sane
> setup, but instead on a different branch which tracks it.

Oh. Can you "git fetch Localbranch" _without_ repository named 
"localbranch" in above case?
-- 
Jakub Narebski
