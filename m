From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't 
	access location
Date: Sun, 13 Jun 2010 15:20:14 +0800
Message-ID: <AANLkTilIGhEXlhEbAAXIU-_1Qg8AJoCalkilWGCzIP1m@mail.gmail.com>
References: <1276390106819-5173157.post@n2.nabble.com>
	<AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com>
	<1276410911244-5173593.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: ddw_music <jamshark70@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 09:20:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONhUZ-0003ip-KN
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 09:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab0FMHUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 03:20:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63701 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab0FMHUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 03:20:15 -0400
Received: by iwn9 with SMTP id 9so2074682iwn.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=CJwwLEZa9SLmOaQbd5I8Zo7/CW1Y75Upvpd5mZ3Hq04=;
        b=WAhIoCBye/xX958vPrhclAdm5IwborR6qLZreQMX1+gY4Nsr6uougVifuetINq2z+1
         qFdCwIXwBacth+BWv+lAkgpwgzWDmQ4nuFbEMjnWv/QNcPRz52pEARAt7C6WvSAQBKOE
         YhKxcemmM7cWW+sJt5P7Ek2Otf3DWfHYwaQgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mlujBcPmfCOy1ts3Grc6r0uXL5Krf2zBjn4jwRnrA84kF67hlSAstJHwze9OXtfYZh
         FqxBI7yETJsywUtFHiw+w8zf7PElUoPDjQiemP1ajbWf/7JpAFZE7OpsD5KcrtSOwgjc
         4KuDJ2aFstp3+NxMvob95Puy/bOM+0tNlWMWI=
Received: by 10.231.26.23 with SMTP id b23mr4528435ibc.8.1276413614732; Sun, 
	13 Jun 2010 00:20:14 -0700 (PDT)
Received: by 10.231.31.141 with HTTP; Sun, 13 Jun 2010 00:20:14 -0700 (PDT)
In-Reply-To: <1276410911244-5173593.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149039>

Hi,

On Sun, Jun 13, 2010 at 2:35 PM, ddw_music <jamshark70@gmail.com> wrote:
> Still a problem pushing, though: the famous "cannot lock existing info/refs"
> message. I see a reference on a Google group -- a problem/solution post* --
> but that's inaccessible to me from mainland China. Likely to be something
> simple, but I have actual work that I need to get back to at the moment :-)

I vaguely remember encountering this. Use a dav client, like cadaver,
to manually release the lock.

  $ cadaver http://yourserver/git/kc/
  > discover info/refs

  <bla bla: look for the lock token>
  > unlock <token>

Sorry if this looks vague - I don't have access to a DAV server.

-- 
Cheers,
Ray Chuan
