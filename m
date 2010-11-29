From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Append commit_list prefix in two function names.
Date: Sun, 28 Nov 2010 22:05:09 -0200
Message-ID: <AANLkTi=hBzyufVoPrWJ1ngjzc0CZ0e202MaBtke9s_eR@mail.gmail.com>
References: <0b9cde68dcdfddc13a91a63f9deb3384576164de.1289768501.git.tfransosi@gmail.com>
	<20101114211905.GB10150@burratino>
	<AANLkTi=V7e-KFhKVDLjH4TvoT6U3xmFieo5uqigPhqKF@mail.gmail.com>
	<20101127082933.GA24840@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 01:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMrFA-0004Ht-5a
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 01:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab0K2AFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 19:05:12 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41732 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab0K2AFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 19:05:11 -0500
Received: by bwz15 with SMTP id 15so3416649bwz.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 16:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pUs+FuHApxzuH1E1CMJ0bO/lXRBLfpSXqnU5+HZ6hK0=;
        b=toRdHh+OAW5bwZ23eRokwtPEzQvozFGEVq+47ZQa+xOaWWgPPm+X6/gXJK8OFeey75
         RXqWRXTxWnY9BfcTulBIWjRQplTjW+J9fz08ze4aJtBo0y3ReLWmG0jAPADcjF3MzVUa
         7uxTgSbdgBS7b3Sxz4al6K5RVSNJbB5jDvMiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gZEGp3eyNqjq8AY7J8N/eWyYDOxfbQrXUrgnIzM+xvIBNRXvhs3hbgTPMV7kEsfzeN
         nZiVwftnEtk1J8yIoqIa+8IleRSnM9hQMMTw2yiB8gY1t05tfft9Ndo0Y6EN/DZDipYQ
         +NNspQztpsS3f7QtGULt8kKdtER1yJICmaCqY=
Received: by 10.204.55.2 with SMTP id s2mr4245813bkg.40.1290989109959; Sun, 28
 Nov 2010 16:05:09 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 28 Nov 2010 16:05:09 -0800 (PST)
In-Reply-To: <20101127082933.GA24840@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162370>

On Sat, Nov 27, 2010 at 6:29 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Even if split up into multiple patches? =C2=A0I don't think it makes =
much
> sense to say "functions in the commit_list API all start with
> commit_list_"
I didn't say that in the patch.

> while at the same time leaving half of the functions in
> the commit_list API without that suffix.
>
What's is the problem with this? I don't see a reason to do this to
all the functions in the same time. I prefer to do this in small
patches. But it seems Junio is not going to pick this up?

> By the way, how did this come up? =C2=A0Presumably some particular co=
de
> was confusing?
It became with the idea of API, we see this with strbuf and
string_list. And this would be good to make the code more easy to
read.
