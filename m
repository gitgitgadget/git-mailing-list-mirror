From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 08 Oct 2009 08:58:22 +0200
Message-ID: <4ACD8D8E.3060606@gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 09:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvn15-0007it-0B
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 09:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbZJHG7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 02:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZJHG7K
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 02:59:10 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:46955 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbZJHG7J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 02:59:09 -0400
Received: by ewy4 with SMTP id 4so2605332ewy.37
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=P8nzXEFvCCS1eRMQAdesMVNlFp+UFZEoyA2OwBF9h8U=;
        b=VCBzLmM+h2rA1H9D/xWcrLAREaeHk0QZqu66r1C24Ofqhf72S915+IsHALRtv4GROB
         GDzAOvEG4SHOQuosKUOyndz05LHsk1Cr6wNdetS//vWZ2Idrd2PSv98wwvIJIhXw4HEF
         cUxMcBDSXHR81QwfksfNUN3Uvbe9uUu9lf5QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=H9a8JNhGY4YY4yr+VMMnLdzzfLbIT55ywQHm+KXfx4e1moh7xYaQYyitaXx7bjZ9qZ
         lxyFzkcTRRXHRiaJx69Gcjt2Pfa2ZtYQQuUt0UvLfoTabTRIYEsKeuI/3264vrtajWez
         QHnyymRH8Rlf/UNfSTl1iBd/+aUy6YMYQiyns=
Received: by 10.211.129.8 with SMTP id g8mr1005549ebn.71.1254985112130;
        Wed, 07 Oct 2009 23:58:32 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm1614389eyg.35.2009.10.07.23.58.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 23:58:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129678>

Junio C Hamano said the following on 08.10.2009 08:33:
> * ef/msys-imap (2009-10-03) 7 commits
>  - mingw: enable OpenSSL
>  - mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
>  - imap-send: provide fall-back random-source
>  - imap-send: build imap-send on Windows
>  - imap-send: fix compilation-error on Windows
>  - imap-send: use run-command API for tunneling
>  - imap-send: use separate read and write fds

Don't forget about the MSVC patch ontop of this series:
Message-ID: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com>
Subject: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto

--
.marius
