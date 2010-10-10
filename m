From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 11/14] daemon: report connection from root-process
Date: Sun, 10 Oct 2010 22:48:39 +0200
Message-ID: <AANLkTimZFzk6aV7SLZwQ=VP92Z3x_s3Q4dsQexLUSD6j@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-12-git-send-email-kusmabite@gmail.com> <201010102058.16773.j6t@kdbg.org>
 <AANLkTinz69u-hh-URqBrpdcrm+84N2BC7Ov4O8xeuW73@mail.gmail.com>
 <AANLkTinEmrHMfw0z=uwOs9FDRcta3gwcEvc1MBi+_7C-@mail.gmail.com> <AANLkTikqJKKSOS-X+d_hx0hyEdFmX3zNZBvZMV4qRMAp@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 22:49:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52pP-0005oq-JM
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0JJUtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 16:49:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35741 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0JJUtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 16:49:00 -0400
Received: by vws2 with SMTP id 2so573104vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=zN1wC4LrfvXbEfLlxF3xY8qVVWn53plbLPv0IG2j6fA=;
        b=qfLIQ+9veDI6PA5sLsKtwVHCzxKRnMGb8VssBX362PxOSZg3FSYU1GLPhQCl4x4ci4
         0P41YkOmuJ3onWOo3eaNyRAlo/n+LdvcG6NmiCY4YoEyCJDeSctl5xQH4cJghLddtkql
         jzASMjj0ADmKtitYXWWdtWiY8g9EHX9FxCuGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=O6B75qTsAWXXplwaCzcAQPAj/AyRWf42IqgfNnzRZJVmGxojyIlzLixfB09w9I8RzH
         715y6uLWllE6YVnAyUcTRyo5Hzv6kOqi2Jj3v/jo/NxGxu3shaWN/+8vXa0txWQXcueC
         KDJmsvKBefihCkbeLGntNOojyyiMj+6V/1NYc=
Received: by 10.220.160.4 with SMTP id l4mr1655582vcx.241.1286743739551; Sun,
 10 Oct 2010 13:48:59 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 13:48:39 -0700 (PDT)
In-Reply-To: <AANLkTikqJKKSOS-X+d_hx0hyEdFmX3zNZBvZMV4qRMAp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158704>

On Sun, Oct 10, 2010 at 10:14 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Oct 10, 2010 at 19:42, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>
>> -static int execute(struct sockaddr *addr)
>> +static int execute()
>
> Isn't execute(void) more portable?
>

Yes, it is. Thanks!
