From: Stefan Beller <sbeller@google.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 17:23:32 -0700
Message-ID: <CAGZ79kaGp==-On6HBf5X+jr+0d6mWmHQbsPSBQoRG0S=cqddQA@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:23:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzFc-0001JR-4v
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbcCPAXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:23:37 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34436 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbcCPAXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 20:23:33 -0400
Received: by mail-yw0-f182.google.com with SMTP id h129so42813016ywb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zJGJrZtZePep5tkZHvk6IwLvoIt/IqWan8EtHGyJPG8=;
        b=L9nFX0PZGDEHA+7nWUvGCFA2u/frBaJxTlVDO0C63nuxFMVVvyY+3Mo5pxD3hrO2tS
         BPG7He04/CJSuF+iqX30L06YoTM86/0Zm8ieh60jOmT3L5iNCswFYPyYX5eZ9vm+9RID
         pbt83T9Tc0vFihtEt5BWEzGoitgzCjtXhXXadDsmBJbqsqzncI0ITTPkcCOyr7V5+lYX
         AHNnYaKyTo22a4YAJVsdhz7al9qFGIB0q1CmWYZtxCTzaq1WewDlBig+vALJ2qVXvt0/
         L1ZYphrz6XaqzJljR7KHnPS9HSQE+9GWuHRncRp4X1c6spaSEajAguIAZ/vG8FYD89p+
         YssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zJGJrZtZePep5tkZHvk6IwLvoIt/IqWan8EtHGyJPG8=;
        b=COGzSdjXYZca8zb3BEH8xxplduU9SXnyJ/No3BknWXg0xXydm+ov7D0sn/LAIKwUq1
         32cCeGtjES5nLHNWuLxKq+FGnb5b0/zSn1tOqz0pbaHCbHRT2wzQNwyW7He8ifG7nBLm
         eD8zkl+KXffvsy31rhoeYNCgmgaUQEyWhr17f2ZvCD7wLv0Cgk0+wvqmYQMoitcA/J4u
         GgIS/j+fKoplynjGKpFYF//xOO7uv9a4mj+a016iOwq+KXfo69vkvtqxHvbzH924Pmdv
         aYWLoraVKG7ucgHT9QC2/bGMwhcIR+sar6zFeKI5S3+71UqOfJKzcRbClVsQ6yJDAKf8
         7xVA==
X-Gm-Message-State: AD7BkJIQ9OrOBR14YeJVv9S69jHVexBScTEZijt+MrinKIaTRDKUrQcH/Mm2aX+U7go9dA+jhvuWdicBOgRJIVlw
X-Received: by 10.129.134.133 with SMTP id w127mr418286ywf.252.1458087812782;
 Tue, 15 Mar 2016 17:23:32 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 15 Mar 2016 17:23:32 -0700 (PDT)
In-Reply-To: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288930>

On Tue, Mar 15, 2016 at 5:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Do people hate that idea? I may not get around to it for a while (it's
> the kernel merge window right now), but I can write the patch
> eventually - I just wanted to do an RFC first.

Could you point at some example to better understand the problem?

Thanks,
Stefan

>
>                 Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
