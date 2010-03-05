From: Mark Lodato <lodatom@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 4 Mar 2010 20:32:08 -0500
Message-ID: <ca433831003041732k69c7cadcuf8f7feaabf3e372f@mail.gmail.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org> <ca433831003041730w7ccbc953kad3b600e7b112e0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 02:52:52 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnMP6-0004hA-FW
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 02:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0CEBcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 20:32:32 -0500
Received: from mail-qy0-f172.google.com ([209.85.221.172]:34186 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab0CEBcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 20:32:31 -0500
Received: by qyk2 with SMTP id 2so442823qyk.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 17:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6yZQOAApFlP+FZF76waB8VRf7wAnX+q8Q6nu+ENl8Ak=;
        b=NwIJ37SWTAcQHipWxdVxh3YWlrbSLvQ+ocCt1P2vRsunAOG8HWbb821/wcyW9Yf824
         XRc3vGx791jloYlvPYDlDLXWh78dGt+9ZZ29JVmax/XzA3PxPsPFEio2GQXqlchzhSdy
         oVfJ+VdTbkUi/Rle5rtnN4F+UwTi0hcsJkkgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NjqQWqCxKJFL60WmXweKSBihswti0KcN7T2tST0hopxcxvYYXxykoG8usNxTT6DuR8
         KaMSx9EThDXoo1Beloe/yOIaiyX9Y5DCZZ5l3GG2ujcH7KK/nP7nsER1Un8D6xkNjI5U
         3JZxel4hlSmTQ/BZRmBp7/Iup0fqzSiRFf8jo=
Received: by 10.224.72.228 with SMTP id n36mr2895271qaj.138.1267752750172; 
	Thu, 04 Mar 2010 17:32:30 -0800 (PST)
In-Reply-To: <ca433831003041730w7ccbc953kad3b600e7b112e0e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141551>

On Thu, Mar 4, 2010 at 8:30 PM, Mark Lodato <lodatom@gmail.com> wrote:
> On Wed, Mar 3, 2010 at 7:02 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> * ml/color-grep (2010-02-26) 3 commits
>> =C2=A0- grep: Colorize selected, context, and function lines
>> =C2=A0- grep: Colorize filename, line number, and separator
>> =C2=A0- Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*
>>
>> There was a comment about not special casing filename coloring?
>
> The disagreement is whether --name-only output should be colored or
> not. =C2=A0In the patch, it is not, which I argue makes more sense. =C2=
=A0When
> --name-only is given, the only thing output is filenames. =C2=A0Havin=
g them
> all be the same color adds no information, and I personally find it
> annoying to see one big block of the same color. GNU grep does color
> the filenames with --name-only. =C2=A0Michael Witten argues that this=
 makes
> the output consistent: whenever it's a filename, it's colored. [1] =C2=
=A0He
> also thinks that matching GNU grep's behavior is important. =C2=A0He =
didn't
> convince me and I didn't convince him, so it would be nice to have
> more opinions on this.

Sorry, forgot the footnote:

[1] Except that GNU grep does not color the filename is "Binary file
<file> matches."  This patch does color it.
