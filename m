From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Fri, 10 Feb 2012 11:27:35 +0700
Message-ID: <CACsJy8AT68zYHnWGurVW19-SZMXoMYhagWqG7iQENBLU9qsRMA@mail.gmail.com>
References: <4F3120D4.1050604@warmcat.com> <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org> <CAHkRjk6dr=5wxm+iSC2_CSB-q3k2WG_Um+X7dwsy-H8tL508EA@mail.gmail.com>
 <20120209175158.GA7384@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Karl_Hasselstr=C3=B6m?= <kha@treskal.com>,
	=?UTF-8?B?QW5keSBHcmVlbiAo5p6X5a6J5bu4KQ==?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 05:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvi5t-0004JI-43
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 05:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511Ab2BJE2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 23:28:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48938 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab2BJE2G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 23:28:06 -0500
Received: by wgbdt10 with SMTP id dt10so2385749wgb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 20:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BCFuyitfRBXg5acw5XB60BP290EAE56FiU2G3JrpHlI=;
        b=sTjc89oKf7tyHKLHjGk0mL6O0gk3Jgnd01drBW5/uJ7NnfNkkLgccrUXq+lgKMw1Uy
         tCI3QdumeFFd0gcjY325QQ3uvgRAUX677dLnpfXgDy5gGvey1hlbTf2ViyBQzmEduBf3
         XZpYGU7xIloxdZFCNWxEoob0IhM2WpO7rXhaY=
Received: by 10.216.136.17 with SMTP id v17mr1700436wei.26.1328848085265; Thu,
 09 Feb 2012 20:28:05 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Thu, 9 Feb 2012 20:27:35 -0800 (PST)
In-Reply-To: <20120209175158.GA7384@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190379>

On Fri, Feb 10, 2012 at 12:51 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> No. =C2=A0There is one list of supported headers, and this list is th=
e
> standards body that maintains it[*]. =C2=A0So if you end up needing a=
n
> extension to the commit object format, that can be done, but it needs
> to be accepted here (and ideally checked by "git fsck", though it's
> lagging a bit in that respect lately).
>
> [*] http://thread.gmane.org/gmane.comp.version-control.git/138848/foc=
us=3D138892

Doesn't this deserve a document in Documentation/technical? It's also
a good opportunity to document tree and tag object format in addition
to commit object. I did not check thoroughly but the commit that
introduced encoding field, 4b2bced, did not come with any document
updates, so I assume it has not been documented ever since.
--=20
Duy
