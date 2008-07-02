From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 21:58:20 +0400
Message-ID: <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
References: <20080702143519.GA8391@cuci.nl>
	 <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE6bw-0000ms-CQ
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 19:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYGBR6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 13:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYGBR6X
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 13:58:23 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:23013 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYGBR6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 13:58:22 -0400
Received: by yx-out-2324.google.com with SMTP id 8so142092yxm.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mpM86U7vvzvDxGBrWGs5GM3IVk22n84LVjHf5RDNAAQ=;
        b=uXlTf0QD2n7FMO2m4L6yQ3s3G3xgYA2Pvq+h7HH6lGCKqLGrz8Lj4l9Jtvv5ce3yTl
         zahRLpNG9me79uPM0iYg/lgG+SlejQ/Vrtk0r+wAxShmUxVOFhnK6DJHpCZipOX4Ygt6
         6q2B4HuYnCjctppjBF1cIqETgFY4FJnnv7/V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GWhK3drrqFA3Nfx86EQBS5jKVky4v5y1yETpJ5jDerLGgsHfhCgVxDNKXaHnGbSl5i
         7uwoSWH6lR8l7nUsrGH9zYnz14mTQSk0iC9sVPx0RtYDuIm5WXydYhojEBxNc0r0OBvC
         Z1UlNCCZapsFxQT81xiMTDo3TLMftZupUm01A=
Received: by 10.142.180.11 with SMTP id c11mr3163297wff.159.1215021500572;
        Wed, 02 Jul 2008 10:58:20 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 2 Jul 2008 10:58:20 -0700 (PDT)
In-Reply-To: <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87169>

On Wed, Jul 2, 2008 at 9:19 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>
> However, if you want more than just ability to edit commits in a text
> file but also inspect changes using normal git commands and gitk (as it
> is possible with grafts), it will require changes to the git core, which,
> perhaps, not difficult to implement using pretend_sha1_file(), but I am
> not sure that everyone will welcome that...

On second thought, it may be not necessary. You can extract an old commit
object, edit it, put it into Git with a new SHA1, and then use the graft file to
replace all references from an old to a new one. And you will be able to see
changes immediately in gitk.

Dmitry
