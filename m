From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 11:38:57 -0300
Message-ID: <b8bf37780908010738y305b67c7v3c4e8f2190bfdc93@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <4A714F5C.70000@eaglescrag.net>
	 <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 16:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXFjn-0002Xn-CK
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 16:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbZHAOi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 10:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZHAOi7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 10:38:59 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:55205 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbZHAOi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 10:38:59 -0400
Received: by qyk34 with SMTP id 34so2118670qyk.33
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6qEVhh+MMEZ5UeIx7O8LSyB0pF4YJ/PmEZpDbTDtJMY=;
        b=mxYuMQ/Dt5o6NzOiQNHRAKB1g9HCkDINUBIpIDwLeCEnO4A3SpgEc9Yyy4WPz+3JAp
         g5wMKU2xuEBMyYzwQ/p2GjjoRRM4hB+B8zaNERRuZqVrcK+7Wp0gP11qnTiIDW2Crzr7
         CvTdDXYbuzogHP3Ns5qfRZhBzmzQxwBClnlEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L2Jh7vHO1ah7qj2CL8rqt+DXlo2gT7SCLSWthb8fPndmB7eOfpsKeVGg3PlP3wcszI
         BTdJLOrxVHVZczjNbB4pxbJPysnBuuujBs7Xwae8ILkrNbL6TJew5ibIITsH/58Bij1M
         dz3KbYbkwWdPYcYtkjFmjIEqOxVrFXQOqKqf4=
Received: by 10.220.99.71 with SMTP id t7mr3654070vcn.98.1249137537893; Sat, 
	01 Aug 2009 07:38:57 -0700 (PDT)
In-Reply-To: <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124626>

On Sat, Aug 1, 2009 at 4:43 AM, Alex Riesen<raa.lkml@gmail.com> wrote:
> On Thu, Jul 30, 2009 at 09:44, J.H.<warthog19@eaglescrag.net> wrote:
>> Don't use 'lzma' the command, use 'xz' ( http://tukaani.org/xz/ ) as it uses
>
> The host seems to be down.
>

You can clone it here: git://ctrl.tukaani.org/xz.git

Best regards,
Andre
