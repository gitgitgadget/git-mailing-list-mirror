From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat, 5 May 2012 11:52:59 -0500
Message-ID: <20120505165259.GD14684@burratino>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
 <20120505155423.GA14684@burratino>
 <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
 <20120505164736.GC14684@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQiEI-0006Sx-T1
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 18:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205Ab2EEQxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 12:53:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50953 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab2EEQxE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 12:53:04 -0400
Received: by obbtb18 with SMTP id tb18so5657597obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ext7kpEhgO9kpGqYPVCk18FzZnKNTIGTfiSnOZtpXpM=;
        b=r0rTlxz3XqLbbzo/293kW+7/S8IrzGB5aVRmGs0U83BXMqHo3Rlfe0mOecVvKAx58o
         6FC+ux8eae/zhHxohpZRlYmax11gwiVu1eTKbWdhr/1NVSodFytWPVLY48UxYYIEIHv6
         3tyqWTspTIpWJoQpoWEDfTYaxjSOtkTcJURGk3X53B4FhQJ4n1w8TvTmVKyLDKHEpDAu
         bh3AVSJBC6Stua+hGLvmvnT+om+1BVWq06pUGEsPjrFOEh/KDDxAixHI0wL7CqgxQBHZ
         ug1nlGM5kbYLcCgteNUMDto9BeYjoUbfmqhstwIdiJTuUs4vuEe1FcvKgm2ItOrgdSQE
         TkbA==
Received: by 10.50.157.138 with SMTP id wm10mr244345igb.65.1336236784400;
        Sat, 05 May 2012 09:53:04 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id re5sm1957988igb.0.2012.05.05.09.53.03
        (version=SSLv3 cipher=OTHER);
        Sat, 05 May 2012 09:53:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120505164736.GC14684@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197126>

Jonathan Nieder wrote:
>> On Sat, May 5, 2012 at 5:54 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>>> Following a convention similar to the bash-completion project's
>>> proposed future convention doesn't really help compatibility. =C2=A0=
If we
>>> want to be able to include this function in that project without
>>> change some day, we'd have to call it _BC_git_complete. :)
[...]
> Please read again.  "If we want to be able to include this ...".  I
> assume we do not, but that would be the reason to follow their
> convention to the letter.

Quick clarification: I actually think it would be nice to make it easy
to pass maintenance of the git completion script to that project if
automatic option discovery means changes to the script settle down or
if we have less time to work on it some day.  Unfortunately, the
proposed namespace rules[1] (I didn't think the change had happened or
been set in stone yet?) would not make that easy.  Oh well.

[1] http://thread.gmane.org/gmane.comp.shells.bash.completion.scm/2013/=
focus=3D3158
