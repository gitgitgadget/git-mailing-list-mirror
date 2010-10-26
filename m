X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Kynn Jones <kynnjo@gmail.com>
Subject: Re: Are "private blobs/trees" possible?
Date: Tue, 26 Oct 2010 12:56:07 -0400
Message-ID: <AANLkTinVcHK_qwqcPCecHuWXGsVdGhmy+6+eLOW1bLWQ@mail.gmail.com>
References: <AANLkTimQ7Z9Cd2yKw5jFD6UBzFRBZk_-SpC7jc6+JACw@mail.gmail.com>
	<1288037406.819.93.camel@drew-northup.unet.maine.edu>
	<201010252043.o9PKhN6I024622@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
NNTP-Posting-Date: Tue, 26 Oct 2010 16:56:18 +0000 (UTC)
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=kBPvilgIx5O4Jl+yh1VscrpsaLBA0hpRSHeV32LmrdQ=;
        b=pEbgwRSL4iScEz/1GaDqQ6ZoHHUvMDZtHXMFDhfSwB3621nbGOolRnno98d8jtVbjT
         hgZjUVy5yY8uOuUt3nWBva80rGhGAqQUIQv6LT4QU70A4Hfd5WaRSk8Ei8KAw5Wi4y0V
         L+A27qy55ofvRy/mwxMdMo7V+HxMvdkg8IGFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Um7uM65FTCC/BmKZg9amzAhOUot797vOyDYFJtOf4OsM1WeKboDCk0egpsZRvq1QLW
         5+KROaX3meWxPVghdE4HHwgj1G1HIMm6sooy6PVVw9hoTskKbGKg20CZQNw1HLQhO4ie
         2Rzw4SCQigzs+i+rE78Klek0nPPWfziMydAwU=
In-Reply-To: <201010252043.o9PKhN6I024622@no.baka.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1PAmop-0004JV-V5
 for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 18:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760065Ab0JZQ4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010
 12:56:10 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52835 "EHLO
 mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759628Ab0JZQ4J (ORCPT <rfc822;git@vger.kernel.org>); Tue, 26 Oct
 2010 12:56:09 -0400
Received: by qwk3 with SMTP id 3so2724266qwk.19 for <git@vger.kernel.org>;
 Tue, 26 Oct 2010 09:56:08 -0700 (PDT)
Received: by 10.42.76.73 with SMTP id d9mr6413225ick.454.1288112168504; Tue,
 26 Oct 2010 09:56:08 -0700 (PDT)
Received: by 10.229.232.83 with HTTP; Tue, 26 Oct 2010 09:56:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org

Actually, it occurred to me after posting that the symlinking is not
necessary.  As long as the private directory is ignored, then it can
have its own independent (and purely local) git repository.

But I'll look into the multi-repo management system that Seth mentioned.

Thanks!

