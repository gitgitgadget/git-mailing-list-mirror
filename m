From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/16] Subtree clone proof of concept
Date: Sun, 1 Aug 2010 15:05:01 -0500
Message-ID: <AANLkTikr9ZE9s3GG9JocLDvwDQA2FT4_Gh65=dveB8KW@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com> 
	<AANLkTinMBAikByLfOi5sXbcRfCsYtYqMCNSTykRofQyo@mail.gmail.com> 
	<AANLkTimEOsNvCYyLmbLbMXEoJL-EPQbjE+iD5y7prLAt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 22:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofemm-0000An-E0
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 22:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab0HAUFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 16:05:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49658 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0HAUFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 16:05:21 -0400
Received: by gyg10 with SMTP id 10so1074679gyg.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=xpHx37kzHsezAQWcYmfhLIezCmNbpftHgmEQBbs9Luw=;
        b=h4rmhdJw2XIUH6L0bqd85gv1tNYut5Pit3EWLEms32ZXq0hinKVPKUfVD4OkK3O/4E
         5o5gHs4rlnsFPUjnmwNE8MTWNvSEGTNgbug+KdSOHDJTpxhh4x53ovd+GJaT+YH+Pc/c
         2fXJEZh2ygDv8sdTTxKDSnfTQV74vySJTuYSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KoohbtovqmEf/B4GYMs82cEC4mpKOC07VlPrnqnQvVi1rfgCBYjbPjEh0f+LbR0goR
         phUCCevvGXl/C19TVwKtT8ndoghZk27XzKWhxwozumQQd456l6O+Qyk1UtdHATZWoneW
         oszg9W7uNmn9d+fb0micakgu9RLMm6APEcjUM=
Received: by 10.150.163.9 with SMTP id l9mr5908908ybe.94.1280693121171; Sun, 
	01 Aug 2010 13:05:21 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Sun, 1 Aug 2010 13:05:01 -0700 (PDT)
In-Reply-To: <AANLkTimEOsNvCYyLmbLbMXEoJL-EPQbjE+iD5y7prLAt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152380>

Heya,

On Sun, Aug 1, 2010 at 01:58, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> 2010/8/1 Sverre Rabbelier <srabbelier@gmail.com>:
>> Can they be combined to create the fabled narrow checkout?
>
> Yes. For the record, --subtree=Documentation/ with --depth=1 made a pack of 5MB.

I hope everybody is paying attention to these patches then! :)

-- 
Cheers,

Sverre Rabbelier
