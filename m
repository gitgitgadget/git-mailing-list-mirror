From: Jan Niklas Hasse <jhasse@gmail.com>
Subject: Re: Error on push (unable to create temporary sha1 filename)
Date: Sat, 27 Feb 2010 13:38:57 +0100
Message-ID: <8dacd7b31002270438ve59e43djd44e2866b697d3ab@mail.gmail.com>
References: <8dacd7b31002231311q46c1c3b9o63c57fabe696f2ea@mail.gmail.com>
	 <be6fef0d1002231654r4fe08149qa937bbd9cc83d6a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 13:39:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlLwv-0005y8-RB
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 13:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968183Ab0B0Mi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 07:38:59 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:44367 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968171Ab0B0Mi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 07:38:59 -0500
Received: by yxe12 with SMTP id 12so462655yxe.33
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 04:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=e+2m5GBDF8niGsXXMkTpxB8wOmjrOidZ0TneVzveal8=;
        b=tQkLWBZvuDvZOKBNJAPa62lsUC5zrAaegtKE7Rz3gB4oKteZz7F1b+e3FbUil5FuOp
         A43SDxGnqdkrW+9zFeTbiNOPTvDM6UkDfq3Z8uD6lMHWS06isUaaQ3v/mc4XTeJ9VxvH
         2Twdcp+TuOBKZBF0yos/XG0KOBKbl8wIOGR1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vNgGnUKhgZ497ccIuTXDxfNfWlFSpbsyQZBvb435lihgXqpEaZi9njyxwXNAvrSCFd
         pSF+KFIqB6p2YhXWlz3viHLC7iQnDeQXbHrlT1Es2qxFCL/Q37snkpxiatLX/xrMKJm8
         0GRCeiwP2RSq+Em8zi1OnFWG1gCEZKLAGN7Pg=
Received: by 10.101.131.22 with SMTP id i22mr2591473ann.92.1267274337353; Sat, 
	27 Feb 2010 04:38:57 -0800 (PST)
In-Reply-To: <be6fef0d1002231654r4fe08149qa937bbd9cc83d6a2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141201>

Hi,

On Wed, Feb 24, 2010 at 1:54 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> could you try running "git gc"? Perhaps you have temp files from
> previously aborted/failed pushes lying around.

The output of git gc looks like this:

Counting objects: 102, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (52/52), done.
Writing objects: 100% (102/102), done.
Total 102 (delta 34), reused 102 (delta 34)

But still the same error message when trying to push :(
