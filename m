From: Fabian Zeindl <fabian.zeindl@gmail.com>
Subject: Re: weird rename
Date: Tue, 31 May 2011 21:19:49 +0200
Message-ID: <9FA9D80A-F970-4B3F-95DD-2B5DE73D27EB@gmail.com>
References: <7760D048-5534-42A2-82D2-D5BB9C75739C@gmail.com> <BANLkTikuZ-ig0einn+GhMh9EJp4jp2TCxg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 31 21:19:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRUTu-0000EA-L2
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 21:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757581Ab1EaTTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 15:19:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33561 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1EaTTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 15:19:53 -0400
Received: by fxm17 with SMTP id 17so3290497fxm.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=0KklDlFi28VBDeHmcpUCa18om/X99khiE++GW2gwx2E=;
        b=NN03XthNv2zb1cw+Mu7zoxhwI0+1A0vl9BKT9umVHesfdFarFsRYGQDiknmGpualW8
         akiIV/nyGseaHrD8oHjs0ZQH9Yiydc1P/iuJY5ysZ9v6ifO0jVAfGtGmfAL+n11ffct2
         w2/iIOpZkg7Xfs7MXou2S3nSD+x07ylw3QgMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=lrIOgg0zGu1XdZgPwDRgtDwr/P06wREfeL1pg8TBVrfSjxhWrO1TXPFedQ+pN29Q0r
         jIGLI7OyVmKc14UpBfan6U3YGFeJA0vyDZZYqGSc4SGJE+X3eC87Qy+D+VSjw+cuEZLP
         +OA2bEd+A0piaG9bmmpNHpo+Z762Occhq3Pi0=
Received: by 10.223.29.132 with SMTP id q4mr2881650fac.17.1306869592338;
        Tue, 31 May 2011 12:19:52 -0700 (PDT)
Received: from [192.168.1.105] (chello062178219088.12.15.vie.surfer.at [62.178.219.88])
        by mx.google.com with ESMTPS id e16sm139061fak.17.2011.05.31.12.19.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 12:19:51 -0700 (PDT)
In-Reply-To: <BANLkTikuZ-ig0einn+GhMh9EJp4jp2TCxg@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174824>

On May 31, 2011, at 9:18 PM, Reece Dunn wrote:
> /dev/null is used to indicate "does not exist" 

yeah i know that :)

> Comparing /dev/null with A -- A is a new (added) file.
> Comparing A with /dev/null -- A is deleted.

ok, i deleted a similar sounding file (3.7M3 instead of 3.7M7), i just wonder
why git got that as a rename. or the GUI (GitX) at least.

fabian
