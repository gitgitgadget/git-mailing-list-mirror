From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 19:09:58 +0700
Message-ID: <CACsJy8BytRtHkq1eXdEXMgjnZuDSOJs33nyQ1=xd4jtSDaZ8BA@mail.gmail.com>
References: <20141113111444.GA15503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:10:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XotEP-00019S-Te
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 13:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbaKMMKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 07:10:30 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:58744 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbaKMMK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 07:10:29 -0500
Received: by mail-ie0-f170.google.com with SMTP id tp5so15689023ieb.29
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 04:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8c3KW6CIOtQ1LfDWgx3Jcwi7O4yZrXtlKGIuWKYpcUY=;
        b=IbAe0vuZWsyb6tmUNDDuneYY6SF4SWxS57dkwQ6yuFPAxz/17WP/zHsB2grmI5GK6q
         Mu5TdwoYHp3lh6+t681eeptZK+jifNGZLm2bp7x0k/WC6gcAEac/Zta228E5ljjbzn9n
         fpnGsSixtF/eQpWkrjqjQ51C18k6wa/vI9WLQsLTUEekYEico89vHu3DdNq/RZbcR4Gi
         KdNgU6MY+/NCpZ6Zc5xG5p4XPJvatUkNb5NDDWxx/d+1bNTthK9upaak8bapS21TCTUA
         9KCvvrbRrzYx+vkGXewgLGP3poeYlfnFtBOy3Y0+kIK3uV2DewZ6+zb7d1p9/Zg8T6dv
         ODHA==
X-Received: by 10.107.17.77 with SMTP id z74mr1267335ioi.86.1415880629085;
 Thu, 13 Nov 2014 04:10:29 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Thu, 13 Nov 2014 04:09:58 -0800 (PST)
In-Reply-To: <20141113111444.GA15503@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 6:14 PM, Olaf Hering <olaf@aepfle.de> wrote:
> Since each .git is almost identical I wonder if there is a reliable way
> to "share" it. The "git clone" man page mentions --shared as a dangerous
> way to do things. It does not give an advice how to manage such cloned
> trees.

If you know what you are doing, you can try git-new-workdir in
contrib/workdir. A safe and reliable version of that is being worked
on, hopefully it'll be released in 2.3.0.
-- 
Duy
