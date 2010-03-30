From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/2] git-gui: git-gui: change to display the diff with the 
	HEAD in the case of conflicts.
Date: Tue, 30 Mar 2010 18:00:18 +1100
Message-ID: <2cfc40321003300000k2b106d31iea2cec001c8f27f@mail.gmail.com>
References: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
	 <4BB19DBD.90009@viscovery.net>
	 <2cfc40321003292359u2b4d3fcfved860ab28338709a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 09:00:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwVR6-0005r6-KP
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 09:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab0C3HAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 03:00:20 -0400
Received: from mail-pz0-f173.google.com ([209.85.222.173]:40288 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0C3HAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 03:00:19 -0400
Received: by pzk3 with SMTP id 3so668555pzk.33
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=vPFN+ANbTswmnY9nk8VVl/5j+k10ZwWXpdpOvecXBPE=;
        b=O8kyMLB3kyJ3TzSuCQiH3QMGo1HFxF0uMZdt8UZFjzZciq+jU4HK8YIhep4xinkVkH
         4k2ZMqoCro44D6XRDxXMvooZHIcNVsbMaJbIfUPWDcgyos8q0NujV0ASj1ONtwt5N8+s
         KQB2JkMusPKTs1iu7PaqQnIsHNB9AGxfRdQFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=ON1SAECXB0pSCNdnHM44agRPJ8ROxXFSXWAxH3UmbZA9nMkXQAL1FJAZwM8/BJlI9E
         VM8pP2iufC0MYFOIo3DE3Gx6/fy2UIjlAZo4O7YwYY8T0DQkcTA56w+UnuMUYFNcJCWL
         LZZELoobVuEBome2ozWU1bvfmJZmBUHGoi0IE=
Received: by 10.114.13.5 with HTTP; Tue, 30 Mar 2010 00:00:18 -0700 (PDT)
In-Reply-To: <2cfc40321003292359u2b4d3fcfved860ab28338709a@mail.gmail.com>
Received: by 10.114.253.36 with SMTP id a36mr1884618wai.47.1269932418689; Tue, 
	30 Mar 2010 00:00:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143550>

And to the list...

On Tue, Mar 30, 2010 at 5:44 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 3/30/2010 1:00, schrieb Jon Seymour:
>> Resending because my original patch series wasn't whitespace clean and
>> I have now removed the configuration to make the safe behaviour
>> optional - it is not safe by default.
>>
>> If there is any other reason why this patch should not be considered,
>> please let me know.
>>
>> [PATCH v2 1/2] git-gui: Introduce is_unmerged global variable to
>> encapsulate its derivation.
>> [PATCH v2 2/2] git-gui: change to display the diff with the HEAD in
>> the case of conflicts.
>
> The default mode of diff in the case of conflicts is "condensed combined",
> which removes "unintersting" changes from the display. AFAIK, there also
> exists a mode that is only "combined". I would think that this mode is
> much more useful here because it shows the diff to both HEAD and
> MERGE_HEADs at the same time.
>
> Only that I don't know how to invoke this mode...

You mean in a similar way to the way that gitk displays the diff when
you select a merge commit?

jon.
