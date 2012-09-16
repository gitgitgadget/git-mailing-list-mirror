From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH 2/3] rebase -i: Teach "--edit-todo" action
Date: Sun, 16 Sep 2012 11:49:47 -0400
Message-ID: <5055F51B.9070601@gmail.com>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com> <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com> <1347739709-15289-3-git-send-email-andrew.kw.w@gmail.com> <7v1ui2zccc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 17:53:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDH9j-000058-8o
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 17:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab2IPPxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 11:53:01 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62240 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab2IPPxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 11:53:00 -0400
Received: by ieje11 with SMTP id e11so8455151iej.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Lo90itNAUz/jQWc5LKfZHLX7aukP/HHsGF31nnHM19A=;
        b=RLBvsDPvQc9ITVLmfuA3ML9HNJkTmzI42TX4B7v1QNTthQp0k1YwXr3DKaTGtZlPZx
         Ehw9jW1tsdJL6ZOzhd54zmIGCFMAGgFamkkQLlJYK3FSp4kcpKYFev4WgBs+MQX1S5Jc
         l4TpOi8OuTNhz7oXZMZKAftOfcw0RnrN9v08aBm5nCRErSzhFZHwonJrFkFrAP5zRmxj
         Wk72iXPqkzentMAxC5JQF8v9RK3TZ4eJiE1TT7AVY8lB2RodO4GRDjm5mMwC/elsl1SA
         YTF6RmycPhKkcqDGTwbDXrryAIbkzZTrrhDLlKCPY6etEn6YLmryPHLGTXirVw9mJmbx
         y32g==
Received: by 10.50.181.168 with SMTP id dx8mr4420156igc.8.1347810780163;
        Sun, 16 Sep 2012 08:53:00 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id i2sm4487366igl.8.2012.09.16.08.52.57
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 08:52:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120602 Thunderbird/10.0.4
In-Reply-To: <7v1ui2zccc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205625>

On 09/16/12 02:54, Junio C Hamano wrote:
> In any case, what information are you discarding and then replacing
> with the standard boilerplate?
It's to strip out the comment that says:

    # However, if you remove everything, the rebase will be aborted.

As there's no way reliable way to know where that line is and remove it,
the only way I can think of is to remove all the comments, and append
the help messages again.
