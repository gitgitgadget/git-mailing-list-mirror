From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Add hints to revert documentation about other ways to undo changes
Date: Wed, 20 Aug 2008 16:36:40 -0700
Message-ID: <905315640808201636of09ccb3wb31b71cd090b451@mail.gmail.com>
References: <7vk5ec7s05.fsf@gitster.siamese.dyndns.org>
	 <1219175431-20730-1-git-send-email-tarmigan+git@gmail.com>
	 <7vzln7mglj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Daniel Barkalow" <barkalow@iabervon.org>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 01:37:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVxFL-0002Zi-ML
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 01:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbYHTXgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 19:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbYHTXgn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 19:36:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:42189 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480AbYHTXgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 19:36:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so337434nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ZHJp5ucwPMs7Fy9wMXo1EIFIQWXXHNGI9Znofh1CrE0=;
        b=jvimAk3aywSPQT+3b6/evjWDozF9HQ5GeVSXk9CI5h1oFnqczTox2NJF+Q4WMs9+KC
         LAlkmbj7qHwODBbeb8BQpzKNFGOSCATBfBIud0cSSLwZc1UOQHnTK6F+HF+7/3RqYExK
         lelYfeeKyYOsqykOkIPzzFo0PR4DXuoX5zpm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=xX7XX4TJ8/sSlhnUSC1Y5jbWVyBGIC/keYDhtFWAUTLKuUNSKDm8wHqZx3YSGw6lT8
         NgYdCGJVeokZrHF0oQVuqlZTH7lwyFkjkpy7P8yuyQjgT6jhLHoagHOOek7UlERETc8q
         sZMtHo6xppjUEeXi/wumC93+w//OoTIiY6yUs=
Received: by 10.210.121.8 with SMTP id t8mr880038ebc.31.1219275400930;
        Wed, 20 Aug 2008 16:36:40 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Wed, 20 Aug 2008 16:36:40 -0700 (PDT)
In-Reply-To: <7vzln7mglj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 6051918a5db6f84e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93072>

On Wed, Aug 20, 2008 at 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> writes:
>
>> Based on its name, people may read the 'git revert' documentation when
>> ...
>>  Documentation/git-revert.txt |    9 +++++++++
>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
>> index 98cfa3c..e578edf 100644
>> --- a/Documentation/git-revert.txt
>> +++ b/Documentation/git-revert.txt
>> @@ -15,7 +15,15 @@ Given one existing commit, revert the change the patch introduces, and record a
>
> Why do you say you have 7 preimage lines and 15 postimage lines, when the
> diffstat claims you have 9 insertions?
>
> Did you hand edit the diff?
>

Oops, sorry about that.  I did hand edit the diff because at the last
second I saw a typo (particulary --> particularly), but I had already
written the email so I didn't want to do `format-patch` again.  I did
not rewrap, nor did I manually change the 6 to a 7.  I did use emacs
though, which, when I tried to recreate it right now, seems to change
the 6 to a 7 when I touch any of the changed lines.

Sorry about that.  I will turn off emacs diff mode and try to be more
careful next time.  Please let me know if you want me to resend.

Thanks,
Tarmigan
