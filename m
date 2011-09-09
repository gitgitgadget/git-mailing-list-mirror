From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 09 Sep 2011 18:47:56 +0100
Message-ID: <4E6A514C.5080200@diamand.org>
References: <1315514452.10046.0.camel@uncle-pecos> <loom.20110909T115356-849@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, alevy@mobitv.com
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:48:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25BP-0003AJ-GT
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759585Ab1IIRsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:48:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58479 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758672Ab1IIRsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:48:00 -0400
Received: by wyh22 with SMTP id 22so1786980wyh.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 10:47:59 -0700 (PDT)
Received: by 10.227.113.70 with SMTP id z6mr2238269wbp.86.1315590479258;
        Fri, 09 Sep 2011 10:47:59 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com [86.26.7.206])
        by mx.google.com with ESMTPS id fq2sm8214195wbb.24.2011.09.09.10.47.57
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Sep 2011 10:47:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <loom.20110909T115356-849@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181097>

On 09/09/11 11:05, Vitor Antunes wrote:
> L. A. Linden Levy<alevy<at>  mobitv.com>  writes:
>
>>
>> Hi All,
>>
>> I have been using git-p4 for a while and it has allowed me to completely
>> change the way I develop and still be able to use perforce which my
>> company has for its main VCS. One thing that was driving me nuts was
>> that "git p4 submit" cycles through all of my individual commits and
>> asks me if I want to change them. The way I develop I often am checking
>> in 20 to 50 different small commits each with a descriptive git comment.
>> I felt like I was doing double duty by having emacs open on every commit
>> into perforce. So I modified git-p4 to have an option to skip the
>> editor. This option coupled with git-p4.skipSubmitEditCheck will make
>> the submission non-interactive for "git p4 submit".
>
> Hi Loren,
>
> This option was already included in a recent commit. The name that was
> used is "skipSubmitEditCheck". Please make sure you are using the most
> recent version of the script.

I put that option in - glad it's of use!

That option actually just skips the check of 'did the user edit the 
file'. git-p4 will still go ahead and bring up the file in the editor first.

I get around this myself by setting EDITOR=/bin/true. That works for me 
because I'm only using it in a script.

But it's possible that an additional option would actually be useful.



>
> But don't let this discourage you from submitting patches. Just makesure
> you clone git's repository and apply your patch over "maint" or "master"
> branches. For more details on how to submit patches you can read
> Documentation/SubmittingPatches.
>
> Vitor
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
