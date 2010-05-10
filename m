From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control  end-of-line conversion
Date: Mon, 10 May 2010 06:33:24 +0200
Message-ID: <91F47297-A1B5-4AE5-8835-E3A8E452FB8A@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com> <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com> <AANLkTikg7Tc6zJvfBELBQoeAxebFenNLivEs92j8c83D@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 06:34:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBKhK-0004oC-L9
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 06:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab0EJEcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 00:32:42 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:38637 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab0EJEcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 00:32:41 -0400
Received: by ewy20 with SMTP id 20so781458ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=LCzUyZTNcTJuiCcbIpQjdccevT42zpw473mFKV3RC9k=;
        b=nhwOvQRPi9NlFny2eeaqV816HI4KSMvL08hZSEoJ/dXriPcZt6yFpy0BzVXKRuUFUe
         cC1kqX2mhcBF5jAr93WhtR0K3Pr8XaGUwAee1QY5ntHfUCtG95zFQ0dnvAPtrzqZ9YfZ
         zI63YW0Y8OngVIzvg5+xiTE+AsusZBgHXxdvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=tRQL5SyCFlO9TZ0UEzSL3bY834aIQIkaoVdjXqtZcC2NfAXonUBXltpvKrlMCfbIP6
         og44N5iam1WHFTgEH0hL3+sS7EcfZhp2fvBI7BKico/F1OiOnkADF24oPvz6uKcDkLLl
         fPtWzxp+8BD/ZRwonJ5xv1UyydmJsiCXtNH3U=
Received: by 10.213.68.77 with SMTP id u13mr1099742ebi.9.1273465959695;
        Sun, 09 May 2010 21:32:39 -0700 (PDT)
Received: from [172.16.3.207] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm2312568ewy.4.2010.05.09.21.32.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 21:32:39 -0700 (PDT)
In-Reply-To: <AANLkTikg7Tc6zJvfBELBQoeAxebFenNLivEs92j8c83D@mail.gmail.com>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146757>

On 9. mai 2010, at 22.46, Robert Buck <buck.robert.j@gmail.com> wrote:

>> No, "auto" means to enable normalization for files git doesn't  
>> identify as text files, "true" means to always normalize, and  
>> "false" means never normalize.
>
> I probably missed something. The part that confuses me in this
> statement is that you said "for files git doesn't identify as text
> files". The convert.c source is the heart of this, and if a file is
> not identified as text it is presumed to be binary. The statement made
> seems to imply you'd auto-convert PDF files? I know you did not mean
> that, but it could have been read that way.

Doh! I meant to write "files git _does_ identify as text files". Sorry  
for the confusion.

> What specifically happens in the three modes? Would it be precise to
> say the following?
>
>    "Files subject to EOL conversion are those that are explicitly
> identified through attributes to be text files, or those
> algorithmically determined to be text files which happen to not bear
> the "text" file attribute. Otherwise the default value, "false",
> applies and no EOL conversions occur."

Very close, but my thinko threw you off. The "algorithmic  
determination" of text files is only performed when crlf=auto, either  
by the attribute or the config variable being set that way.

The point of the "core.crlf" config variable would be to provide a  
default value for the "crlf" attribute.
-- 
>
Eyvind
