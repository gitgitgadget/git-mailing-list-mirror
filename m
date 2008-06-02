From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [Bug] vfat: Not a git archive
Date: Mon, 2 Jun 2008 12:11:32 +0100
Message-ID: <e1dab3980806020411ld0f40a8v60bbce46c0c0bd99@mail.gmail.com>
References: <873anwt9ya.fsf@debian.erik.com>
	 <20080602103909.GB11287@mithlond.arda.local>
	 <87abi45c97.fsf@debian.erik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Christensen" <thomasc@thomaschristensen.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 13:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K37xm-0005aM-OM
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 13:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYFBLLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 07:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYFBLLh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 07:11:37 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:35257 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYFBLLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 07:11:37 -0400
Received: by yw-out-2324.google.com with SMTP id 9so472358ywe.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L+0avc7PoVVymKZPQi/UerFo2E2WKvh+sDuV8zIv90c=;
        b=PGv2w5McoRoNrFGM14Xx+kZ+LzBvxVWu9sLk9GjhTTzfNk6Q9jFub6zjAAzAFqyC+iA4NJxJm3jcr2haZbIgnhLZQao6AKUilGJzdClBpLDg4ElRyVb7lr1BvC7Zpgpnc3twJyyJhr9rfZiHneKTmgY6DJg7sZk+I1M7NVZZ7gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PRTzJt7PLE+uEG11/FSL0TpX/5cp8eFvb4x68Sg6glb6r+vFnbNMbPVCYxJjpsVADyW0hYkR8oBD9DEa3t0pYgbwJDDtl+9kTmVq6e5BYGBT24aOs24iAo+xcOcrLU2n4kNK2adeJanbZXbhNaNTDe9pZlGsCxClgPDpLdYLUAg=
Received: by 10.150.84.41 with SMTP id h41mr12455459ybb.221.1212405092160;
        Mon, 02 Jun 2008 04:11:32 -0700 (PDT)
Received: by 10.150.145.6 with HTTP; Mon, 2 Jun 2008 04:11:32 -0700 (PDT)
In-Reply-To: <87abi45c97.fsf@debian.erik.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83514>

On Mon, Jun 2, 2008 at 12:04 PM, Thomas Christensen
<thomasc@thomaschristensen.org> wrote:
> Teemu Likonen <tlikonen@iki.fi> writes:
>
>> Thomas Christensen wrote (2008-06-02 12:20 +0200):
>>
>> Hmm, for example KDE automatically mounts VFAT filesystems with mount
>> option "utf8" when using UTF-8 locale. VFAT uses UTF-16 in filenames and
>> the only way to convert filenames losslessly (apart from the case
>> insensitive issue) between Linux and VFAT is to use UTF-8 locale in
>> Linux. I have described the subject in the Debian bug #417324:
>>
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=417324
>>
>> What locale are you using? What mount options did you use when you
>> mounted the /media/KINGSTON/ filesystem?
>
> LANG=en_DK.UTF-8
>
> /dev/sda1 on /media/KINGSTON type vfat
> (rw,nosuid,nodev,uhelper=hal,shortname=lower,uid=1000)

I've got shortname=mixed (but via a manually set up fstab; I don't
know what the automounters do.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
