From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sun, 28 Jun 2015 21:44:32 -0700
Message-ID: <xmqqwpyncedr.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
	<1435232596-27466-1-git-send-email-karthik.188@gmail.com>
	<xmqqsi9ce0xj.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTkq9NWSu-Bd1iwxYD1yj9+URuQSopc_qjgxSbBv2t2uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 06:44:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9Qvy-0002pS-4B
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 06:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbF2Eog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 00:44:36 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37789 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbbF2Eoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 00:44:34 -0400
Received: by igblr2 with SMTP id lr2so45415638igb.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 21:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tH+YrlhRaqNbsAHNed2nbPNp8irp2AFusEP/RHTArlA=;
        b=D8zj7puZFcirAYiI/y25aFRExDyAo5R0DoNSCOwzCsvPV1GpDUV6DgAq8IasaPa0Rh
         ubKoMZQ4DK7BLYjcP1r8t/M7k4RH0ThU4dveGVN/VY6y/pTpYZCqPrXLXNx7NnSfXXlW
         ei6MyclKwxbs4t94/wwH/LTV8XodoSC+THw+GCsXHteZnGMtroP5+0Bbr7CiSVKgLSRw
         d+QS0EY+QOauK/+/APTbYSBu2xERuCeRlzneqQnCWklsl642ARTyWDf3jvwWtVPEGIaV
         xuSZGyL9ZlUxWBWlgTqI3oo5gvNm5M0wflxccOGSCPchEpOblX8mAbMPqhre6CvqLLMA
         Q4Cw==
X-Received: by 10.50.143.104 with SMTP id sd8mr12570341igb.14.1435553073902;
        Sun, 28 Jun 2015 21:44:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id qs10sm4687971igb.14.2015.06.28.21.44.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 21:44:33 -0700 (PDT)
In-Reply-To: <CAOLa=ZTkq9NWSu-Bd1iwxYD1yj9+URuQSopc_qjgxSbBv2t2uA@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 28 Jun 2015 14:43:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272933>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Sun, Jun 28, 2015 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Why would we even want this kind of thing in the first place?  Is
>> this to make it possible to re-implement some option that exists
>> already in 'git branch' or 'git tag' as a thin wrapper on top of
>> this underlying feature?
>> ...
>
> Well this is to support the printing of tag in `git tag -l`,...

OK, then.
Thanks.
