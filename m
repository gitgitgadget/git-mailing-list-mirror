From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Mon, 16 Mar 2015 13:11:52 +0600
Message-ID: <CANCZXo7WzDZ1OnFqNwMe+c1vdjCMg4_4KwwW4FRpEPr7FTF3sQ@mail.gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cR52GKNZkgsytUrb0m3wwY2T68cxjNB_OV+uLxvQUh=VA@mail.gmail.com>
	<xmqqtwxmt43h.fsf@gitster.dls.corp.google.com>
	<D9562ECC995343B3A51D449DC2B46CBC@PhilipOakley>
	<xmqq4mpmszf2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 08:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXPBu-00042R-47
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 08:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbbCPHLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 03:11:53 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:32861 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbbCPHLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 03:11:53 -0400
Received: by oibu204 with SMTP id u204so30323902oib.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=56qT13d6OIBtKZFBULvTLh1OkAsC648pgP/Go8DMFbI=;
        b=oUWu+YAm7GG5tbheoN1T1bLtXC47Apwxe5mKo/sJR2OyHUT/Wrsnwc2+Q1z6NdmEo3
         Me5u6PHJ7ZyMgrFz7NyBSYmvxli8v3PMDWmj/P9X+vCBCTC/X9AXtF2YapdyFarjQ0U0
         JtmBN2s3jKlMia7LO3JnFd7BBSfz4lisabIfCUjMJViOSk8TgGtJRqu5hZYZ0xOPn+Ab
         qt5pZOBQUN7GyeMn3SWnIbM/MdB31zX9Mtc0bWf2yaE7VOIbSOOIyEpRsI5rX8E3visz
         WTW1u3G+1syvFfWeZEh+u7fe1FTG6Fx6mdNBQ2ADUh+NCkNKFjtn4c0Szsm+32JE/PxL
         lDxQ==
X-Received: by 10.182.92.165 with SMTP id cn5mr46527112obb.10.1426489912461;
 Mon, 16 Mar 2015 00:11:52 -0700 (PDT)
Received: by 10.182.197.10 with HTTP; Mon, 16 Mar 2015 00:11:52 -0700 (PDT)
In-Reply-To: <xmqq4mpmszf2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265546>

>> Isn't the problem one of "how are users to discover such magic".

Yes it was main reason.
