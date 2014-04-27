From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH 2/2] add csharp userdiff tests
Date: Sun, 27 Apr 2014 16:48:14 +0300
Message-ID: <1D0349EA-542F-46BD-B538-65ACD0A46A81@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org> <31BBCA60-8EC8-43B1-B82F-071324036AC8@xamarin.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 15:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WePQO-00039r-6i
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 15:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbaD0NrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 09:47:16 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:54778 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaD0NrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 09:47:15 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so4066757eek.1
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AH4crj1+6mx4vXaLtc/5wDd4nMXT572q6NrfTDqq0qE=;
        b=mW8pXJVsHHvu6yhThr51Vts/yFPlKaQvnp6tkVyNPAdxe+TfnGO4zUxhZzZu/2tlLV
         ZdC87mwNMymVQZu6mbbWo9p555HJ6G6YtNwv2EiK+z5t4uIK8IhbIJkSYkLgE6gtydlU
         HY8hYBhad2ggtewI5k1iJNT6Hc0EXjbg+XOvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=AH4crj1+6mx4vXaLtc/5wDd4nMXT572q6NrfTDqq0qE=;
        b=j+ie6CfzvhL9Rt7jmo4pPD3UScq6d8Bo785GLuq/UEt1Qt39DgSO1Dp9VF+n2bNg84
         6lUjgeyTYlxcJqs6Jh9wbquAX+YXZ05WMNd2hI7zRrDwWHPs7NxdfNxxD15IMsVfMgI9
         6TdL/B+kYFhnIolIPVhsNIItvS3e0h1r+nWAnOG9mBC93V8t3GzqKLeW9nNf4ZZrHn0k
         BrAF9YXj/NDwipvHBvnQm7P6v3yM4JbkFJwFrsZR4eWRGA7HX83Ntdt3GzhPW2L4jU+o
         AUBRf4RC+fuj7l2QsG979lyjVkcxFxfLMhiexKIWtS5DcuNVyncRriE2O5guBk6yzXVz
         Do1A==
X-Gm-Message-State: ALoCoQmO6z/YXXb8Sa5fRGQG9nDBYOHan6xBcgDc+UuuZ2TiHqdtiCNfS0+JhoUOPYZq+yHt7QBn
X-Received: by 10.14.246.1 with SMTP id p1mr25457921eer.20.1398606434164;
        Sun, 27 Apr 2014 06:47:14 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id a42sm41832528ees.10.2014.04.27.06.47.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 06:47:13 -0700 (PDT)
In-Reply-To: <31BBCA60-8EC8-43B1-B82F-071324036AC8@xamarin.com>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247203>

Ugh, there=92s an empty line at the beginning of the 2nd patch that sho=
uldn=92t be there.

Thanks,
Marius