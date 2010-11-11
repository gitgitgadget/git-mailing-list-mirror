From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: git remote vs. submodules
Date: Thu, 11 Nov 2010 10:11:39 -0500
Message-ID: <AANLkTi=wT4aVfaw3ZSyqPgforOc3fBSLCP8CQMboFOva@mail.gmail.com>
References: <AANLkTinev0W7-mm9wXmnZwY6DxN0Y2X0hJdpBOgM_4q=@mail.gmail.com>
 <4CDBD4D4.1080607@dbservice.com> <AANLkTin=t7RoLTwxc1KOv7_vZi-OgD_Jcu+66-fte6Sq@mail.gmail.com>
 <4CDC04F7.6080801@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 16:13:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGYpx-0002op-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 16:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab0KKPNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 10:13:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41617 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0KKPNH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 10:13:07 -0500
Received: by yxk8 with SMTP id 8so70409yxk.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TY3rnG2rDjMSXkyBK/l2kQvxuuS4xAz8EnSX+18Uhv4=;
        b=iV6VQ5mFtKEUzpKR0vcv7FFgpOWAO/A7Utge0Ih68vXG06EaWPMv4K3+bZHeIR6yL6
         3BJq8pjHAD470UilfeBBBsOVQ8FO//iijJVaq2jOgqGvn+N47EPddi2TOXLJguVy39Kn
         l3mtLW8O9tc+wS5JaVOGWeCB50apGpf0GV/rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pt2E+DWDgsr+6zBoPmO3vQk0yqCfSLqeDyAWzxLLELyTZx3Ds7jxGUhdvT6mPjVYd3
         oySRwEYs6b1+K5zcy7twvcxTfr7rLirn1Zzhn59xu0FtYnhmZUpDA8R6yurajU6veWhS
         y/N9j2XC425aPreIFr9EO+Jz5N42UI2wy1G5I=
Received: by 10.223.108.147 with SMTP id f19mr256081fap.68.1289488319235; Thu,
 11 Nov 2010 07:11:59 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Thu, 11 Nov 2010 07:11:39 -0800 (PST)
In-Reply-To: <4CDC04F7.6080801@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161265>

On Thu, Nov 11, 2010 at 10:00 AM, Tomas Carnecky <tom@dbservice.com> wr=
ote:
> On 11/11/10 3:44 PM, Patrick Doyle wrote:
>> On Thu, Nov 11, 2010 at 6:34 AM, Tomas Carnecky <tom@dbservice.com> =
wrote:
>>> Are you maybe looking for a subtree merge?
>>> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-s=
ubtree.html
>>
>> Yeah, that looks like it. =A0I never would have hit upon the read-tr=
ee
>> step by myself -- I would have just laid things out with the prefix
>> already embedded in the subprojects.
>>
>> Hmmm... it seems to me that feeding changes back to the subprojects
>> might be difficult (and that is born out by a comment at the end of
>> the page you referenced.)
>
> https://github.com/apenwarr/git-subtree, it makes exactly that easier=
=2E

That looks cool too!  Thanks.

--wpd
