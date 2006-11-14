X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 18:15:23 +0100
Message-ID: <200611141815.24236.jnareb@gmail.com>
References: <20061114134958.5326.qmail@science.horizon.com> <ejcl6l$bo0$1@sea.gmane.org> <20061114154739.GB5453@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 17:14:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R3bFIAL+5YM6R5DNPm7FYwctJVGBZBkDGEqIzKBHhnv/Sczd+CW0gaDlcm2BWWyh0BzW7wemV8YpixrWQAK3iwzbnZcHYyw8PSjS5Vsd3cfLViA5fEOQQU/WlgjptwXHNFEzXL/sKteQSsPBT/5uppWwvPMjdmH76Bnmr4nFHyE=
User-Agent: KMail/1.9.3
In-Reply-To: <20061114154739.GB5453@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31352>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk1ro-0000sF-7F for gcvg-git@gmane.org; Tue, 14 Nov
 2006 18:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933458AbWKNROc convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933460AbWKNROc
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 12:14:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:20152 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S933458AbWKNROc
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 12:14:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so351123nfa for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 09:14:27 -0800 (PST)
Received: by 10.49.43.2 with SMTP id v2mr1372046nfj.1163524466027; Tue, 14
 Nov 2006 09:14:26 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id y24sm2498612nfb.2006.11.14.09.14.25; Tue, 14 Nov
 2006 09:14:25 -0800 (PST)
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m wrote:
> On 2006-11-14 15:53:18 +0100, Jakub Narebski wrote:
>=20
>> linux@horizon.com wrote:
>>
>>> Then you could check out an arbitrary version without any of the
>>> annoyance above; I could "git checkout tags/foo" or even "git
>>> checkout deadbeef~3". I wouldn't be on a current branch (which
>>> would necessitate changing "git branch" output), so HEAD would
>>> simply contain an object ID directly rather than being a
>>> symlink/symref.
>>
>> And what would happen if you want to checkout other branch? Where
>> the ID in the HEAD would go to? HEAD just _has_ to be reference to
>> _branch_.
>=20
> The id that used to be HEAD would not be saved anywhere. It would
> still be reachable from your refs, presumably, just like before you
> checked it out. (It would not be the case that you had made commits o=
n
> an unnamed branch that would now get lost, because the tool would
> refuse to commit until you had created a name for the branch.)

If HEAD would contain an commit ID directly, then you shouldn't be able
to commit at all. Not very useful, it is.
--=20
Jakub Narebski
