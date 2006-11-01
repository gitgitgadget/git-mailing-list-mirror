X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matt McCutchen" <hashproduct+git@gmail.com>
Subject: Re: How to view an old revision?
Date: Wed, 1 Nov 2006 09:37:50 -0500
Message-ID: <3bbc18d20611010637s6d05aecbt98322b62cf7235e8@mail.gmail.com>
References: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>
	 <4548AFA2.1040606@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 14:38:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=M5s5e+Rt3d8i5y9h0qwobHlMflz6c10BPyKhAkBp+Sn+S8EsmbVJpmSG0MhO0mS1ue+oX+2Go4wubnjnIp2k/4zRgqWO+sW8sy5mVSdhKxbZewsPBF1NjA3Dd21HoR2v8UlPPZmWYWgGheEQdrLu9yy7xwE2Pr+9oGfUVjQpQqo=
In-Reply-To: <4548AFA2.1040606@shadowen.org>
Content-Disposition: inline
X-Google-Sender-Auth: c474df846804b534
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30640>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfHEd-0001gb-QR for gcvg-git@gmane.org; Wed, 01 Nov
 2006 15:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992509AbWKAOhx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 09:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992518AbWKAOhx
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 09:37:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:1871 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S2992509AbWKAOhw
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 09:37:52 -0500
Received: by nf-out-0910.google.com with SMTP id c2so853993nfe for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 06:37:50 -0800 (PST)
Received: by 10.82.105.13 with SMTP id d13mr1484436buc; Wed, 01 Nov 2006
 06:37:50 -0800 (PST)
Received: by 10.82.129.2 with HTTP; Wed, 1 Nov 2006 06:37:50 -0800 (PST)
To: "Andy Whitcroft" <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

On 11/1/06, Andy Whitcroft <apw@shadowen.org> wrote:
>         git cat-file -p <commit-ish>:<file>

Nice!  Thanks!  I had guessed "git cat-file -p <commit-ish>/<file>"
but didn't try a colon as the separator.  The colon syntax ought to be
mentioned in the git-cat-file man page.

