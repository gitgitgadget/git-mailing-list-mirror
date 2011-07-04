From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: [PATCH] git svn : hook before 'git svn dcommit'
Date: Mon, 04 Jul 2011 07:54:19 +0200
Message-ID: <4E11558B.90708@gmail.com>
References: <vpqfwmos5sg.fsf@bauges.imag.fr>	<1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com> <vpq62njaxl2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 04 07:54:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qdc78-00078J-8D
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 07:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab1GDFy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 01:54:29 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:54897 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab1GDFy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 01:54:28 -0400
Received: by fxd18 with SMTP id 18so4919631fxd.11
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=f+lbS8gssjq/TMyp/ExBRdyIo0jfvEb4iNcOyWDMQqI=;
        b=sTRPmjJxI4eyujZT3MJIinRGTOAmrENvMOaCQqrK1g7ibqAQmf3sLGCAbUjx/YZc2W
         O2IGZ777ZjcSmAEbx0g2tAg569Nijl8KF45LQLlalH5+kYbN4zcfgwJNcO8a7P//JMPm
         dpmV/Wh6GAMATefTM46KczcWIFCDGrEJqiXtA=
Received: by 10.223.76.16 with SMTP id a16mr4830494fak.47.1309758867180;
        Sun, 03 Jul 2011 22:54:27 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id m5sm4282570fai.1.2011.07.03.22.54.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 22:54:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <vpq62njaxl2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176591>



Le 03/07/2011 23:00, Matthieu Moy a =E9crit :
> Fr=E9d=E9ric Heitzmann<frederic.heitzmann@gmail.com>  writes:
>
>> The 'pre-svn-dcommit' hook is called by 'git svn dcommit' and can be=
 used to
>> prevent some diff to be committed to a SVN repository. It may typica=
lly be
>> used to filter some intermediate patches, which were committed into =
git but
>> must not find their way to the SVN repository.
> Why 2 patches?
>
> We usually try to have each commit as correct as possible (e.g. when
> sending several patches, each commit should still pass the testsuite)=
=2E
> With your 2-patches serie, the first commit has documentation for a
> feature which doesn't exist yet.
I find it easier to separate commits on documentation from code patch,=20
especially for rereading and dicussing.
However, if it is desirable to get them merged, I could do that easily.

As for the order :
patch 1/2 : perl magic
patch 2/2 : documentation update
=3D>  the serie looks in the right order to me.
