X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] for-each-ref: "creator" and "creatordate" fields
Date: Fri, 3 Nov 2006 04:27:49 +0100
Message-ID: <200611030427.49617.jnareb@gmail.com>
References: <200610281930.05889.jnareb@gmail.com> <200611022017.31351.jnareb@gmail.com> <7vmz79l0bi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 03:27:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HwzyW6Q0jeMhcxfXenZltwTZu6mCDAeDrhqaV+ILxPFWfp/hUyeAw5qvDTLlB0MMv1zK0yiN0+XXA92Ry4c+9sKOsu/HvCAjFBdcImj3wcSnqKp2YusVzf/biH9znYlzydRicW6M0RqByZk5LP1xLZ6+9AOhtovIVLiejmmi0Ik=
User-Agent: KMail/1.9.3
In-Reply-To: <7vmz79l0bi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30781>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfpiZ-0005cL-JQ for gcvg-git@gmane.org; Fri, 03 Nov
 2006 04:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753015AbWKCD1j convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 22:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbWKCD1j
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 22:27:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12975 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753011AbWKCD1j
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 22:27:39 -0500
Received: by ug-out-1314.google.com with SMTP id m3so312387ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 19:27:37 -0800 (PST)
Received: by 10.67.89.5 with SMTP id r5mr1975120ugl.1162524457775; Thu, 02
 Nov 2006 19:27:37 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id b35sm311825ugd.2006.11.02.19.27.30; Thu, 02 Nov
 2006 19:27:31 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dnia pi=B1tek 3. listopada 2006 03:40, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> From fa1a32c9a7c8a31b122df7d07f4a8885cbe120d0 Mon Sep 17 00:00:00 20=
01
>> From: Junio C Hamano <junkio@cox.net>
>> Date: Sat, 28 Oct 2006 13:33:46 -0700
>> Subject: [PATCH 1/2] for-each-ref: "creator" and "creatordate" field=
s
>>
>> This adds "creator" (which is parallel to "tagger" or "committer")
>> and "creatordate" (corresponds to "taggerdate" and
>> "committerdate").
>=20
> The first line should not be in the message.

I'm sorry. I just tried to send patch without changing authorship
(from yours).

--=20
Jakub Narebski
