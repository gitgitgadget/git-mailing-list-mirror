From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 05/10] Documentation: remove howto's now incorporated into manual
Date: Tue, 15 May 2007 12:05:07 +0200
Message-ID: <8aa486160705150305w5265a5d5w82cfaee49ff4e8b1@mail.gmail.com>
References: <-7504805328344940638@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue May 15 12:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hntu9-0001XO-4C
	for gcvg-git@gmane.org; Tue, 15 May 2007 12:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760273AbXEOKFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759709AbXEOKFK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 06:05:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:37472 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760273AbXEOKFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 06:05:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1868740wxd
        for <git@vger.kernel.org>; Tue, 15 May 2007 03:05:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YpLUqvKUvQzXAQdtsEJ+dGzO1U4cda0vxJV6OnyDWvCDDDLIVaDx5dexSVuoWTm6u3os74B95lrVKhtshzOuJOMXYegmMrdvxUISsTJis5Al2syc9zxOvVwF3b+dW1ZocurcziTvkzRtnct/tZphmSEg2tiGphOi4Arp01wc/p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AhEiZfJ+uMoQ4r4N2Qm9hD2O0+5Iq/MoU8IOi8s00UvJbDGDfV05hIZPT1cDLw8W85XNThwVhuPRsoNxHHXFnKQ4PuukgysEwOjX4490IS/Yi1e5TIiciYn49iqDQmyVV4j5LxQE17UzO0j9mZeU9xuh3vdHlo+SiBmz3zLHqfM=
Received: by 10.78.186.9 with SMTP id j9mr2579259huf.1179223507209;
        Tue, 15 May 2007 03:05:07 -0700 (PDT)
Received: by 10.78.133.14 with HTTP; Tue, 15 May 2007 03:05:07 -0700 (PDT)
In-Reply-To: <-7504805328344940638@unknownmsgid>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47333>

On 5/14/07, J. Bruce Fields <bfields@citi.umich.edu> wrote:
> From: J. Bruce Fields <bfields@citi.umich.edu>
>
> These two howto's have both been copied into the manual.  I'd rather not
> maintain both versions if possible, and I think the user-manual will be
> more visible than the howto directory.  (Though I wouldn't mind some
> duplication if people really like having them here.)

+1

What about the core-tutorial.txt? It is also included in the Git User
Manual. We could backport the changes and actually do an
include::core-tutorial.txt[] in the user-manual.txt.

Santi
