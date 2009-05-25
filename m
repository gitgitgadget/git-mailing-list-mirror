From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Mon, 25 May 2009 17:00:44 +1000
Message-ID: <fcaeb9bf0905250000n299f599fp3738e5385add075a@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> 
	<4A164C85.3000703@viscovery.net> <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com> 
	<20090523092603.GA7420@dektop> <20090523145042.GA13139@dektop> 
	<4A1A37AD.4080309@viscovery.net> <fcaeb9bf0905242334q37ef9a05xa05315639af4daf3@mail.gmail.com> 
	<4A1A3EF6.1050405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 25 09:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8UBT-0007mb-K8
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbZEYHBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbZEYHBL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:01:11 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:65493 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZEYHBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:01:11 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1770346ywb.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LlAJ/NcB8LCayh6svATMgiiIhj4DxJYPEdLdXAmRLwE=;
        b=GIRJ/I2z/x2ENFWfFpxvehx10S90KbwlLvHjlkgySBvFp3xQzpTIBGVI37g2t3P8au
         aertAKCNgj0WkmCYI97hRUbJwGxXj8t08819f4kGoZMyS8cBanXEnwWhzdxah0KUPs82
         RD0GPADwcPAGlMkSxCzoEF4WpwZyOSi7cA/fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mMXcRXtEONOmjtE4RppT3TyzZnnZ85bocKKDzmCHJsp3nwxvMTaWEXgWfYNbkCULek
         kABbRDNOtkRmRSdtTNu8UjzTpBTBpJ/QLaYFuXTGSlCzDG3A/0OAKTmuJhl71Ftl5m5k
         JYGnDiB6Yu7xxYFj7jVJcA1X6qu2dc49aKh6k=
Received: by 10.100.12.17 with SMTP id 17mr11785730anl.2.1243234864139; Mon, 
	25 May 2009 00:01:04 -0700 (PDT)
In-Reply-To: <4A1A3EF6.1050405@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119890>

On Mon, May 25, 2009 at 4:47 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>> On Mon, May 25, 2009 at 4:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Nguyen Thai Ngoc Duy schrieb:
>>>> Someone with better Windows knowledge than me should explain how this works. Windows'
>>>> snprintf() just cuts out the last character in this statement:
>>>>
>>>> snprintf(buf, 8, "--%s", "onto"); // result: '--ont', expected: '--onto'
>>> This doesn't happen for me: neither with Windows's original snprintf nor
>>> with the version from compat/. Are you using the latest msysgit
>>> environment to compile, i.e. gcc 4.4? There was a change regarding
>>> SNPRINTF_SIZE_CORR; perhaps that's the culprit?
>>
>> It could be. I used git.git's next branch, not msys4git or mingw.git
>> repositories.
>
> OK. Assuming you are using the latest msysgit compiler, which is gcc 4.4,
> then you need the SNPRINTF_SIZE_CORR related patch from 4msysgit.git.

It's cross compiler 4.3. Will try the patch.
-- 
Duy
