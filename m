From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Sat, 07 Dec 2013 04:00:37 -0600
Message-ID: <52a2f1c59de6f_29836d5e9830@nysa.notmuch>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
 <1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
 <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
 <5281DB46.2010004@bbn.com>
 <5282977b2ecd_3b98795e785e@nysa.notmuch>
 <xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
 <xmqqob5pfa6j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 11:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpEqR-0007ZM-N6
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 11:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab3LGKKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 05:10:38 -0500
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38745 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab3LGKKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 05:10:34 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so1945928oag.24
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 02:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=EBliUxCf6NoC9wNLOnQ1bX8xy7Q7cMEIN96BKr5wtx0=;
        b=riDYw3egjuNRSpbgQ5iB+YEEjKjVOtt6ZB7FmE0dQj4QpEuuDHfT5GxFSoz1pXW4li
         a5oaT7epcXFMen7woVDiFBI+LSetI3ZUNCxSI3s35eiRbEvXMPJnq1RtEO4iMkw0IpMi
         CtPdUzOv6PeLNnx69mIs9fzGLVsXDgFO4uwbuS6xXTyjopl3+5tJvkoSd0rqRgyEsbRP
         QvxClk4JMyvOaJajM8OFmsKoCfM2oKCtuaJ5AzwCeU1Y/TAsBhEJyWCmOIZg2TGtq448
         UogILz43rmQhP+oP2iFnbcFW+tLPxIoPMGHNDv16shekIXTGnoOXcKp4P+JruOOQyovO
         fn/g==
X-Received: by 10.60.59.5 with SMTP id v5mr5990568oeq.30.1386411033329;
        Sat, 07 Dec 2013 02:10:33 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qe2sm3312102obc.1.2013.12.07.02.10.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 02:10:32 -0800 (PST)
In-Reply-To: <xmqqob5pfa6j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238974>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:

> But it does not have to stay that way.  In order to move things
> forward in that direction, this new configuration has to be
> distinguishable from the traditional "refspec", as it embodies a
> different concept.

Is it a different concept?

 % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
 % git fetch origin master

What do you call this thing? ------^

-- 
Felipe Contreras
