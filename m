From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Thu, 20 Jun 2013 18:11:16 -0300
Message-ID: <CACnwZYdLLJpcLJfagN=Xny3TLX=R6jcVF=o9yPoZoFZ38od0sA@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
	<CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
	<20130611091807.GA11361@alap2.anarazel.de>
	<CAMP44s2eUiZx6MaZ52Z0Ns40YapiEtzzZK6NJP8pNLiT5Z-pAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andres Freund <andres@anarazel.de>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 23:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upm8d-00066r-SD
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 23:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965848Ab3FTVLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 17:11:20 -0400
Received: from mail-vb0-f53.google.com ([209.85.212.53]:56113 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965843Ab3FTVLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 17:11:17 -0400
Received: by mail-vb0-f53.google.com with SMTP id p12so5039970vbe.40
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l8EVzIcl8VmqH7i36O/cWY8zVO8jb50YzkeV59BdIRE=;
        b=G7tWY9d8Jpki77nK1RLjiXn4yk6oL1IR/1RjA8wIbQmEK/sV/UrpkZ2TA7PJPxSP2k
         rRxDRD5CBZTceTZDXRYmwN7VKzN/WTLqyUZAyPhMBncGu1TNFJkRB569e/1EVySaYYOS
         45Uw7npZ/6Ues0SwIpor08IJ6fSaJhbfzekzSyMxqjqD13J/xz2dAJlHh4stkYZtply1
         QRd+O26kiaUbb2Lr9W82fYWLSQCOoB61UCH7YzK8XbB+lhMJMQCeYtXldDPYm6EUOxiS
         E3juknfvNd/q+GyrgGE2j/Hj0VzgMBU0vdxJX60HldW1heWsKdvmQbSMAVv/XYy7izPg
         Hydw==
X-Received: by 10.52.76.36 with SMTP id h4mr3387807vdw.113.1371762676212; Thu,
 20 Jun 2013 14:11:16 -0700 (PDT)
Received: by 10.58.210.194 with HTTP; Thu, 20 Jun 2013 14:11:16 -0700 (PDT)
In-Reply-To: <CAMP44s2eUiZx6MaZ52Z0Ns40YapiEtzzZK6NJP8pNLiT5Z-pAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228540>

May be because they (LKM) are more open to such architectural and
organization refactorings?

Some maintainers, like Greg Kroah-Hartman and possibly others accept
clean up patches, such thing seems to be unacceptable here on git.
Looks like there is space here only for features and bug fixes.
Nothing else. I'm not saying that is bad at all.
