From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: Verifying the whole repository
Date: Thu, 23 Oct 2008 15:14:12 +0100
Message-ID: <b2cdc9f30810230714x3301a15by9341de79d418f761@mail.gmail.com>
References: <b2cdc9f30810230659n15f44f64l571a0df3dbe104d9@mail.gmail.com>
	 <ee77f5c20810230705l20339a1dj87b855bf3321f796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 16:15:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt0yG-00005o-Un
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 16:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYJWOOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 10:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYJWOOQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 10:14:16 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35280 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbYJWOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 10:14:16 -0400
Received: by gxk9 with SMTP id 9so1466457gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 07:14:14 -0700 (PDT)
Received: by 10.90.69.7 with SMTP id r7mr593935aga.102.1224771253029;
        Thu, 23 Oct 2008 07:14:13 -0700 (PDT)
Received: by 10.90.105.11 with HTTP; Thu, 23 Oct 2008 07:14:12 -0700 (PDT)
In-Reply-To: <ee77f5c20810230705l20339a1dj87b855bf3321f796@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 094601496971357b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98968>

On Thu, Oct 23, 2008 at 3:05 PM, David Symonds <dsymonds@gmail.com> wrote:
> On Thu, Oct 23, 2008 at 6:59 AM, Alex Bennee <kernel-hacker@bennee.com> wrote:
>> Do any of
>> the other commands implicitly ensure all objects in the repo are
>> correct and valid? git-gc?
>
> Try:  git fsck --full --strict

Ahh, I forgot that git was written by a filesystem guy ;-)

Thanks.

-- 
Alex, homepage: http://www.bennee.com/~alex/
