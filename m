From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Huge possible memory leak while cherry-picking.
Date: Fri, 9 Aug 2013 15:39:04 -0500
Message-ID: <CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tSq-0001Mb-QB
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031043Ab3HIUjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 16:39:08 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:39330 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030942Ab3HIUjG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 16:39:06 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so3503439lbd.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pwnKdzggcoGmEuYM1wKSg5bhu1ijQU2IR/Z9zq8Dk3Y=;
        b=D6jaEcfX6yd6rEthpG386XTWg3RTb6EyscVA/DzMSGtToFAnjucw9LBKP0s6ndVyK6
         CW1H8+6xknLvJC/i7vxsUI/jOfFe/SZZJQMSBq3WGb0kzjda6+pb/iP7zAZ5qOMosI6i
         buv/5clARYU2mR31YuP0CUVxmv0/Xf4FFjsHMU3T4oIWCh39dGJqWmTqbDTOYvpmpeor
         O3MSuI6vkDLWgZli/+kkjU2VkP+cY8NH0X0nZReKWZeiAVeHPqbpqQAwCx/KbqOCaWcd
         bwZuoJAT6GXcPgGWgXzTAeymIhYq1rrMxcquHAXRYEO0H4pqRmzrOe4Cx5G23ZxWXxBG
         GXkg==
X-Received: by 10.152.9.233 with SMTP id d9mr6637513lab.33.1376080744319; Fri,
 09 Aug 2013 13:39:04 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 9 Aug 2013 13:39:04 -0700 (PDT)
In-Reply-To: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232028>

On Fri, Aug 9, 2013 at 7:13 AM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=
=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
> I have tried to cherry-pick a range of ~200 commits from one branch t=
o
> another. And you can't imagine how I was surprised when the git
> process ate 8 Gb of RAM and died - before cherry-picking was complete=
=2E

Try this:
http://article.gmane.org/gmane.comp.version-control.git/226757

--=20
=46elipe Contreras
