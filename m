From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] inconsistent behavior with --set-upstream vs
 --set-upstream-to
Date: Tue, 2 Apr 2013 12:08:08 -0700
Message-ID: <20130402190808.GH28148@google.com>
References: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
 <20130402172333.GB24698@sigill.intra.peff.net>
 <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:08:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6ZW-0001QR-R1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760885Ab3DBTIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:08:14 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:54579 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611Ab3DBTIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:08:13 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so407637pdd.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KScOsllmaskPN+y95YTratAKFbKA9NZXzABrvLJtGG8=;
        b=MzFb1NUxyqT3vffMvU6Dc6Wj2561kkV3W7AyAbo173dDrdEyaQd5sJ5IlEMNWTOoFN
         6X64CHKpiF+kM+GLLk+UOpurTJ46ew9CzNpxw/gQy7uOCz7z0u4ibLd1FfvYUm26tbG2
         +esCM3Lwa2/WO3yM8tsnuvcB1gQ4UQp1f8N8XmfiYiPhRlvWiWdrv6Do4VmokVnGLDxl
         jej+iTEb2ESpPjfn9+lJR57JiULUuiBjS5rojgRgeKxFvJwYoRu/cp/JTdS3j9lH/3CL
         FZpFUJaAwM+JjkUV7zDVKRWXA3y/3J+pL3b1QqlkCz/pFLX1jJbvgqh4moJRhhzHWFZ7
         FRhA==
X-Received: by 10.68.234.42 with SMTP id ub10mr6583376pbc.1.1364929693218;
        Tue, 02 Apr 2013 12:08:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qs10sm2722649pbb.28.2013.04.02.12.08.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:08:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219850>

Garrett Cooper wrote:

> I push the branch to origin/ and then things tend to work, but since
> I obviously had been doing things wrong what's the correct order of
> operations for creating a branch and setting the upstream
> appropriately?

git push -u origin pjdfstest-onefs

Thanks for a useful example,
Jonathan
