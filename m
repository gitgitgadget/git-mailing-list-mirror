From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 15:43:04 -0500
Message-ID: <CACPiFCLoaELx1=thKNnFD2bavjT-mokSmLOVq-uUC7xbU1U5=w@mail.gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org> <1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
 <4EE5121D.2050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 21:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZqFN-0006rV-VZ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 21:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab1LKUni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 15:43:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52102 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab1LKUn1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 15:43:27 -0500
Received: by iaeh11 with SMTP id h11so2085830iae.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j3YhxVvi2N7H12hzHJgp2t8zTyQ9tqnSiGH5K4Ku/RQ=;
        b=Ouh7ELIXymvQSLJMmr25A+NFaDQfCx762tYinF3Fu1wiKFgQE3bJ1xu4ukZG5fPO88
         sxmG2PUtgFnzoBa+IGjc8gWzdT2qyKnc2ibXK+CpeYSKFwxuCn39w1p238IBVQd+G1iO
         O+Cn2iWfxdsY+qQzTr6NyPHc64Oy6X6eDW5dI=
Received: by 10.43.53.1 with SMTP id vo1mr10666280icb.2.1323636205230; Sun, 11
 Dec 2011 12:43:25 -0800 (PST)
Received: by 10.42.189.133 with HTTP; Sun, 11 Dec 2011 12:43:04 -0800 (PST)
In-Reply-To: <4EE5121D.2050002@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186815>

On Sun, Dec 11, 2011 at 3:27 PM, Gelonida N <gelonida@gmail.com> wrote:
> Agreed. it might be reasonable to ignore the current branch if it was=
n't
> pulled.

Actually, what this means is that this should be an enhancement to git
pull ("git pull --all") because pull means fetch + merge.

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
