From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Fri, 6 Sep 2013 15:34:08 -0700
Message-ID: <4065B5CE-7E81-41F3-B9DE-FDA05C43AAB0@gmail.com>
References: <522A36AA.3050701@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 00:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI4bY-0000Fe-0U
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 00:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab3IFWeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 18:34:12 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54495 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3IFWeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 18:34:11 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so3917569pad.37
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=rIIQtPIE8YMgWGc2X7hL9zj2qZHpJ5FIhEQTT9cRW4k=;
        b=xuhGWfjgLXR9dvMH3IZvU1n4ANy94F4hK7fLlokuTd8OJEwNEOpNg12PBh8iqXDAuX
         lY+fQ3LBcLt9O1dAdObwmg2AFya/hERmbTL3Tvp0rpu73l7koZBnvPOqSZxpKHyklc67
         CUhUsgnK2auwdD43y2ZTle4Lh+PC8jQZfkwASXlle1PLT3OPFc40VgXJ3a8iPH3JR4LC
         mJp5o6fKXgQgJodT5ib//7F+3UraJCSkvuQtlFHoU/MDnpkE8Qn7XLhXE8EZgy+ApHY8
         mg8pgzi06CnunfMvr4tWVJKFHmOLA7IJ/8tuhN/fMv2USjGEBXkGAbhE3rcsOVyLd15G
         Fg7w==
X-Received: by 10.68.76.101 with SMTP id j5mr5353919pbw.67.1378506850795;
        Fri, 06 Sep 2013 15:34:10 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id gg10sm6128004pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 15:34:10 -0700 (PDT)
In-Reply-To: <522A36AA.3050701@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234108>

On Sep 6, 2013, at 13:10, Sebastian Schuberth wrote:
> For custom builds of Git it sometimes is inconvenient to annotate tags
> because there simply is nothing to say, so do not require an  
> annotation.

It's not that hard to add -m "" to the command line:

   git tag -a -m "" new-annotated-tag

if you're just trying to avoid the editor or thinking up a message.   
Is `-m ""` really that inconvenient?
