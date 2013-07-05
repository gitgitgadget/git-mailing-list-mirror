From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 5 Jul 2013 18:06:46 +0530
Message-ID: <CALkWK0kfp3RWqm+v4zwKxSF=GxVJ0Bpw0-Qidc7u7-NDKUKu0A@mail.gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com> <CAPig+cReC8TnU0P3-qgeXGeyV=tHaHpa1Cz6r3AAZDw2ZH6B_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:37:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv5GV-0003k0-DA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326Ab3GEMh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:37:27 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44130 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050Ab3GEMh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:37:26 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so5155421iea.4
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hzuaJ6FxnMKsRzedfQqm7BefHnS2P/il0Nncvhl1NN4=;
        b=sIdpsvoDPXbOeTJWyMkHRgn+Scwbuvda1eW5g+ZNYPpH2E2dwRvH3v9WUZws+Q7ct8
         XzZ1UYl60hHqLCkfyyhIWXbNYsFqXDqgUF+0i10QM6S8PDxJs5FoogSzosFV86sFiCiS
         Kq4aibrk0ip5vFhIvZJVrG4dBclzSV4wB44e7B7scfGY7OC1LXfXsE1Pq/sEWrdv5SUj
         Hu4uEoo89A6erEPj2HAdOGA4bDwXLmPgHXjyxmiRLfne6jcn8xIvIzKdmSpkewbKKWv5
         iKuaY6R99tPgRGSVB4odHrm9rl+mH9uyVX4smu8bk6BAfrKlidN93PExguhjnqQGeHK3
         o+pQ==
X-Received: by 10.50.47.12 with SMTP id z12mr4427978igm.50.1373027846291; Fri,
 05 Jul 2013 05:37:26 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 5 Jul 2013 05:36:46 -0700 (PDT)
In-Reply-To: <CAPig+cReC8TnU0P3-qgeXGeyV=tHaHpa1Cz6r3AAZDw2ZH6B_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229661>

Eric Sunshine wrote:
>> +                                       $smtp_ssl_cert_path |= "/etc/ssl/certs";
>
> You're going to want to use logical ||= here. Bitwise |= on a string
> does not do what you expect[1]:
>
>   my $s = '/usr/local/etc/ssl/certs';
>   $s |= '/etc/ssl/certs';
>   print $s, "\n";
>
> Outputs: /uws/oooowts/ssl/certs

Thanks; much appreciated.  My Perl is quite weak.
