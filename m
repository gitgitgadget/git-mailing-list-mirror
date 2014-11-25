From: Stefan Beller <sbeller@google.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Mon, 24 Nov 2014 19:40:30 -0800
Message-ID: <CAGZ79kZkqVZ+G-J+HKDwmK+W80E_28DyvxKVpEACPXoX88KLAA@mail.gmail.com>
References: <5468C33E.2080108@whonix.org>
	<20141117212657.GC15880@peff.net>
	<CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
	<CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
	<20141125012359.GR6527@google.com>
	<CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 04:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt6zU-0002m2-1x
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 04:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaKYDkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 22:40:32 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:64031 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaKYDkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 22:40:31 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so4659930iga.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7jDCtT7lmOnxXRHRJ3x4envmCW3rEaKvIl/cJyi5Vuo=;
        b=S5XNQRIim/LXFfZmcW+XAfww33JD7t7rou1BN8u1zW/Ht2yVoCHPO+prslxTXhSAfi
         LO2ajxkJ0hw8mL20TjtCedyRWJY1O3qvprmkxjNtCbm6H9p7BdLJNQfgihdhXBD1dLtU
         PnOkm9WdPiXxlHOnERTy6BvavP1IX1P+yPN82SqTG77YsJPkpSNlfATIw/DnSqlO8JHg
         tgA5D+IG4c/xlAt0li7Nx8SVM3PZ9lXI/ZseacOSJDBy+gWeRqxabIgZKN+pPDdhYTLm
         +OVBj/nzMQsSRsR46VviZEmsj+UggIxQDcxZ8q7YNAU29qTdVZ386IF0P+zQPKp+7csM
         iFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7jDCtT7lmOnxXRHRJ3x4envmCW3rEaKvIl/cJyi5Vuo=;
        b=l7jk6fo2LCYv1L+qmMCUhTrIGAL9rHFelIoQkuUhRDbVxxzE+/hA9/QIxLu6zlN0qW
         dd2zHY8hI5V2Ceas4tOCLiuouGLxjqXAd1JZIazEfdu8/CS+ibqrhI5rje3JxDyobfup
         Y4WvkAAWVSrwRchK2Q2LoE4FAFQ7OeMi2i/i+/Hse2UMq6l0eIbPTYA+N6RFRmuwdiWh
         13VxUyBA/6kKx2shm+H0o8HCg4Y6CfuWz3g+4rZgxMQ/JaLc7XGg1uYrBERkXAYcAexn
         xQy+ZbQZoh9nvFBfb9HlLUWMvAdvgn6r7ywRuJz5an/9r4lEBj40by+b2fVqjm59YnQb
         Piog==
X-Gm-Message-State: ALoCoQmndE5GryS5dYBi+B+L08lhsacbbZI0+6doUzgHy2LLaL/gTDNzuyK+6g/r38aoMVymS8v4
X-Received: by 10.107.153.135 with SMTP id b129mr21885589ioe.49.1416886830778;
 Mon, 24 Nov 2014 19:40:30 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 24 Nov 2014 19:40:30 -0800 (PST)
In-Reply-To: <CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260184>

That's not *as* painful, because you'd have the beautiful
fast-{import/export} tools in your new and old version control system.
But yeah, there might be better ways to do so.


On Mon, Nov 24, 2014 at 5:52 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Nov 25, 2014 at 8:23 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> I think the biggest obstacle is the upgrade path. ;-)
>
> In the worst case we can always treat new repos as a different VCS. So
> people will need a migration from SHA-1 to the new format, just like
> they migrate from SVN/CVS to Git. Painful but simple.
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
