X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Thu, 2 Nov 2006 10:32:46 +0000
Message-ID: <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
References: <20061101090046.1107.81105.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 10:33:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xt2Edr4BQS1igr/VSceY//jRDB2f5qlN1iBIInyR4hvQsWrViE2ipbSg4km4GgO+wXbG5eqM3+qYdQd40CX+G+sqaU3eLk9t/bcUFW09CYq4DAdumAUtPCUgWpm1n+FcYdsBpX8VaS49i4PpA2GZaJzvGB9nhD2MX5g5OeN2leU=
In-Reply-To: <20061101090046.1107.81105.stgit@localhost>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30704>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZsR-0003dW-Ur for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752082AbWKBKcs convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 05:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbWKBKcs
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:32:48 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:2265 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1752082AbWKBKcr
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 05:32:47 -0500
Received: by py-out-1112.google.com with SMTP id a73so76220pye for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 02:32:46 -0800 (PST)
Received: by 10.35.112.4 with SMTP id p4mr559528pym.1162463566577; Thu, 02
 Nov 2006 02:32:46 -0800 (PST)
Received: by 10.35.77.5 with HTTP; Thu, 2 Nov 2006 02:32:46 -0800 (PST)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 01/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> This adds a new flag to 'stg mail', allowing the user to hand-edit
> each patch e-mail before it is sent, just like it is currently
> possible to edit the cover message.

Applied it but with some conflicts since you have some other patches
which I haven't merged yet (like QP encoding). I'll try to have a look
at this QP encoding this week. The main problem is that Gnus shows
plenty of "=3D20" instead of new lines and 'stg import' cannot cope wit=
h
them.

Thanks.

--=20
