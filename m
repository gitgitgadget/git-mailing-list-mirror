X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Seeking git recipe to grab a single file
Date: Wed, 6 Dec 2006 22:51:39 +0100
Message-ID: <81b0412b0612061351v16aa6b94q8dce9404a5b2675a@mail.gmail.com>
References: <4577348E.4090105@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 21:51:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dTtnxbP6Whjia+8tXwXZOaMfHy/wUQImCT5jmLJgi6iiCckzCs0b9gZuMeizUYACou8HEflf5NwlYGA0IE+t6mW4Odk9IdP2lNQ2gNEE3RnOv0UudkNzRycsLI+sJJO/FhlPiZUfOtVCg68RFhW+QOg8LndErrYkt5E8vom7ka0=
In-Reply-To: <4577348E.4090105@firmworks.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33527>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4g3-0005dj-TL for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937685AbWLFVvl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937686AbWLFVvl
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:51:41 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:46289 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S937685AbWLFVvk (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 16:51:40 -0500
Received: by nz-out-0102.google.com with SMTP id s1so228312nze for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:51:40 -0800 (PST)
Received: by 10.78.180.18 with SMTP id c18mr1009014huf.1165441899061; Wed, 06
 Dec 2006 13:51:39 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 6 Dec 2006 13:51:38 -0800 (PST)
To: "Mitch Bradley" <wmb@firmworks.com>
Sender: git-owner@vger.kernel.org

On 12/6/06, Mitch Bradley <wmb@firmworks.com> wrote:
> I want to grab a single file from a remote git repository into the
> current directory, which is not a git tree.  Is there an easy way to do
> that?  I have tried using git-fetch and git-cat-file, without success.

If the remote repo has a gitweb interface than it's simple:
wget 'http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;h=0451f69353bad4d07de34fd4658f40b805bd467a;f=Kbuild'

Otherwise, there is no simple way to do it yet.
