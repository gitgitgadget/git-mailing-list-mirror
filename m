X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 19:57:48 +0100
Message-ID: <200611131957.48801.jnareb@gmail.com>
References: <45530CEE.6030008@b-i-t.de> <ej9utk$44p$1@sea.gmane.org> <200611131930.18300.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 18:58:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dcDyJ8AMW/OyatecJ+4dndPM/3yo5BgKIyTi/uEmiHeNtnbgkoT66956FcPO4XGgWonONMJoWTZSjtyYrgspNaBQNyyrWTTxPUbXBtlC393BhwIpQ+lzkf1o71ty91tKFVI75JKnahGrRom8cJ3PwAD2xmuszv2RXaoKnV35oGE=
User-Agent: KMail/1.9.3
In-Reply-To: <200611131930.18300.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31311>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjh0B-0005zl-7k for gcvg-git@gmane.org; Mon, 13 Nov
 2006 19:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755330AbWKMS4u convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755333AbWKMS4u
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 13:56:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:58860 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755330AbWKMS4s
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 13:56:48 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1171316ugc for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 10:56:47 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr8571474ugj.1163444206506; Mon, 13
 Nov 2006 10:56:46 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id a1sm6740524ugf.2006.11.13.10.56.45; Mon, 13 Nov
 2006 10:56:46 -0800 (PST)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Dnia poniedzia=C5=82ek 13. listopada 2006 19:30, Robin Rosenberg napisa=
=C5=82:
> m=C3=A5ndag 13 november 2006 15:20 skrev Jakub Narebski:
>> sf wrote:
>>> Thanks, Junio. Paths with umlauts are returned correctly now both i=
n
>>> UTF-8 and ISO-8859-1. I guess git-cvsserver is now as encoding agno=
stic
>>> as git core.
>>
>> By the way, now that git has per user config file, ~/.gitconfig, per=
haps
>> it is time to add i18n.filesystemEncoding configuration variable, to
>> automatically convert between filesystem encoding (somthing you usua=
lly
>> don't have any control over) and UTF-8 encoding of paths in tree obj=
ects.
>=20
> I'd prefer git to store filenames and comments in UTF-8 and convert o=
n=20
> input/output when and if it is necessary rather than forcing everybod=
y to=20
> take the hit. Most systems, but far from all, already use UTF-8 so it=
's a=20
> noop for them. The only reason I want conversion is for the years to =
come=20
> where we still live in two worlds of non-utf-8 and utf-8 and then for=
get=20
> about everything non-utf-8, rather than carry around the baggage fore=
ver.

That was my idea, to have i18n.filesystemEncoding configuration variabl=
e
to convert between filesystem encoding (which is usually something you =
don't
have control over, and which depends from place to place, but not from
repository to repository) and UTF-8 encoding git would store filenames.

--=20
Jakub Narebski
