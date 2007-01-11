From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [RFC] Adding stack-level logging/undo to StGIT
Date: Thu, 11 Jan 2007 00:06:55 +0000
Message-ID: <b0943d9e0701101606w649fc26ara73f2c9212de4a33@mail.gmail.com>
References: <20070105231944.GB6179@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 01:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4nTI-0004DR-9D
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 01:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbXAKAG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 19:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbXAKAG4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 19:06:56 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:31038 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965198AbXAKAG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 19:06:56 -0500
Received: by nz-out-0506.google.com with SMTP id s1so216012nze
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 16:06:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRLbP/3zgg0VdC5PRcCFO3JYlvwUKE8M2Vc3GgrzxBQcp6uX4W7Q6TSNbhmO8FuUs2kr021AFcQAyBnJW/EkJZCc9VL6IMJsvl1wb5kBifElTQ78gX9kbq90ZGaMKYtLxXPKKHjWG30IKyapZHDF9dEQKeap8jlAd+/u7EnelGs=
Received: by 10.65.240.5 with SMTP id s5mr1316509qbr.1168474015382;
        Wed, 10 Jan 2007 16:06:55 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Wed, 10 Jan 2007 16:06:55 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070105231944.GB6179@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36541>

On 05/01/07, Yann Dirson <ydirson@altern.org> wrote:
> This mail is a draft collection of design ideas to hopefully progress
> towards full "undo" functionnality in StGIT.  The issue is not
> trivial, so I'd prefer to hear from users before starting to code
> anything :)

(couldn't finish reading all the e-mail, too long :-) and I'm too tired)

The idea of transactions and unified undo/redo is very good but it's a
bit more complicated with the current structure, which I admit isn't a
good design (too many files and metadata; I initially started StGIT as
shell script prototype and moved to Python without re-designing the
structure). Ideally, we would have the full stack state in a single
file that could be stored as git object and get unlimited undo
facilities or history tracking.

But this is part of a post 1.0 development. I plan to fix some of the
outstanding issues (still need to create the TODO wiki page) and go
towards a first 1.0 release candidate (and release 1.0 sometime this
spring). I think StGIT now has most of the features I initially
planned for 1.0. After that we can re-design the current structure and
make it simpler to support transactions and full history for both
patches and the stack as a whole.

-- 
Catalin
