From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Thu, 25 Jul 2013 23:42:10 -0700
Message-ID: <C8089D89-160D-4769-9E99-04FE310805AA@gmail.com>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79> <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79> <20130726043748.GA20286@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 08:42:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2bjG-00067x-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 08:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab3GZGmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 02:42:14 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55267 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3GZGmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 02:42:14 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so1671456pab.7
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=6Ol4UUYIczq942lotVpAeU0G/2GZckLFpK+QPqwR40w=;
        b=cAZCjbJ4qwQ9Klr+OCmBOoTUErb7r75Ulr3GvgkvkFjOmWSv5vDoD3JzqxFL9aApH2
         6Jw8wxrfxmnKQYsmTloAFFIZD4Q6FQg7SK9IzSVDq55H89/vFMVjcjrJ1jodFGc7QGlT
         jCZ5SmuX6+a+nY38akrlOR7ADLx97EmmrR7vHwTQafop+tlhGd1GVM73eW3WOYRHdLL8
         6k4L6aTBFyJnZdgaVZbDsuCvjDTvABFBxOXATas9GYV4xUuflSTOD6ItadO+qIAgj+1a
         pajsKRJUynL1KMc83jqhydBz/cD9JitV2yVFHDI4zlwzUlG3FFeoUrAlHlMPiCvp4Wxj
         aJhw==
X-Received: by 10.68.225.197 with SMTP id rm5mr52273809pbc.159.1374820933715;
        Thu, 25 Jul 2013 23:42:13 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id vi8sm58225435pbc.31.2013.07.25.23.42.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 23:42:13 -0700 (PDT)
In-Reply-To: <20130726043748.GA20286@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231169>

On Jul 25, 2013, at 23:23, Kyle J. McKay wrote:
> On Jul 25, 2013, at 21:37, Jeff King wrote:
>> You should add your S-O-B, too, for your bits.
>
> Yes.  I wanted to make certain it didn't get applied just yet. :)

Looks like it got patch snarfed anyway. ;-)

On Jul 25, 2013, at 23:07, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Will queue the attached, unless you spot glaring errors made by me,
>> coding while drunk ;-)

On Jul 25, 2013, at 21:37, Jeff King wrote:
> So this patch looks pretty good to me; the two points I raised above  
> are
> how I would have done it, but they are relatively minor if you do not
> agree.

So Yeah, looks pretty good to me too then. ;)
