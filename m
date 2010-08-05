From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 01/12] t6038 (merge.renormalize): style nitpicks
Date: Thu, 5 Aug 2010 11:41:36 +0000
Message-ID: <AANLkTikv3oYapOVWmxkt2eqwGWQKMAQOCmruShSiHjKv@mail.gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
	<20100804031935.GA19699@burratino>
	<20100804032338.GF19699@burratino>
	<7vocdifdrk.fsf@alter.siamese.dyndns.org>
	<20100805110822.GB13779@burratino>
	<20100805110933.GC13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:41:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgypT-0002Zf-Ol
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760180Ab0HELli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:41:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44556 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760155Ab0HELlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 07:41:37 -0400
Received: by iwn33 with SMTP id 33so106020iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TLyWqBLBYiu07iiYPzERH+2sF5KfrlBW/SOW5v4D1aA=;
        b=ukvRVoqbN+Ue7PJev3PJNbVPV+bzZQVokRoPCYJODQFFssRUvME6BlMLx9cN5+thfn
         LAYUWZghbJ2SpvDfbPmxUdW5WO3g7Dd8IshGCyJgxnOAAX49bF3huWgZJYuSix9OFiS6
         8t3ovNTeGi6MFUqRyyFQjJ7omoeCm3RftBGJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZVKOLNM2Ovj87WNysHFBJ4aQkc1Lh51uJlT6hHvwCZFsNuNmsBvvAVCSQisTthf1cA
         H5w44tZvU1ndUOx1/g3Ri2FPApC0/WkIrJnQ/drYpenybvPKc1WwbKEh/XCDvtrZ3iMd
         4D6HtaMtFZfqQUyXJHJn4C6sEtKzXiG4GvouY=
Received: by 10.231.33.73 with SMTP id g9mr11427430ibd.117.1281008496408; Thu, 
	05 Aug 2010 04:41:36 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 5 Aug 2010 04:41:36 -0700 (PDT)
In-Reply-To: <20100805110933.GC13779@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152645>

On Thu, Aug 5, 2010 at 11:09, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Some tweaks to simplify adding and running tests.
>
> =C2=A0- Use test_tick for predictable, sort of realistic commit dates=
;


> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout side &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo same line | append_cr >>file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo same line >>control_file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file control_file &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "add line from b" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git tag b &&

=46WIW this looks like it could use Dmitry's "test-lib.sh: introduce 4t=
h
argument to test_commit() specifying a tag name" patch. Maybe that
goes for most of these git add/tick/commit/tag combos, i.e. they don't
really need $commit_message !=3D $tagname.
