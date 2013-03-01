From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Subtree in Git
Date: Fri, 1 Mar 2013 22:05:10 +0000
Message-ID: <CALeLG_maSpjVtO3swZAWV12Cr7rDWOaJ=Jh8zw5tJn0EGGW+fA@mail.gmail.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
	<4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl>
	<nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org>
	<4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com>
	<50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<nnga9vefu1v.fsf@transit.us.cray.com>
	<508A8BD3.9020901@initfour.nl>
	<2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
	<loom.20130301T032627-983@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>
To: Kindjal <kindjal@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 23:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBY5D-0002Mp-W1
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 23:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab3CAWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 17:05:12 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:63067 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3CAWFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 17:05:11 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so948702obb.25
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 14:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=AqiyfJmTJBTFaha+mUYwctvhYGoRaAptYa/wFeWVX4o=;
        b=AfnUtb/AzKmFptYrVoeQ8yTCnXeJyLHFmB2GujY4KFpQpkMvNwmpBnYxEgRskwk+sG
         Qlp81ze/SmIN3AElhCIB5m0pmUmV4fHYCq9J3k/3CRYQ1ebij9Y+Mq9sXrvE7F1ikD9g
         8cKkZCXDhIlTEJsuQKxNfaPw1qXgw+PqvZ9nB1svHD330HnS4N72Oe2ik0YCCu0b4oBy
         5rHIpBU+SdiwR8ezS3IYsJ4IFFmV3dlLfaWkPk6wysVKHT5EUZXPwCvDW1p4MTZ8AvfW
         QaZdpSrOu613Mjm17VtfFdkK8eQCjeGEVeqI8q/Yej3bFtkhBpZBu2xYU0ecebifl6bR
         P1oQ==
X-Received: by 10.60.172.36 with SMTP id az4mr9937858oec.29.1362175510741;
 Fri, 01 Mar 2013 14:05:10 -0800 (PST)
Received: by 10.76.93.37 with HTTP; Fri, 1 Mar 2013 14:05:10 -0800 (PST)
X-Originating-IP: [2.102.84.8]
In-Reply-To: <loom.20130301T032627-983@post.gmane.org>
X-Gm-Message-State: ALoCoQmgOEDcjnHnWuZQgnHfMFSPwyxAedgKY55N8MvaZV+ORcPYWFBJUU5F/k2xLGBpAnykRNLS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217296>

On Fri, Mar 1, 2013 at 2:28 AM, Kindjal <kindjal@gmail.com> wrote:
> David Michael Barr <b <at> rr-dav.id.au> writes:
>
>> From a quick survey, it appears there are no more than 55 patches
>> squashed into the submitted patch.
>> As I have an interest in git-subtree for maintaining the out-of-tree
>> version of vcs-svn/ and a desire to improve my rebase-fu, I am tempted
>> to make some sense of the organic growth that happened on GitHub.
>> It doesn't appear that anyone else is willing to do this, so I doubt
>> there will be any duplication of effort.
>>
>
> What is the status of the work on git-subtree described in this thread?
> It looks like it's stalled.
>

I hadn't been aware of that patch. Reading the thread David Michael
Barr was going to try picking the patch apart into sensible chunks.

My own patches, some of which I've submitted to the list, appear to be
tackling a couple of the same things (e.g. storing subtree metadata in
an ini file). Mine can be found here
(https://github.com/kemitix/git/commits/subtree-usability), including
some I've not submitted yet.

If this work is still needing done I'd like to volunteer.

-- 
Paul [W] Campbell
