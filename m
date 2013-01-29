From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Tue, 29 Jan 2013 16:25:49 +0100
Message-ID: <CACBZZX7RA7dLcFhaHmmK97Kxfa9zLmozfdx5s9C=29DJOceq-A@mail.gmail.com>
References: <5104E738.602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 29 16:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0D4z-0002KP-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 16:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab3A2P0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 10:26:12 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:55954 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab3A2P0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 10:26:11 -0500
Received: by mail-oa0-f51.google.com with SMTP id n12so550758oag.10
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fxW8DGvqezaWa+vEi/0UozmSFCpwlOHR0TShiHZILKI=;
        b=FBFUOXrSbBAjOE9TCN/ihsHQd1WcXQS3zVxVxqL9jUisZ1I8+wYTcjKxOB6z2apCkX
         bZgYYH0PzqkgqnOoreOOfALOBhwvG5vYdWB84SfPk5rICX4u4GrZerIV/gkHXni8nZV8
         bQ35Kq0rkTu1cMw1YTOwT+lrtz/OSq0ue7AHH4HPCoQyVUURbS1w5Q/eB8Bj7yR+F+iz
         ZkFzyTQW6ngdpqRAK6LmHpW2fw+x5+twTwnwnzcanya3A9OSlylTEffeUJFpVFB44A7W
         oCB5ICu430qRZTiVNPwLTTlPQ8nNPH6+Ka77047uP5wLLLdnm6Qhk1h9eDMmt4rBHtNZ
         00bQ==
X-Received: by 10.60.2.135 with SMTP id 7mr961233oeu.127.1359473170550; Tue,
 29 Jan 2013 07:26:10 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Tue, 29 Jan 2013 07:25:49 -0800 (PST)
In-Reply-To: <5104E738.602@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214941>

On Sun, Jan 27, 2013 at 9:37 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> A while ago, I submitted an RFC for adding a new email notification
> script to "contrib" [1].  The reaction seemed favorable and it was
> suggested that the new script should replace post-receive-email rather
> than be added separately, ideally with some kind of migration support.

I just want to say since I think this thread hasn't been getting the
attention it deserves: I'm all for this. I've used git-multimail and
it's a joy to configure and extend compared to the existing hacky
shellscript.

I'm not running it at $work yet because I still need to write some
extensions for to port some of of our local hacks to the old
shellscript over.

I fully support replacing the existing mailing script with
git-multimail, it's better in every way, and unlike the current script
has an active maintainer.
