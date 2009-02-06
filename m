From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 1/6] gitweb: channel image in rss feed
Date: Fri, 6 Feb 2009 11:55:19 +0100
Message-ID: <cb7bb73a0902060255i6645fc25wf16755a866ab7a42@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902042356.34407.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOO8-0007O3-3Q
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbZBFKzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 05:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZBFKzV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:55:21 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:63859 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZBFKzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:55:21 -0500
Received: by ewy14 with SMTP id 14so1218559ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 02:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ENK/JQaAOvrMDFk8N00MGnZVu1B8cOz5DzpSfVHozf8=;
        b=hl3utQt1Uyg9Ec8X8m+bv0LRWvcRzyoaFqMfgmOTGFZtONmvoWFc0+rILhu5G0WMwY
         zeWZL4U/8PU1poLLyN40G/nmphrd1mZ7YEihKzNxR7QqGb+/l8O1I/wIDYVFFzSEUUfy
         6ujF3fWYF08tO06/3VlBiuSAlBpmVYgA78lMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pr68hNOjurGG13ejUrsNfNx+sC3owuxbukjqtbJ/JamvyiWLe5hYPoExsARgFki32k
         AeY322QqFenY/93+hY0F9utCYL1lGnRf7fH9a2kymeuu88hcghGJaZGQrY+iW8IBEYSW
         N1gmJybFZgKZg+1WGPPWa4J0E0viuZy0B3x68=
Received: by 10.210.92.11 with SMTP id p11mr1235829ebb.24.1233917719258; Fri, 
	06 Feb 2009 02:55:19 -0800 (PST)
In-Reply-To: <200902042356.34407.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108678>

On Wed, Feb 4, 2009 at 11:56 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> +             if (defined $logo || defined $favicon) {
>> +                     # prefer the logo to the favicon, since RSS
>> +                     # doesn't allow both
>> +                     my $img = esc_url($logo || $favicon);
>> +                     print "<image>\n" .
>> +                           "<url>$img</url>\n" .
>> +                           "<title>$title</title>\n" .
>> +                           "<link>$alt_url</link>\n" .
>> +                           "</image>\n";
>> +             }
>
> A question: how should URL, which is _contents_ of a tag (instead of
> as _attribute_ value), quoted (escaped)? I don't think it is specified
> in RSS. I guess that using esc_url() is a safe solution.

Indeed, it might not be needed, but it's doesn't do any damage to
escape the URL.

-- 
Giuseppe "Oblomov" Bilotta
