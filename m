X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add -v and --abbrev options to git-branch
Date: Fri, 24 Nov 2006 16:22:01 +0100
Message-ID: <8c5c35580611240722n6590f21av8b58a4e595dcb52e@mail.gmail.com>
References: <1164375910450-git-send-email-hjemli@gmail.com>
	 <ek6u2s$at4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 15:22:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sCFQXxFpwKswsJqmrc/19KUCNjvtgyLVpQ9WrRFnX6mB400nW4M2KTIPFd5OAwt+PVuHfUvSWA5eoiTn99zn8PP1Vam4/YB6YJhd43X35cOsawW8FSP9xPd0CPHIMz6ahyBoeKYsem6okq5a3y727VTzx0/qhjchsnUWU5go3rs=
In-Reply-To: <ek6u2s$at4$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32225>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncsT-0005Bt-Oa for gcvg-git@gmane.org; Fri, 24 Nov
 2006 16:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934646AbWKXPWE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 10:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934647AbWKXPWE
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 10:22:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:17402 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S934646AbWKXPWD
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 10:22:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1278265nfa for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 07:22:02 -0800 (PST)
Received: by 10.82.142.9 with SMTP id p9mr1598615bud.1164381721823; Fri, 24
 Nov 2006 07:22:01 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Fri, 24 Nov 2006 07:22:01 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/24/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Isn't what git-show-ref is about? Or git-for-each-ref?

Yes, there seem to be some overlap in functionality here :-)

The thing with git-branch is that it shows me which branch I'm
currently on, someting neither git-show-ref nor git-for-each-ref does.
And the "starred" branch, combined with hash and commit subject is
very useful for me (It reminds me where I am, and where I have been,
and what i did there....)

Finally, git-for-each-ref is more like plumbing, I wanted someting a
little more userfriendly

-- 
