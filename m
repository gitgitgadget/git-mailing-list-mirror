From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Global .git directory
Date: Wed, 28 Apr 2010 14:50:46 +0200
Message-ID: <q2k40aa078e1004280550o322dc5b8jca74d401a5eb1abe@mail.gmail.com>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
	 <201004271159.34071.trast@student.ethz.ch>
	 <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
	 <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>
	 <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 14:51:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O76jF-0006ve-J6
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 14:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab0D1Mu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 08:50:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59685 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0D1Muz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 08:50:55 -0400
Received: by wye20 with SMTP id 20so719723wye.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=bNJjsbEbiGserMsXInqyQrbV2izMSmwnfKJDHKwTGu4=;
        b=XfT3Xe0vKmUNiKTI3g+sHxPLwBsDtF/E7cjqgK2p51XvsIbrRB79IjKv6MQeh8HU1J
         5HIjI/biSBsjhmVgvK78ORRIcVgUfNUIZI72mQkXU8QozfBtWloRwDsHWmKspgKxKNWA
         RYYZtnbImv5VxiQ/2rZ8abg+YPa+Y6oLaWelk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=p7mTPrKeZSoe9c72FP7rO80C+gSAHhq5zgbUV2hyD/7ssi9bHbZI8r0tRgJ9/AlUXa
         kzr4MZGrAOiCoPLVFhkgA0Dh2KaI4JWhr6nKPwBE4dd4waFaP0Zt/lbLy4mR7vkKxMyz
         WPwQYqyF5qb2/l7mwaAZ825PZTGxaU42WLxSA=
Received: by 10.216.89.130 with SMTP id c2mr2166292wef.44.1272459046956; Wed, 
	28 Apr 2010 05:50:46 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Wed, 28 Apr 2010 05:50:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145994>

On Wed, Apr 28, 2010 at 7:33 AM, Gerhard Wiesinger <lists@wiesinger.com> wrote:
> On Tue, 27 Apr 2010, Erik Faye-Lund wrote:
>
>> On Tue, Apr 27, 2010 at 10:06 PM, Gerhard Wiesinger <lists@wiesinger.com>
>> wrote:
>>>
>>> On Tue, 27 Apr 2010, Thomas Rast wrote:
>>>>
>>>> (In other words, please convince us that this is actually worth
>>>> having.)
>>>
>>> Ok, rather than convincing I've written a (fast) patch which works for me
>>> :-)
>>>
>>> Any comments? Any (further) changes needed? Will you include it in main
>>> git?
>>
>> Please see Documentation/SubmittingPatches. It's difficult to comment
>> on a non-inlined patch.
>>
>
> Patch done on top of HEAD.
> git format-patch -M origin/master
> 0001-Added-global-git-directory-when-environment-variable.patch
> 0002-Added-global-git-directory-when-environment-variable.patch
> 0003-Updated-documentation-for-submitting-patches.patch
> Attached.
>

I was referring to that you sent the patch attached instead of inlined
(as Documentation/SubmittingPatches suggests).

By attaching patches you force everyone who wants to review the patch
to have to copy and manually quote the parts of the patch that they
have comments about instead of automatic quoting like all decent
e-mail clients do. That way you get less people interested in the
patch.

I sent this reply because you did the right thing of cooking up a
patch in the first place (as opposed to just arguing - very good), so
I think you deserve a chance of getting the patch reviewed (and
possibly included... if people agree with you, that is).

-- 
Erik "kusma" Faye-Lund
