From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Tue, 13 May 2014 13:05:31 -0500
Message-ID: <53725eeb1cab5_7774d392f87c@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Martin Langhoff <martin@laptop.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 20:16:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHFg-000266-KY
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663AbaEMSQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:16:29 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56360 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaEMSQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:16:28 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so854681obc.28
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=E5zIieCc6eKKOkFniwxB2iFHTz/DZJzYs0Z2NIEyLqU=;
        b=sCP3fa8ZciD4f32XdW9IP3LVjsStAVA5zoMPk+/nzp99yxGYzhAUAqNAURtcnAPz2H
         zZExpiEJq+gCa/MjEpHVtnhRVLTMA1jm0ESNq0IY5UUeb52KjwZxmFeUT9G6v1810UH+
         ZSbnuYg37umV8y4SDjmP+X7Vxyf1vYBhxqscwxABZ42TINiQHiTjqlPbsY0b45Z9oASq
         LJj1VwFCh46o+E8FVwf5oDBa+IfZU10KUouMYHrlSsDmSEmg1u2hzIqhqEVJoge1Mzgh
         hpWq08F7j8P6CHV7cie7rJSjKIfHHb/kM1cHJl9HZMvpPxfVvD3G4pSeuBsCwe4EDTpe
         FXOA==
X-Received: by 10.182.225.137 with SMTP id rk9mr43160402obc.51.1400004987442;
        Tue, 13 May 2014 11:16:27 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cp5sm4247108obb.15.2014.05.13.11.16.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 11:16:26 -0700 (PDT)
In-Reply-To: <CAAhxitED0iV+Pcird2kZzt3nSnr83+isBDZF2Czmh0LzNzQf8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248795>

Martin Langhoff wrote:
> On Thu, May 8, 2014 at 9:33 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > No updates since 2010, and no tests.
> 
> NAK.
> 
> IMHO, this is quite unfriendly.
> 
> Is this removal based on your opinion, or Junio's position (or
> consensus from maintainers from the list)? If there is a clear
> consensus or direction for old code such as this, please let me know
> (but copy martin.langhoff@gmail.com, not just my very old address!).

This tool doesn't even work anyway. Why do we want to distribute code
that doesn't work?

-- 
Felipe Contreras
