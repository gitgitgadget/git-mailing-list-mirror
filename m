From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sat, 1 Mar 2008 18:27:17 +0800
Message-ID: <46dff0320803010227r5024d152g259a6a07a2441351@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 11:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVOwe-0003vM-32
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 11:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbYCAK1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 05:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755768AbYCAK1S
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 05:27:18 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:57218 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYCAK1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 05:27:18 -0500
Received: by an-out-0708.google.com with SMTP id d31so1001847and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 02:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w0MX4pdK6rPEdzA8tR2fneAalxYqvCCG4XpN0f8cOAQ=;
        b=eDNXvBUddy6c0Oxct4dGV4ervKDMKr8+s1kIM3qBoCfcqrvoFnxfmKRklFisKdRZSro1DaK85zkQcCNJZdYuFyuJuQcRPzx0ZOJ7MFJ2ZA7Qzitrb4vqZ6+yEOIzlmM4uaU2wNQRfmjvN0YEbx7gkkjPutPzdEdRN86mkSnIIgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WQW/CXwLqHVN/KvPeOhwitHctYQX9lYYOEHgC6m6y2xXCI0D2TiHBu7JniZ8++C1YmjEPyytzcJIx0flIW2t2/9/PQirLIm6laEm9OT6GdXaATwMBvv2uQNp+2YEDQYF7H7+1nwBbHKXL+IZ621xbgvSr5ql1D5mG7r18vrQNUs=
Received: by 10.100.254.18 with SMTP id b18mr22292963ani.21.1204367237086;
        Sat, 01 Mar 2008 02:27:17 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 02:27:17 -0800 (PST)
In-Reply-To: <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75649>

>
>
>  > +             grep '^:160000\|:[0-9]\+ 160000' |
>
>  This looks troublesome.
>
>   - [0-9] is obviously wrong and [0-7] is what you meant;
>   - \| and \+ are not BRE but GNU.
>
man grep says
 In  basic regular expressions the metacharacters ?, +, {, |, (, and )
lose their special meaning; instead use the backslashed versions \?,
\+, \{, \|, \(, and \).

Doen't it mean that '\|' is BRE ?


-- 
Ping Yin
