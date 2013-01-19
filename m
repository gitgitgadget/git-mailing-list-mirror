From: Eric James Michael Ritz <lobbyjones@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Sat, 19 Jan 2013 16:56:03 -0500
Message-ID: <50FB1673.8020808@gmail.com>
References: <50FB1196.2090309@gmail.com> <1358632037-ner-2564@calvin> <CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 22:56:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwgOs-0000vN-8k
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 22:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab3ASV4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 16:56:07 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:43016 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3ASV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 16:56:05 -0500
Received: by mail-yh0-f43.google.com with SMTP id z20so175471yhz.16
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 13:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+mOYNY8cGgeUeNhsikI0yRRkNmtMlN60jEd+bDQxVas=;
        b=r0ephtamQ+QbJ7e56O1ipyFOKDgvH4Vo+Urxaf9fJcYuLWof2N1r6qHYu0Lk/X26ny
         S0hL4JzsmRlA05HP59KC5+EMpHzhjGD6wvmAwrI8TRnTGaomqoTEYaqfeBmKaPGuSOLU
         hgAlfVUM8g0b9MlPWWZaZKXd9jhpJKC/OZvz6rmtdniwG7hoNKvKJ/m6+nZtTOSNROrG
         uaJ8h/lBdyfAINWweMhervMPto+ns4Z4KQO499mnkplxgF1nGv7pKsWRtlNDcJUWliTi
         sowxAY6/e6rRttXdpi9e4pbFH1zbZGcXr5XT++iMMYlfL8P6xkGgK8BphRC7LrG9mJWs
         C2mg==
X-Received: by 10.236.149.8 with SMTP id w8mr3461971yhj.71.1358632564511;
        Sat, 19 Jan 2013 13:56:04 -0800 (PST)
Received: from [192.168.1.102] (97-81-212-183.dhcp.hckr.nc.charter.com. [97.81.212.183])
        by mx.google.com with ESMTPS id t2sm7683417anj.3.2013.01.19.13.56.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jan 2013 13:56:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213993>

On 01/19/2013 04:49 PM, Antoine Pelisse wrote:
 > I think `git add -u` would be closer. It would stage removal of
 > files, but would not stage untracked files.  It would stage other
 > type of changes though.

On Sat, Jan 19, 2013 at 10:47 PM, Tomas Carnecky
 > Does `git add -A` do what you want?

Thank you Tomas and Antoine.  Both of these commands do what I want:
stage deleted files on the index.  But does the idea of a `git rm -u`
still sound useful since these commands also stage changes besides
deleted files?

--
ejmr
=E5=8D=97=E7=84=A1=E5=A6=99=E6=B3=95=E8=93=AE=E8=8F=AF=E7=B6=93
