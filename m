From: Kevin Ballard <kevin@sb.org>
Subject: Re: .gitattributes escape character?
Date: Wed, 3 Nov 2010 14:03:59 -0700
Message-ID: <F6E88AB2-D512-45A3-87FF-46F2C9ED0092@sb.org>
References: <4CD15461.9070201@syntevo.com> <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 22:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDkVC-00018k-1R
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 22:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab0KCVEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 17:04:08 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39998 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab0KCVEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 17:04:07 -0400
Received: by pxi15 with SMTP id 15so43351pxi.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 14:04:06 -0700 (PDT)
Received: by 10.142.229.19 with SMTP id b19mr7775783wfh.217.1288818246624;
        Wed, 03 Nov 2010 14:04:06 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm14220690wfh.15.2010.11.03.14.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 14:04:05 -0700 (PDT)
In-Reply-To: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160640>

On Nov 3, 2010, at 8:47 AM, Nguyen Thai Ngoc Duy wrote:

> On Wed, Nov 3, 2010 at 7:24 PM, Marc Strapetz <marc.strapetz@syntevo.com> wrote:
>> Is there an escape character which may be used in .gitattributes to
>> escape e.g. the space-character? Could octal-escaping help here (I
>> didn't succeed)? Thanks for any hints.
> 
> You mean escape the path part in .gitattributes? Sorry, no.
> 
> I think we can teach git about path quoting though. A leading double
> quote means the path is quoted, C-style.

I agree that gitattributes needs to learn about C-style quoting. However, in the
meantime you can just replace a space with ? as it's actually a pattern. In
other words, "test/file with spaces" can be represented as test/file?with?spaces

-Kevin Ballard