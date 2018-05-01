Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC556215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755657AbeEAMRz (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:17:55 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35103 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755271AbeEAMRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:17:53 -0400
Received: by mail-pf0-f182.google.com with SMTP id j5so9018906pfh.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qBBeLeVoqh2pg2zj1/0ypLJRt8EMr8k+daSWguA2COM=;
        b=FdZ1kB3ItJU+Vc8IkfwlRCYtB74xKfDvgKi+R8EjQszzxXwaS3RwG5iGpB80EbkibP
         0nzbphfZNcPXQWQf6Pb29bYr4IipfFIknnIBcRDNtLTbIXjGNCgwXzukm8BM1zxsUENp
         VlvuFrNxITaGMS7HhT+UQStIWW8wgbM782Q3ALSbfzMkNcMn8EuZ1+YG6NUwKR/Htbt/
         DXpDsrZnC0z7BF9ElevTeVl9GePhOb3keyLkTSmS2PeZX8tusVQ+Xevp9BfX/bGwMWlQ
         Z/gN/jIZXv8Fc6ph/MA/VYd90ws6Ej5zzCoXa6npPEaNyN3wy078ZKDS2CkDNe+JYOyR
         c4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qBBeLeVoqh2pg2zj1/0ypLJRt8EMr8k+daSWguA2COM=;
        b=czLMik6tlz6LwHEbFeRhWegxOKWQmQwjqx6UbDanxvAym0vMBjJWBru0h4N2+Pp1DI
         XptpHzZ8ta9AMcNIdS3yuO+5TZcdTnoCWZon7MG56vVlDveQQeNeGKublF+iagEEtCTM
         9w5iaccsJVNSjXDpq4mWxGpw+swlT9OskyzEJxrTEa4LuvfRMRbdPeAIxlFpw3WAl1Rw
         O72mcbKJEZn+BdRHTgi6moS4Bs4jU3+nrSgQ3Kz2egooBySrjX2dJ07snY3dj3jAx24L
         qkCUD9Aijm3rhu9xFPzF8WcoZJw7XO/Z52ShZuV9H/eTGz9YQYO/U5oN3gC1tAcX/dcD
         CK7Q==
X-Gm-Message-State: ALQs6tD8k0w7m9GsB8NsoLABohjKU1OpI9iWqw+ebhZ25Q8RPqLcAjqM
        /HoTNYaYo4i9X95Jkd/xXH2UoeSvac8KynIu3OjAHQ==
X-Google-Smtp-Source: AB8JxZoidV0ypwv1oJtWEgJrWpgxJA4yQga61VABbc2dNNlLRz/L5b1MhBes2vutpnyOqtE6mm+/JMIaJO3k/Pf7kMM=
X-Received: by 2002:a63:9401:: with SMTP id m1-v6mr12883456pge.140.1525177072484;
 Tue, 01 May 2018 05:17:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.184.67 with HTTP; Tue, 1 May 2018 05:17:51 -0700 (PDT)
From:   Pascal Bourdier <pascal.bourdier@gmail.com>
Date:   Tue, 1 May 2018 14:17:51 +0200
Message-ID: <CAPQz56bts8zFfUHyKJqnefQoH97L5TTA-k3be=5HsdeEbcMqOA@mail.gmail.com>
Subject: completion troubles with bash
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a02c9a056b23f5c5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000a02c9a056b23f5c5
Content-Type: text/plain; charset="UTF-8"

Hi,


If "GREP_OPTIONS" is set to '--color=always' , then the git completion
send some escape characters like this :

^[[1;35;40m^[[K                  d^[[m^[[Kiff-files               mergetool
a^[[m^[[Kdd                      d^[[m^[[Kiff-index               mv
a^[[m^[[Kddremove                d^[[m^[[Kiff-tree                name-rev
a^[[m^[[Km                       d^[[m^[[Kifftool                 notes
...


So you could find a small patch to disable color with "grep" in attachment.


Regards,


Pascal Bourdier

--000000000000a02c9a056b23f5c5
Content-Type: application/octet-stream; name="git-completion.bash.patch"
Content-Disposition: attachment; filename="git-completion.bash.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jgnmmw880

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoIGIvY29u
dHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKaW5kZXggYjA5YzhhMjM2Li4wYmM1
NWI5ZWUgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNo
CisrKyBiL2NvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoCkBAIC04MzcsNyAr
ODM3LDcgQEAgX19naXRfY29tbWFuZHMgKCkgewogCXRoZW4KIAkJcHJpbnRmICIlcyIgIiR7R0lU
X1RFU1RJTkdfQ09NTUFORF9DT01QTEVUSU9OfSIKIAllbHNlCi0JCWdpdCBoZWxwIC1hfGVncmVw
ICdeICBbYS16QS1aMC05XScKKwkJZ2l0IGhlbHAgLWF8ZWdyZXAgLS1jb2xvcj1uZXZlciAnXiAg
W2EtekEtWjAtOV0nCiAJZmkKIH0KIAo=
--000000000000a02c9a056b23f5c5--
