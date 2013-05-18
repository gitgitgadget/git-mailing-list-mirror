From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sat, 18 May 2013 06:55:33 -0500
Message-ID: <CAMP44s0QYrzVBsmba1PYMG0yo0CpvTnVm=QHfYif6iu_Zo=tNA@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfjs-0004bE-3i
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab3ERLzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:55:38 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:38230 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab3ERLzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:55:37 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so2867578lab.1
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NPdcGJGBFcGytxoLZNxqDVx0aQ60e5bjFSfEhdhJ494=;
        b=iz76S+kTZnfvsVUkQB9vTZTz9Q1aus4CLV9YW32Z/JrekQiA12Yh9Uge0H9wG6tc/F
         gboqcxtlMsLKzcAThJVllsOSixQNldS8dwBYTomlRRBBb5VabgnYHKk9tyE2Qz8hAIYX
         nnf6vLcdNRfGFyhFRBwLf8oMjY76PlLp+Mc5Udx75H0DaANKXxGzvNu37gn3837WHpOh
         OgJadpoUaiPU/OxUTM6E7oRWqVU8rCWGSI9gs1Oz0am2HARXvHWY7cTq5gS+FXofutNj
         uduiAey0IaCN9TWqdwr8xThwPVrx+f7crjvAEmem+RR+zOkof13HYkYyYpuP7/foJZH0
         2AYg==
X-Received: by 10.112.163.71 with SMTP id yg7mr14730558lbb.8.1368878134218;
 Sat, 18 May 2013 04:55:34 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 04:55:33 -0700 (PDT)
In-Reply-To: <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224789>

On Sat, May 18, 2013 at 6:46 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

>  contrib/related/git-related | 124 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100755 contrib/related/git-related

I tried everything and I don't think it's physically possible to make
this script any simpler without severely crippling it's main goal.

-- 
Felipe Contreras
