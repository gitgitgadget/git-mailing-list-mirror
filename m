From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Sporadic BSOD with msys git?
Date: Thu, 29 Jan 2009 09:36:02 -0500
Message-ID: <eaa105840901290636xb1e8c39w74e73f95783a1148@mail.gmail.com>
References: <20090129115442.6ce311f8@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSY1O-0007Tz-HZ
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbZA2OgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbZA2OgG
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:36:06 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:12192 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbZA2OgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:36:04 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3216911yxm.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=oUz2mr3nsKHGZ2Gh6wg5AlMj2MQPSBplbUa899IfprQ=;
        b=S8LInSPfCV6my2Bp9/EGPCBB9fcoAL/Mfpc6lEK6IXzHK0j9hWgEGh/mkyk4f48etJ
         reX+46RU5tGQfcFL/WrySSxALztADd654qVsLzxnsev9JmEtgrjCVZUEHziZ+o7lKs58
         lAPNb+AH/uoVE0hFH/+MCtVpZqJC+N0mbBqAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=WFtHc87pieLNhyeKIvJ8KTEc0V7U7fGfH8uKnC3MH3H9PcBRXy53vXKt84xlv5R4b0
         jwnA8zUDoWIOM7IFNC+LKb7/hXHQq4fQ1v+AEDsBHEV4uOIY9Yy2DHzCT4YVwZPEH2/z
         8GOOHhziCD95x9YdxvvEfrqSk7SvAFoiIFNsY=
Received: by 10.64.243.19 with SMTP id q19mr52718qbh.50.1233239762636; Thu, 29 
	Jan 2009 06:36:02 -0800 (PST)
In-Reply-To: <20090129115442.6ce311f8@crow>
X-Google-Sender-Auth: 7ece1a360a953c16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107685>

On Thu, Jan 29, 2009 at 6:54 AM, Mark Burton wrote:
>
> I occasionally have to use Windows (XP under VMWare) and thought I would try
> out msysgit so I installed the recent version (1.6.1). For what I was
> wanting to use it for, it worked OK.
>
> However, I then started getting crashes when using the Windows explorer. I would
> click on a folder to look at its contents and, whammo, Windows would crash. It
> just happened every now and again, not all the time.

msysgit does not install any drivers, so it cannot possibly be the
cause of any BSOD.

> Has anyone else seen this?

It's usually bad hardware or a bad driver. (VMWare is virtual
hardware, so buggy versions count as "bad hardware")

Either of the above can cause problems that appear and disappear based
on unrelated factors, which makes them hard to track down. But if it's
a BSOD, the root cause is not msysgit.

Peter Harris
