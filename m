From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Mon, 10 May 2010 07:43:55 -0400
Message-ID: <AANLkTilDiP_5Q9HrssB0lyf-jsE8LAF2ULGwEMO4BzdQ@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
	 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
	 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
	 <20100509070043.GB14069@dpotapov.dyndns.org>
	 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
	 <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
	 <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com>
	 <AANLkTikg7Tc6zJvfBELBQoeAxebFenNLivEs92j8c83D@mail.gmail.com>
	 <91F47297-A1B5-4AE5-8835-E3A8E452FB8A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 13:44:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRPB-0003Sq-TS
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922Ab0EJLn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 07:43:59 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:52280 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab0EJLn5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 07:43:57 -0400
Received: by wwa36 with SMTP id 36so1465659wwa.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ywP50B0fRCg6pQP4JcoRF+2l+jtYv6zcPfnXMMrpn+k=;
        b=Xs8L6q5pL94FfXgQODQSLbb9tTiTRsXcG+Q1jT2C9c3my4w1keoPpucRzYuqHU6lbv
         9ed+RPc9MAaYznMpoOFnzTmAj8eACt8IiKbqvftsOt8IvZaUKSH9zOViDOiyXK6PMTmy
         DQLVvGTXbGbscXKVNgGSyce5cOXBLgYLRGxXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cn6Gq/ZC4fwB3kAR8HmgpY2wKP5LduUN/AWy3vGh0u8OGBNcl3IDIDATnTZuuGTDmK
         NK1XxzuX7Far7nMIFOLnrjLf9rzTaVMzsgkBTEYSWdjNwwzuCMPsnRG6pgwfKwfV4t5O
         AZdMhjFCDgAPEa+4ZFGi9nzsLv1MTogRaJZVk=
Received: by 10.216.85.7 with SMTP id t7mr1037932wee.114.1273491836026; Mon, 
	10 May 2010 04:43:56 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Mon, 10 May 2010 04:43:55 -0700 (PDT)
In-Reply-To: <91F47297-A1B5-4AE5-8835-E3A8E452FB8A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146802>

On Mon, May 10, 2010 at 12:33 AM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> On 9. mai 2010, at 22.46, Robert Buck <buck.robert.j@gmail.com> wrote=
:
>
>>> No, "auto" means to enable normalization for files git doesn't iden=
tify
>>> as text files, "true" means to always normalize, and "false" means =
never
>>> normalize.
>>
>> I probably missed something. The part that confuses me in this
>> statement is that you said "for files git doesn't identify as text
>> files". The convert.c source is the heart of this, and if a file is
>> not identified as text it is presumed to be binary. The statement ma=
de
>> seems to imply you'd auto-convert PDF files? I know you did not mean
>> that, but it could have been read that way.
>
> Doh! I meant to write "files git _does_ identify as text files". Sorr=
y for
> the confusion.
>
>> What specifically happens in the three modes? Would it be precise to
>> say the following?
>>
>> =C2=A0 "Files subject to EOL conversion are those that are explicitl=
y
>> identified through attributes to be text files, or those
>> algorithmically determined to be text files which happen to not bear
>> the "text" file attribute. Otherwise the default value, "false",
>> applies and no EOL conversions occur."
>
> Very close, but my thinko threw you off. The "algorithmic determinati=
on" of
> text files is only performed when crlf=3Dauto, either by the attribut=
e or the
> config variable being set that way.
>
> The point of the "core.crlf" config variable would be to provide a de=
fault
> value for the "crlf" attribute.

Okay, so that makes sense...

   "Files subject to EOL conversion are those that are explicitly
 identified through attributes to be text files, or provided core.crlf =
is
set to auto, those files algorithmically determined to be text files
which happen to not bear
 the "text" file attribute. Otherwise the default value, "false",
applies and no EOL conversions occur. When conversions occur the EOL
character changes from the internal LF format to the format specified
by core.crlftype."

This would work out well if file type maps were ever introduced. Type
maps would not short circuit the explicit attributes identified by the
first clause, then for those files without attributes you'd check the
file-type maps, then fall back to the algorithmic if auto is enabled.

I like that.
