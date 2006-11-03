X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 12:56:24 +0000
Message-ID: <b0943d9e0611030456w3de91550s3901ae7b187e086e@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
	 <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	 <20061102113631.GA30507@diana.vm.bytemark.co.uk>
	 <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
	 <20061103095859.GC16721@diana.vm.bytemark.co.uk>
	 <20061103100142.GD16721@diana.vm.bytemark.co.uk>
	 <20061103102119.GO20017@pasky.or.cz> <454B1BC3.1070203@op5.se>
	 <20061103105349.GA18651@diana.vm.bytemark.co.uk>
	 <7vslh0bwsm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 12:57:00 +0000 (UTC)
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B7U7i+6mhOexvRihBOclAE769zt21XD1fI9O6GTjAI4z5qrI4jg10TGD73Vu6k2KsSfFET70aPEryOzpnkB0sCg7uJN2EWUPYY8/1lz0j7DemhGu25ak+t+SjvE8AvYwqmVGffth0rBDjbP+pXJmGnVvpm3NTe5MdEyorIWX8/s=
In-Reply-To: <7vslh0bwsm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30845>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfyaz-0003Tn-Hh for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751676AbWKCM40 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbWKCM40
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:56:26 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:12669 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1752787AbWKCM4Z
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:56:25 -0500
Received: by py-out-1112.google.com with SMTP id a73so312074pye for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 04:56:24 -0800 (PST)
Received: by 10.35.62.1 with SMTP id p1mr3287816pyk.1162558584461; Fri, 03
 Nov 2006 04:56:24 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Fri, 3 Nov 2006 04:56:24 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 03/11/06, Junio C Hamano <junkio@cox.net> wrote:
> I wonder if this can be solved by simply reusing the machinery
> format-patch already has.  If calling it as a standalone script
> does more unnecessary things than what StGIT wants, we should
> certainly be able to separate the only necessary part out to
> suit StGIT's needs.

I would like to keep the e-mail templates feature which is not
available via format-patch. The reason is because I also send patches
to the ARM Linux maintainer via a patch tracking system which expects
the messages formatted in a strict certain way
(http://www.arm.linux.org.uk/developer/patches/info.php). It would
probably be easier to fix StGIT than modifying format-patch.

-- 
