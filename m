From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 06/12] builtin: add rewrite helper
Date: Thu, 24 Apr 2014 18:34:06 -0500
Message-ID: <53599f6e32146_523614ed2ec8e@nysa.notmuch>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
 <1398307491-21314-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nqd3_-1BvUTbS+K=6PRgJON7sdEHE0EJcADLhDb73nqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:44:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdTJo-0006w3-49
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbaDXXog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:44:36 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:46468 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbaDXXod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:44:33 -0400
Received: by mail-oa0-f54.google.com with SMTP id i7so3424801oag.41
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/FbkDRwQnxMSWDW6H3Cb61k0y4aH0Rf/57VoRHe7Aq0=;
        b=ZwDITbnC1OGA5ROnEfl/3ZeXBcwAE0FkABhEtBhhiRSstZsjQ5ISfCg4tHht8uOo7H
         XUgtszMssxFtgRWXWsg7HemsQBuzlTFmryuJoUaD4bEHMCoFG7RM+hr+JbL431OBkmeb
         WZDMHZt0xwzakm61VMnugSmN+HhgtFsWgMMLMzfTv1dEUHh5R0QOAt6/L+RzbYhw9+Up
         5s44ZBJC8Hn8W3bZyHm+QgiuzJgnPSMcpzZSP8Fmz7ur6qj0j9Gshv16Yj65dRvht6YB
         yZwXizKIjv1Lz22D7Yxn9ED/5FrFIgVka4L1b6YnInh7h1L/4eULwIjL7eh9piepoagG
         YAFQ==
X-Received: by 10.182.33.73 with SMTP id p9mr3877266obi.37.1398383073478;
        Thu, 24 Apr 2014 16:44:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm23898516oen.3.2014.04.24.16.44.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 16:44:32 -0700 (PDT)
In-Reply-To: <CALkWK0nqd3_-1BvUTbS+K=6PRgJON7sdEHE0EJcADLhDb73nqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247024>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > So that we can load and store rewrites, as well as other operations on a
> > list of rewritten commits.
> 
> Please elaborate. Explain why this code shouldn't go in sequencer.c.

Isn't it obvious? Because sequencer.c wouldn't be the only user.

-- 
Felipe Contreras
