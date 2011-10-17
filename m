From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 21:45:16 +0530
Message-ID: <CALkWK0ke03kPwFommtVUB5iidgqzaqqjBgAot_4F=LjxcAogsA@mail.gmail.com>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org> <4E9C3D27.3060504@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 18:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFpqo-00072g-HE
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 18:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab1JQQPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 12:15:38 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61896 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab1JQQPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 12:15:37 -0400
Received: by eye27 with SMTP id 27so3121305eye.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=R7z82r5ZDn6Y1DibvSZfT9VpPwvE0S4PqBoiy7NHFpc=;
        b=vyCaMKBlhPM4oUcKPVHwDMxRWsnDRbIOsdNFvfbiAQ5gtX6VJjP5ONEz7GO7h/9xvB
         sIRW/wVAhewHvc0ItuFkseuFpkQKJfYmYinXOISROL6De73zup+qPFeAnUrFk+MqWmbf
         TMQ5jhRa0kQU9TGddggLFFR7OYQ5dyccu+adg=
Received: by 10.216.134.82 with SMTP id r60mr6640835wei.105.1318868136228;
 Mon, 17 Oct 2011 09:15:36 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Mon, 17 Oct 2011 09:15:16 -0700 (PDT)
In-Reply-To: <4E9C3D27.3060504@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183796>

Hi Marc,

Marc Branchaud writes:
> Being hip and modern :) I use separate remote refspecs. =C2=A0As I re=
ad your post,
> I kept thinking that it makes no sense for fetch to ever update local=
 refs
> and that you're a victim of your stodgy old ways.

Hm, I like the symmetry with the `git push` UI.  I wouldn't want to
checkout every non-ff upstream branch and merge by hand before
rebasing my work on top of it!

-- Ram
