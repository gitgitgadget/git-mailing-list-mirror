From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: gitbox status (for those who want to hack on it)
Date: Sat, 11 Aug 2007 19:37:57 -0400
Message-ID: <fcaeb9bf0708111637v7d9f41dfkef5bb0dfc7ac46e8@mail.gmail.com>
References: <fcaeb9bf0708041040w6d2b3f2cu1680e1e7dc542ffb@mail.gmail.com>
	 <Pine.LNX.4.64.0708051635170.14781@racer.site>
	 <fcaeb9bf0708051841w4701d04dw894b61c5a26d6ed5@mail.gmail.com>
	 <Pine.LNX.4.64.0708060323200.14781@racer.site>
	 <69b0c0350708111458u5c9d4b16kc118cee4666d376a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 01:38:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK0XD-0006uJ-5Y
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 01:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbXHKXh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 19:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbXHKXh7
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 19:37:59 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:11390 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbXHKXh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 19:37:59 -0400
Received: by an-out-0708.google.com with SMTP id d31so221037and
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 16:37:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZWYci9uHYdfNhVeI4EuYJPj0v0LjBVJ3N5OjnGq9agvLt482gITd2Ajrr7oe63VjhtqwtBsbQH4Spf7yBx+5S0dkAulqsoebiIuGCPCcwb0ucYHFQrur26bJ9jvWhKqA13hoV40uyni6Q9G9pXk4+VHasJZTMv3OwEyE1eyQnzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DlbVN3ATlPIx0YZLcz6AMSR6WS2RhzHc1XZs2XIT4C2VIn10Qp9eeFoCzFPaoulkxAdwQXlELeT9QWl4SCmvW9lWrLFDgJ4yycU4OEjZVUo44xg7XxwU1hklAt9Y19+mMBSt2YbIem4UVJvBHIYKYLCFlK4FaUP8nVIChG7I8S0=
Received: by 10.100.121.12 with SMTP id t12mr4099118anc.1186875477800;
        Sat, 11 Aug 2007 16:37:57 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Sat, 11 Aug 2007 16:37:57 -0700 (PDT)
In-Reply-To: <69b0c0350708111458u5c9d4b16kc118cee4666d376a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55649>

On 8/11/07, Govind Salinas <govindsalinas@gmail.com> wrote:
> Hi,
>
> I'm interested in the various git on Windows projects.  I can't seem
> to find any information on gitbox on the web though.  Can you tell me
> a bit about it?  What makes it different from the other cygwin git or
> mingw?

>From user point of view, it's basically mingw git without msys
requirement. You still need msys to be able to compile git though.
From developer point of view, it's mingw git with a couple of unix
tools ripped from busybox.
-- 
Duy
