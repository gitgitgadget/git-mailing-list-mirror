From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 23:30:41 -0400
Message-ID: <81bfc67a0905132030g39432e63ne72ace88edf79848@mail.gmail.com>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com>
	 <4A09594F.4040603@drmicha.warpmail.net>
	 <7vprec4znj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 05:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Rf5-0002lt-Dp
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 05:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbZENDam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 23:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbZENDam
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 23:30:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:13675 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbZENDal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 23:30:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so596770ywb.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2WLVO7eFZCkRzSrPCQeJzwtoU4OQVzFV1AiVBvlnZFM=;
        b=hyXHbMHJOZzYxS1ALYRDJ6XRdSDLiDL/Phsah5vCs/bzHVnesZ1CRUBdzxl1cY8+Wx
         KfSsz9JXYU4IrOqChNY409mf0VB/YhFut+B2D11RO/bMzb54dhuOxr8cSu+IfQq2rlxy
         DkQoC+AvEap9U3szbx2+WLTPRsDqMx/p1VpQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kxUtSVejF/CcBjRUcAf6ExROCa72hFc0xZHTrSAEZYR0hLNx1IH/97JaOTcnnxFbKw
         1BrXaIAB4sdiqDkXlg7SUhVc8+hkpXmOujzeT35isNclcNIJ0SQIN1xvQnmRdIfX9pDK
         BTGma+0+zLw5WOOMBtkbifc6MiYNWrbYaeilI=
Received: by 10.100.164.20 with SMTP id m20mr2437310ane.31.1242271841361; Wed, 
	13 May 2009 20:30:41 -0700 (PDT)
In-Reply-To: <7vprec4znj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119128>

On Wed, May 13, 2009 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks for saying this concisely, and saving me from repeating this.

I just don't think one should have to explicitly set something to shut
warnings up. defaults are there for a reason. next thing you know it's
going to ask me if I'd like to continue, and then it will ask me to
press n for next.

Why even have them? if people want to know what's changed they should
read release notes.

maybe a better solution would be to have a setting. set all warnings to off...
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
