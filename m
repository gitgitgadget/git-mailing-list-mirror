From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 12:17:53 +0100
Message-ID: <40aa078e1001250317r77334917le88c5adb74d1939b@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com>
	 <40aa078e1001250211w2dcc5e97vf89f64f136bd2f0@mail.gmail.com>
	 <fabb9a1e1001250222n6912905fqfd2e76f8d4496bb7@mail.gmail.com>
	 <201001251201.23064.robin.rosenberg@dewire.com>
	 <fabb9a1e1001250306l2b9aba53s6a884b618a80063b@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMxF-0001Cw-11
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab0AYLR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 06:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737Ab0AYLR4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:17:56 -0500
Received: from mail-ew0-f226.google.com ([209.85.219.226]:41095 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AYLR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 06:17:56 -0500
Received: by ewy26 with SMTP id 26so2221353ewy.28
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 03:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fl+/BDrYoe+aNm6Iz2ugG6sTXQcPdDzwPQZ4YMRIouA=;
        b=jdmcb2DI9ml5jd/lM3LeKV3fgZIrKcS9Ug8CUFpGt9RDiSQRjWKzXf7Knc6aRyajoo
         Xv98qYRSCQHlPctTgU3T+m45Y17tpI/P2gTjaHWiRY0tAVXSIXdMerWYThu+7yadOCT7
         QchQn7dItxc7nkK336sz11p1DgMhfuJPRIMSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=NXjQOD6jxq5JbmX2Rm5ktOI8N9jaTx8/+fJnbqXAuql7zzV9ukdn4mc+ufdB2Ot1L7
         m49IzqIqpl+bP8pKdaW2Wvazl/Z6mDQA2AXTLB/EmS2QtN374vKWlkImurXxcJFQIvBA
         Gt/nvXspJ4eKvN4qHW9zq+3aKTOWWh5j/PaLI=
Received: by 10.216.86.72 with SMTP id v50mr247968wee.184.1264418273907; Mon, 
	25 Jan 2010 03:17:53 -0800 (PST)
In-Reply-To: <fabb9a1e1001250306l2b9aba53s6a884b618a80063b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137954>

On Mon, Jan 25, 2010 at 12:06 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Mon, Jan 25, 2010 at 12:01, Robin Rosenberg
> <robin.rosenberg@dewire.com> wrote:
>>> Ah, that's very interesting. Not sure that will help MSysGit a lot though.
>>>
>>
>> Could you perhaps *try* it before claiming it won't work? I suggest you
>> use forward slashes to avoid quoting problems.
>
> Actually, I can't, cos I don't have a MSysGit build environment, I'm
> just saying that in the environment I tested it in, I didn't have to
> log in, so I suspect that it won't work, I'm not claiming anything.
>

For shares that doesn't require login, I can list files without doing
anything. Remember that Windows might try some saved password in the
background when you open the folder in explorer, so not seeing a
password-prompt might not be the same thing as the share not needing
login.

Perhaps "net use \\mongo\code" would have been a better example than
using explorer? I don't have the setup where I am right now to test
that it does what I expect it to, though.

-- 
Erik "kusma" Faye-Lund
