From: Adam GROSZER <agroszer@gmail.com>
Subject: Re: opening an editor from git-gui on a file
Date: Mon, 16 Nov 2015 12:10:41 +0100
Message-ID: <5649B9B1.7090203@gmail.com>
References: <56498CBB.4070709@gmail.com> <5649B212.30206@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 12:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyHgP-0006v4-JY
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 12:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbKPLKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 06:10:46 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35562 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbKPLKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 06:10:44 -0500
Received: by wmdw130 with SMTP id w130so105894974wmd.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 03:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=SVpky4cIh70tJZSWzqTxL9vzjpffRNzZ71S35AMqotg=;
        b=ZnO7qJZkkvR6cVn62hnObNDtSOSvUUeMZu3hnIMZc6zIGnBhwYLUh00MPmUinoOKcj
         4hQ2/CdQ9GeDLb6H43iU/Axw4zg/GGPyGMFWjX7ttyw49Lx4VmXZYtC8oJIJccw39eOC
         g6m6sHsSMDphOYnEw4bvsCFg1Qd8WNMD48iYp4JKczk/E0gEAAXZN5Mm6+rj/RroDmbX
         7BQNiEygS9BIG7wI0LxLQQ/Od0Sg8kwZCgDYfm1Fl+FwlslYI+OWSnICoM4Lijuun0DV
         QgZKwBpHhfGD561XYUtkgSfTSM7ncTkMeWKiunU9fKwmGn1fYHm1E2GCIluYaoTspRFC
         rIhA==
X-Received: by 10.28.48.213 with SMTP id w204mr17248584wmw.38.1447672243392;
        Mon, 16 Nov 2015 03:10:43 -0800 (PST)
Received: from [192.168.1.247] (catv-78-139-38-214.catv.broadband.hu. [78.139.38.214])
        by smtp.googlemail.com with ESMTPSA id s9sm18037372wmf.2.2015.11.16.03.10.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 03:10:42 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5649B212.30206@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281334>

Thank you!

Works fine. Tho I don't find any docs/references for a hotkey...

On 11/16/2015 11:38 AM, stefan.naewe@atlas-elektronik.com wrote:
> Am 16.11.2015 um 08:58 schrieb Adam GROSZER:
>> Hi there,
>>
>> Hopefully sending the question/idea to the right list...
>>
>> I'm missing the feature to open a (configurable) editor with the
>> currently selected file in git gui.
>>
>> E.g. Looking at
>>
>> https://cdn.tutsplus.com/net/uploads/legacy/2081_gitwin/git-gui-stage.jpg
>>
>> I'd like to open my editor with the "request.php".
>>
>> Any chance to have that? Or do I miss something?
>
> I have this in my .gitconfig:
>
> [guitool "Edit/with GVim"]
>          cmd = gvim --remote-tab-silent $FILENAME
>          noconsole = yes
>          needsfile = yes
>
> Works for me.
>
> HTH,
>    Stefan
>

-- 
Best regards,
  Adam GROSZER
--
Quote of the day:
Rudin's Law: In a crisis that forces a choice to be made among 
alternative courses of action, most people will choose the worst one 
possible.
