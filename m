X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Mon, 11 Dec 2006 12:59:01 +0000
Message-ID: <b0943d9e0612110459y4009ce7fl44ceaa4bad33edf3@mail.gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
	 <200612110002.05847.jnareb@gmail.com>
	 <b0943d9e0612101524w3a2cccecqdd12023233e8ec0c@mail.gmail.com>
	 <200612110037.54309.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 12:59:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LRCFMnrygiOwBOk36jhlEAIMT1vDnOzM5kyEcWQErK9tuFk+2XT6QEQE4j+4j3jGdEVpkwin4Ued3YJiJUkpEbUyweIawOnJ1SQ+4dzKaIaETO5AjfpLr/cFN1rr8tJpkAjHXXSQSMnCstG22vEi/NUCEwDbN+FkU5QDw2XDRao=
In-Reply-To: <200612110037.54309.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33999>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtkkO-0006qL-AN for gcvg-git@gmane.org; Mon, 11 Dec
 2006 13:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762853AbWLKM7F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 07:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762886AbWLKM7F
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 07:59:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:64631 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1762853AbWLKM7C (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 07:59:02 -0500
Received: by nz-out-0102.google.com with SMTP id s1so779653nze for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 04:59:02 -0800 (PST)
Received: by 10.65.228.5 with SMTP id f5mr10846465qbr.1165841942086; Mon, 11
 Dec 2006 04:59:02 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Mon, 11 Dec 2006 04:59:01 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 10/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
> BTW. currently I use StGIT to manage a series of commits on feature
> branch which implements step-by-step single feature, and would be
> later send as a patch series. With StGIT I can work on final patch
> in series, notice that underlying feature developed in earlier patch
> (earlier commit) needs modification, so I do refresh, pop until
> given patch, change patch, push all, and work on patch.

Or, if you made a modification but you want it committed to an
underlying patch, use "refresh --patch" or "pop --keep; refresh".

BTW, if it's not clear for me how to initially structure a patch
series, I add everything to a patch and create underlying patches
afterwards and pick hunks from the big one (usually manually, though
native support in StGIT for this would be good, as someone pointed out
on this list). If all the hunks in the big patch were added to other
patches, pushing the big one should result in an empty patch
automatically (because of the three-way merging) and can be safely
removed.

-- 
