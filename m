From: Klein W <wineklein@gmail.com>
Subject: Re: remote helper example with push/fetch capabilities
Date: Mon, 15 Dec 2014 17:41:32 -0500
Message-ID: <CAPCWLt5pW6kwP4FCsJqG+o5d=p_WgKMSXqaANY7vSe6Bh7tMxQ@mail.gmail.com>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
	<20141215204740.GI29365@google.com>
	<CAPCWLt4=oYTPFXktCj8CgqNncaO2=sbwZcPOVa+a5wgt7HPCUQ@mail.gmail.com>
	<20141215214459.GJ29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:41:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0eKg-0002ZK-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 23:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbaLOWle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 17:41:34 -0500
Received: from mail-la0-f65.google.com ([209.85.215.65]:45480 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaLOWle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 17:41:34 -0500
Received: by mail-la0-f65.google.com with SMTP id hs14so2131783lab.8
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 14:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ab5UIy9UE1ncfsUmffZXjUPZZdng6hP+RFBx4LAyAmk=;
        b=xG1n8B87hsHdGLNQVoKz6EVUgCArmpwMOm0qU/GpUT0gcrQcqiAj3YpeDjdJpWBvRj
         pFoliE/IOopN3R8I1EoxCWpCzb3WO68MTTS0zqbqMoxlYen33AeOeqvslNI72Po4wHcg
         Pb/kvAfEpn6nBv0O9iGlUs9QxvPrSoysvhR4QTzpwktLPsaCXNjanv4Pl0Vr0p9pNm6V
         3cpJxMft3ym0LjV0l9XbTFc6RlBMvwviE8cOTmgwhPc2qGXSZQUqEWxElyE/Xeq/EMU/
         UqUIJkozbIMAOAIPIR3s9ISfKDSV1w0MOkh9rNTLAuqLzEWy/24gaOFUreVsoYXkhSVE
         Er9w==
X-Received: by 10.112.12.102 with SMTP id x6mr33038940lbb.29.1418683292328;
 Mon, 15 Dec 2014 14:41:32 -0800 (PST)
Received: by 10.114.216.100 with HTTP; Mon, 15 Dec 2014 14:41:32 -0800 (PST)
In-Reply-To: <20141215214459.GJ29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261432>

On Mon, Dec 15, 2014 at 4:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> I'm trying to write a remote helper for hosting git remotes on Amazon
>> S3.  Do you have any intuition about which capabilities would work
>> best for this case?
>
> fetch/push.  I'd suggest looking at the "dumb" HTTP code (fetch_dumb,
> push_dav) in remote-curl.c to start.

This seems like a good starting point, but are there any simpler
examples that are not clouded by WebDAV/Curl stuff?  Perhaps a remote
helper that reads/writes to the filesystem directly?
