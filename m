From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 02/10] gitweb: git_get_heads_list accepts an optional
 list of refs.
Date: Tue, 26 Oct 2010 18:30:04 +0200
Message-ID: <AANLkTim238K41oJAgXJiGMY0E_J_fzQ4b_ovNman2Agn@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1287917136-26103-3-git-send-email-giuseppe.bilotta@gmail.com> <201010252356.37472.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 18:48:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAmh0-00086G-G9
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 18:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759714Ab0JZQr6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 12:47:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61015 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760083Ab0JZQr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 12:47:57 -0400
Received: by pwj8 with SMTP id 8so700882pwj.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CXpdO7rUjUNUgwhzX7wy8OqQzudyiJQs/4PH4TM8594=;
        b=f2k8t3w8e05JutxO0m4BRQ4sTNbDKLrdVFkhWGQcjNy3M72lSsskVwZB0xtBmY+tRc
         1Csd+OzxbQXswMkS9gGl+GkzKUC6JyJXCKKbjkJolgA5few07XYE0lMfaVYIF2QBe2Rs
         YaVoE6MxCUf0WLYoCQUtxPtimOJBalirN75mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wCEhejl3bdwCH90BM11yHLtKwJ/ZWCO/7HmLacXYrprNQpQuW5Xwv9H8wAsk+WSgn3
         iCEde+ytFxlcMkn3rs4zwiHfmTHr97bRQn3Ef6mk7eS+sbfeRhUbxOt7GWynsqBKprVR
         DPvR+z/NX42BxodTFleGUbVCYWmLUvcvyAoXM=
Received: by 10.42.167.133 with SMTP id s5mr6597722icy.2.1288110988708; Tue,
 26 Oct 2010 09:36:28 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Tue, 26 Oct 2010 09:30:04 -0700 (PDT)
In-Reply-To: <201010252356.37472.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159999>

2010/10/25 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 24 Sep 2010, Giuseppe Bilotta wrote:
>
>> =A0sub git_get_heads_list {
>> -=A0=A0=A0=A0=A0=A0=A0my $limit =3D shift;
>> +=A0=A0=A0=A0=A0=A0=A0my ($limit, @classes) =3D @_;
>> +=A0=A0=A0=A0=A0=A0=A0unless (defined @classes) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $remote_heads =3D g=
itweb_check_feature('remote_heads');
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0@classes =3D ('heads',=
 $remote_heads ? 'remotes' : ());
>> +=A0=A0=A0=A0=A0=A0=A0}
>
> defined(@array) is deprecated at t/../gitweb/gitweb.perl line 3221.
>
> Should be simply 'unless (@classes)', or 'unless (scalar @classes)' b=
ut
> conditionals provide boolean context, which is scalar context.
>
> I'm sorry about missing it earlier.

No problem. Fixed for the next batch.

--=20
Giuseppe "Oblomov" Bilotta
