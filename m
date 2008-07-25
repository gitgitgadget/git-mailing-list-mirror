From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT] Supported Eclipse version
Date: Fri, 25 Jul 2008 16:12:25 +0200
Message-ID: <4889DF49.3000903@gmail.com>
References: <48888A2E.4030302@gmail.com> <89D1384A-403C-4E6E-816C-204AE0AAC30C@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMO31-000830-7D
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 16:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbYGYOMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbYGYOMb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 10:12:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:37877 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYGYOMa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 10:12:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1251499nfc.21
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=c+5cprRdIB1ejZTgVTHRwkuPWIvvSNXQeGPmg2ffzFo=;
        b=LzrbjHdXan/nguws3klpYqhoI1PZsLu6JsR7pRW13LL21RkqB1N5zklJriye1s8f84
         pJDcsogJ3/XDdWinZ+k0JRkaskr06oAv4TMfmcRT2TuGfW/PC5Oby0pSUKvlxobp9f+N
         yEHcy1OrsXAwj0q6uqfIaHd3aB3zQKTAF+T0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kfOMZRLSdEKxg4fTpi2XIvbJ2Ez6Dp3MC0n5XamTtlEeUcHpR0Ea5GfDcq9tmlfhbt
         noRq9aw/6Kk/85F8Ec2YlvV124nD7hGeUlCJwazmLWgSD2px0pv4HPrvi0A6sn2B6yZ8
         ghOJ6WjzukxWJXRe7/DdMFU7B5Ga8K2/Vzex4=
Received: by 10.210.16.11 with SMTP id 11mr1979095ebp.187.1216995148928;
        Fri, 25 Jul 2008 07:12:28 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id f4sm38067762nfh.27.2008.07.25.07.12.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jul 2008 07:12:27 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <89D1384A-403C-4E6E-816C-204AE0AAC30C@yahoo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90052>

Jean-Fran=E7ois Veillette wrote:
>> Maybe some users (or developers) from mailing list can tell us about=
=20
>> their opinion?
>
> I think keeping comptability for one version behind the 'current'=20
> (still compatible 3.3 while 3.4 is the current) is a reasonable goal.
> 3.2 is relatively far behind, tools vendor had time to get up to date=
=20
> by now.
> If a user is using a third party version of eclipse based on 3.2, the=
n=20
> I guess he should not expect egit to work with it (he should just pra=
y=20
> and hope for the best).
>
> For myself, I use 3.3.x, I have not yet moved to 3.4 since my main=20
> plugin (WOLips) is not ready yet for 3.4.
>
> - jfv
I would also vote for this change. Especially if there are not many=20
users screaming that they need egit in Eclipse 3.2.

BTW, I'm using 3.4 version for 2 days and it looks really nice. What's=20
important, it seems to not be that buggy as early 3.3 releases were.

Robin, Shawn, would you accept next patches using 3.3 API?

Marek
