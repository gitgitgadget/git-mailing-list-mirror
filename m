From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 1 Dec 2009 10:12:36 +0100
Message-ID: <40aa078e0912010112u4205452as3627ba019544c5fe@mail.gmail.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com>
	 <4B123C80.30607@syntevo.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Maximilien Noal <noal.maximilien@gmail.com>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOmq-0000ws-7z
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbZLAJMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 04:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZLAJMc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:12:32 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44426 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZLAJMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 04:12:30 -0500
Received: by ewy19 with SMTP id 19so4687391ewy.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=F+pw9gG8BXQRExweu2P6Y+Od/7GTcVjvCIDqxJh6wDs=;
        b=OtqqnloQAXJEG50q7sObRxvRBdBtlBy7augPw5jptf8hYL9wU3tdP5HMlYyAW6Q7O0
         QJSeBUEVBSYtlN/5WWBiC1EVVK44d/tux/0TLsgud2l92CtD643dcgGIt81V0O4mOlYL
         OSfdyoMMjtYbS2jPZ9ikyVWglMtE+eTQXGFUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=NFGQIlXfdpqkobFls4zQzDBgZI6hwjs2M/Q/quwXIRoIb2/jiQNIe/30mMSkx+2Lvu
         2CtkBQrM60pPcrKKZ9Vxgcpp1VY8ZEjjFqHwf11d8e3AFWcqrBLVAHISPTSDQ1HPirnr
         d9alfoqjNB3GYh1x4gePUgiTAmsP8yeos8E0M=
Received: by 10.216.90.209 with SMTP id e59mr1800588wef.193.1259658756133; 
	Tue, 01 Dec 2009 01:12:36 -0800 (PST)
In-Reply-To: <4B123C80.30607@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134185>

On Sun, Nov 29, 2009 at 10:18 AM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
> Maximilien Noal wrote:
>> About the 'boxes' :
>>
>> The thing is, Windows' files for Asian languages are _not_ installed by
>> default.
>>
>> They can be installed (even while installing Windows), by checking the
>> two checkboxes under the "Supplemtal languages support" groupbox in the
>> "Languages" tab of the "Regional and language options" control panel.
>> *re-take some breath ;-) *
>>
>> It will remove the "boxes" in Explorer and display nice Asian characters.
>
> Thanks, now the characters are showing up fine in the Explorer.
>
> Reece Dunn wrote:
>> This is a bug in git's character encoding/conversion logic. It looks
>> like git is taking the source string and converting it to ascii to be
>> displayed on the console output (e.g. by using the WideCharToMultiByte
>> conversion API) -- these APIs will use a '?' character for characters
>> that it cannot map to the target character encoding (like the Hiragana
>> characters that you are using).
>
> I have a screenshot from a SmartGit user where 1) the console can show the
> far-east-characters and 2) Git *can* show the characters escaped. Are there
> two versions of Git available or does Gits behaviour depends somehow on the
> system locale?

Did you try to make sure your console window used a Unicode font on
your German Windows installation? Asian Windows installations might do
this by default, something at least neither English nor Norwegian
Windows installations seems to do...

You can change the console window font through the properties-menu
that appears when you right click the title-bar.

-- 
Erik "kusma" Faye-Lund
