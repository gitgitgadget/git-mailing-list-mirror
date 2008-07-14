From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 0/6] archive: refactor and cleanup
Date: Tue, 15 Jul 2008 01:41:52 +0200
Message-ID: <487BE440.9010006@gmail.com>
References: <487BA74E.5070208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXh6-0000vS-Ad
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759614AbYGNXlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 19:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759613AbYGNXly
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:41:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:56104 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759612AbYGNXly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:41:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2185835fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=5aFEhzVb9Ep5xDXKV1INCOzv7GI4tB/fiV7d+p+5z4U=;
        b=OmGa9+8cc4Zk/qySWok7v03ApMoEvMBmRIwL5e2QNN7yVJwsq8Y/LJPtU6sFIBP0Oo
         es0s/JBH9/qKlQqdWT0mEEgtKbYaKV//kTFuoq/SfLy8BmRwYbS2FNu6UuqAQCllOznn
         5HQ46P3qdGJIRF1C0mimGjJhQiecw7aAQtj9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=ik1L1wB/1ClRnBRRDq2r/gY4qmarvlGcqWtJsLE4j8f83rb5rKaHeq756B9MQkhgHU
         Rg9kv3vSEjL/LOeItpooMYwwss1kLjRoKPUPW0bV1oH/iMWm7beZ1AnEdZtHqZGXie2u
         JWJU0tv7w4MNGuoAMiCczzwB+ATfl7HN7i1mU=
Received: by 10.86.25.17 with SMTP id 17mr15083745fgy.50.1216078913220;
        Mon, 14 Jul 2008 16:41:53 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id e11sm8144554fga.4.2008.07.14.16.41.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:41:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <487BA74E.5070208@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88483>

Ren=C3=A9 Scharfe wrote:
> This series is a collection of cleanups for git archive

A few things:

* The note quoted above probably shouldn't be in the commit message but
after the "---".

* You patch messages seem to be In-Reply-To a message that wasn't poste=
d
on the list, not to PATCH 0/6.

* Unless you have a specific reason, I suggest that you don't Cc Junio
on patches; he reads all messages on this list (more or less) and will
usually simply apply your patches once they're reviewed.  (Watch for hi=
s
periodical "What's cooking in git.git" messages to see if he got them.)

* And most importantly, your Thunderbird introduced line-breaks, so it'=
s
not possible to apply the patches.  May I suggest you use git-send-emai=
l
instead?

=46eel free to ping me on IRC (lea_w in #git) if you need help.
