From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git clone hangs
Date: Wed, 16 Jun 2010 00:00:04 +0000
Message-ID: <AANLkTinISUp7CBBdfpJJPS9A5np58npCfNfUHHHX7HB0@mail.gmail.com>
References: <AANLkTik3dJvx5TfVl9Ym4QoYDqIGM-LEovbVBW1vCzaN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: zal12 sar <goshtasp.zal@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 02:00:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOg3Q-0008DE-EG
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 02:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564Ab0FPAAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 20:00:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56380 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab0FPAAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 20:00:06 -0400
Received: by iwn9 with SMTP id 9so5066464iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IH9E2Q2snO6X5/Eayol9i7qegr3fXG7EdD6vxrAl+hk=;
        b=nCSVAGI0wItEE4rjhgx2QGk91JD/+5QlQ6eTCJMgrWnUMug+fWm268Ki+3ZvBGkNeJ
         OuXjZTWuL1rVQJ63z5C5M3phceuIQ0Yhqi0NbNFF2jieopmt8mFUIAD/aHU6HQupcT5E
         GoUZ+yXlxKIs368YVngm5HD2AC7PwtIX+mmM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fgYxO6iff4o1Juxu2OmcPfTcsahmwlY1tGBO0MomapVDKRpRY3R9dt9KoRm2arOLRT
         FVJSgLpgTAo8cnhZXBQJULoSleU8hkDMtEIJ8k6r7823txLVLDPR3bzCgHJTucO/pVhC
         I1lA14mqc+lpXUcsvHFeLLHYE72Nn2Rv8V67k=
Received: by 10.231.184.1 with SMTP id ci1mr8723986ibb.39.1276646404915; Tue, 
	15 Jun 2010 17:00:04 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Tue, 15 Jun 2010 17:00:04 -0700 (PDT)
In-Reply-To: <AANLkTik3dJvx5TfVl9Ym4QoYDqIGM-LEovbVBW1vCzaN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149242>

On Tue, Jun 15, 2010 at 22:52, zal12 sar <goshtasp.zal@gmail.com> wrote:
> Any help or pointers?

Run these with strace(1) ?
