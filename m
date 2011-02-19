From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Gitweb complains "404 - No such project" when following links
 from Gmail
Date: Fri, 18 Feb 2011 17:18:30 -0800
Message-ID: <AANLkTim4=vKvNeGLhXzW9Z9eSQ50OriBN7=oqf5_AUnb@mail.gmail.com>
References: <AANLkTinuPsWnaSAhmL3b0Bf3FWUEByRE50j+qD_ov0Qi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jesse Wilson <jessewilson@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 02:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqbTN-0005Ce-5r
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 02:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab1BSBSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 20:18:52 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57868 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1BSBSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 20:18:51 -0500
Received: by iyj8 with SMTP id 8so4086168iyj.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 17:18:50 -0800 (PST)
Received: by 10.42.173.130 with SMTP id r2mr1673246icz.273.1298078330066; Fri,
 18 Feb 2011 17:18:50 -0800 (PST)
Received: by 10.42.225.136 with HTTP; Fri, 18 Feb 2011 17:18:30 -0800 (PST)
In-Reply-To: <AANLkTinuPsWnaSAhmL3b0Bf3FWUEByRE50j+qD_ov0Qi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167245>

On Fri, Feb 18, 2011 at 17:12, Jesse Wilson <jessewilson@google.com> wr=
ote:
> I've seen the following error on all git web deployments I've tried,
> including the Linux Kernel and Android:
>
> =A0 =A0/android/git=A0/
> =A0 404 - No such project
>
> Reproduce this by following this this link from the=A0Gmail web app:
> http://android.git.kernel.org/?p=3Dplatform/frameworks/base.git;a=3Db=
lob;f=3Dcore/java/android/hardware/SensorManager.java
>
> Pasting the same link into a browser's address bar yields a valid
> page. Even reloading it yields a valid page.

I think the issue is Gmail encodes the ";" as %3B. This confuses
gitweb. IMHO, its a bug in Gmail, Gmail shouldn't be encoding ; as %3B
when it creates the anchor.

--=20
Shawn.
