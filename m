From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t 
	for greater compatibility
Date: Wed, 30 Dec 2009 01:49:20 +0100
Message-ID: <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 01:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPmki-0000xo-B6
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 01:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZL3AtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbZL3AtY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 19:49:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:61149 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZL3AtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 19:49:23 -0500
Received: by fg-out-1718.google.com with SMTP id 19so4930039fgg.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jUAbHIOEWknRxf4m95vTZFn2HJtd8IxAFsuz4Ws/2SM=;
        b=X4z5D/O51xQxh+VdebLL55SmWQCjVCJV9avVUUydRZy3bCeWu3iLBqf/1mT1yecu38
         GRGFdJI3kJthT8H/YKJb2P1gZlBeFcwMxERTOxlSkTIAAMltRVkHq131n8sYwwmITWYH
         EyGGUx+U791HQHTtNJXQp+qwqrX9s637ZoU58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=yIXJ2SkZmLnVNT4u9SAyjs7wel8bXqygq/iy5bmijfAx8FGmEKoOIkFQUvMkSxGdUA
         wmaBnhhtAVoRbEm0+N8CYgiw4dxhwU1Kkjv/56KVUR/5yqmV9rN+aI1Syw1qnf0hZ9jV
         eQVxQAoB/OvCVDwPvvcQhFpQtqPaQR5KChBj8=
Received: by 10.87.74.30 with SMTP id b30mr22934803fgl.15.1262134160901; Tue, 
	29 Dec 2009 16:49:20 -0800 (PST)
In-Reply-To: <4B3A7000.4050308@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135844>

On Tue, Dec 29, 2009 at 22:09, Johannes Sixt <j6t@kdbg.org> wrote:

>> MinGW: Use pid_t more consequently, introduce uid_t for greater
>> compatibility
>
> Why this? Compatibility with what? What's the problem with the status quo?

I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit. h2du
depends on libpopt, and either of the two requires the uid_t type, I
do not recall which. And while adding the missing uid_t, I felt it
would be right to actually use uid_t / pid_t in the function
prototypes.

-- 
Sebastian Schuberth
