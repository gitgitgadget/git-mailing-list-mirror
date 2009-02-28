From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] fix git format-patch --cc=<email> format
Date: Sat, 28 Feb 2009 11:15:35 -0500
Message-ID: <76718490902280815if1c3fa7o790112b410d52224@mail.gmail.com>
References: <1235824944-4967-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Peng Tao <bergwolf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 17:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdRsZ-00061j-UO
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 17:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbZB1QPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 11:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZB1QPi
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 11:15:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:56399 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZB1QPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 11:15:37 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1627434rvb.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W4es0Ciw9QN+bSpjFbKHvVen/LrPC6E+y0+bVkXhBiE=;
        b=MODTamjP5/6DKvDId/iYRXKrZqmHQVxKtyWFQ3Z552nRl6/tsUTI6gQTwUzh2HJaC2
         ld7oMS+2LrYz9SfXMSWprtfMw4MeaNJ1mvV9w0ecu+NmgQ3OVsKbNHC9ZXp5qtLzd/Cs
         Z3cblJ82vv7tyDN+J2X/r/lCEpXoXkiOrBkns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=coWja/4XPvYK1Tjm9dcq8FA1v+HcLZWoWqjJUQcYMLOVLze1YmZK4M6HDisY4CBeJF
         BKUYxtyS1v7mUuUFuapi/7IQObiALTrA9eSlcr69jxd918rIUmzfPcvA8/kWAaW80Yx7
         a+p4NCyJcVN5loi7bVg6a/ki4GdxuB3nn7IPg=
Received: by 10.141.76.1 with SMTP id d1mr1862885rvl.110.1235837735530; Sat, 
	28 Feb 2009 08:15:35 -0800 (PST)
In-Reply-To: <1235824944-4967-1-git-send-email-bergwolf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111770>

On Sat, Feb 28, 2009 at 7:42 AM, Peng Tao <bergwolf@gmail.com> wrote:
> If there are multiple --cc=3D<email> arguments, git format-patch will=
 generate
> patches with cc lines like:
> =C2=A0Cc: <email>,
> =C2=A0 =C2=A0 =C2=A0<email>
> which git send-email fails to parse.
> git send-email only accept formats like:
> =C2=A0Cc: <email>
> =C2=A0Cc: <email>
> So change git format-patch to generate patches in a proper format.

This is fixed in next, but we fixed send-email instead to handle the
messages that format-patch generates, as they should be valid.

j.
