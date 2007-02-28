From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Wed, 28 Feb 2007 17:54:42 +0600
Message-ID: <200702281754.42383.litvinov2004@gmail.com>
References: <200702281036.30539.litvinov2004@gmail.com> <Pine.LNX.4.64.0702272039540.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 12:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMNOk-00076T-Pd
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 12:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbXB1Lyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Feb 2007 06:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbXB1Lyv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 06:54:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:8305 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbXB1Lyu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Feb 2007 06:54:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so91485uga
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 03:54:49 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xk+SvpwmRXqaGcFQki1Hnewac1CIVS9E5R4SpnNG4HX+p8oXTXxxaDmEAba6D2s24onkoqhql9w0VTVhIYJqZED73cr7A4kxFlRtd9LzmNBiLYgqWu6yWU+Xyg2GudyJOxuArP34TiBoX/M5OAMTzAaHKvW3yFNnM175ibRMLDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Tm+e+SenGqk/z/LZiGGVwhb1o9aMO3+IKR9LQf8kCBmw41/65asiyl/6Lo5lqFPkkJ8PFYB0tBsx6gn96UYHvQ3i0iIhhBh7zfELpReFYoTBshvF6ySaDSoj37pfYyIOy40DWUd7bcoHvD9eCPkHvDKI92AIF26qNd9myulDHtc=
Received: by 10.66.244.11 with SMTP id r11mr513231ugh.1172663689380;
        Wed, 28 Feb 2007 03:54:49 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id m1sm476003uge.2007.02.28.03.54.47;
        Wed, 28 Feb 2007 03:54:48 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0702272039540.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40916>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Wednesday 28 February 2007 10:57 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB(a):
>  - replace any broken and/or missing objects
>
>    This is the challenging part. Sometimes (hopefully often!) you can=
 find
>    the missing objects in other copies of the repositories. At other
>    times, you may need to try to find the data some other way (for
>    example, maybe your checked-out copy contains the file content tha=
t
>    when hashed will be the missing object?).

Thanks for answer. I have found this blob in cloned repo. I just copy i=
t into=20
objects subdir and repack repo again. fsck works without any errors.

Thanks again.
