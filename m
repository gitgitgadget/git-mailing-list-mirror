From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] use "up-to-date" in messages instead of "uptodate" for 
	consistency
Date: Tue, 6 Jul 2010 12:47:44 +0000
Message-ID: <AANLkTimvQ8_SKa_VSvQk1_c3aRVv1lZCMYNOVLXBuC4W@mail.gmail.com>
References: <ACE6C748-1F26-473B-BC69-33C59A3969BD@wincent.com>
	<7012ea639b8beddcd42eceff0898e33ce7c455e9.1278407491.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 06 14:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW7Z2-0002K5-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 14:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab0GFMrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 08:47:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34145 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab0GFMrp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 08:47:45 -0400
Received: by iwn7 with SMTP id 7so6608702iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fT5vRwvXaTCea5e4yolUQr1aUvQ4iVg5b+4Y8idyK+s=;
        b=rj08JK4a8LiG4kOuIFa1o3/GrWbva1JQl8s9HKQVOZcuW4VQ+Rom0FdgUal3e3pbdi
         /3u9q7kPz2m1btCaFi8c+Wt2ZUqHpf/h/2KIwFtpvCdd9CFxPt3wLmVw2qdhBmNl+DZj
         QvWZA4ad2XSF9tXmmwpLiWJ+SfSJg5DvIcOxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Vp6ETUit8prAm2pNYur0jqbxWNtx9XqzQA/xpty6Va8NeqqcIgzcEw6gpzm6H+oW9T
         IqBNBDRwHqMFI2/6Ps9oCsPIwakrl8oNNSvZ7I4xTQ11v1rcai+EiqPTXqqT/8wo1Kpg
         k+1Q0h2yXZsA6zuDSBofVnnEQtjcvXi1SJhVM=
Received: by 10.42.4.75 with SMTP id 11mr1464768icr.50.1278420464484; Tue, 06 
	Jul 2010 05:47:44 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 6 Jul 2010 05:47:44 -0700 (PDT)
In-Reply-To: <7012ea639b8beddcd42eceff0898e33ce7c455e9.1278407491.git.nicolas.s.dev@gmx.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150348>

Did you run the tests after applying this patch? This looks like it would break:

t/t7110-reset-merge.sh
176:    grep file1 err.log | grep "not uptodate"
192:    grep file1 err.log | grep "not uptodate"
