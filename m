From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: pushing remote branches
Date: Sun, 15 Nov 2009 06:15:00 +0530
Message-ID: <2e24e5b90911141645n59680856ja21f2f3c7063f7c0@mail.gmail.com>
References: <hdneuv$nc8$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lorenzo Bettini <bettini@dsi.unifi.it>
X-From: git-owner@vger.kernel.org Sun Nov 15 01:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9TF2-0003o7-K8
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 01:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbZKOAo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 19:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbZKOAo4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 19:44:56 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:60751 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbZKOAoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 19:44:55 -0500
Received: by iwn8 with SMTP id 8so3493239iwn.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=up4nQ4Fh3unSPtsEzWzcTQLciW3n8E9IssSVrWWyLiE=;
        b=flOtqSvH/t7JH/zyY8mHryF2HcMX/OSNoAnnuAOd5IkEHgXEXgM8lK3V9kQyZV9Jur
         MKtd3o3VrcQe6T56Ll91WMHRfz981gridQSKR+nl9ove/FOkmnPhNNk3987kkW31zfMm
         j8GhluxyzGuwWydbygXgk7fjrveqfUnMGxh5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=v7iBtH+YNZkRAGOnbbpiz2JcT2WVkqVIdMxRdEZFCJTx5mXuhq4+vuH17PZX0RekTE
         753jfEIsKj9JOlTshOO9FXvF8Cxu9NXYN8kiKBa/lYoyjWBgb0GQBE1zABOzKe8AAKw2
         Ew0xyi18ze52YobAhb2rK427NuPpzATynyrRc=
Received: by 10.231.158.205 with SMTP id g13mr3064728ibx.30.1258245900554; 
	Sat, 14 Nov 2009 16:45:00 -0800 (PST)
In-Reply-To: <hdneuv$nc8$2@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132901>

Hi Lorenzo,

On Sun, Nov 15, 2009 at 5:07 AM, Lorenzo Bettini <bettini@dsi.unifi.it> wrote:

>            url = git://...

> isn't this enough to be able to push the experiments branch?

not normally.

The "git://" protocol is a read-only protocol by default.  Since it is
completely unauthenticated, enabling push via git:// is not a good idea in
general.

>            url = git@...

This is a shortcut for something like ssh://git@..., which then allows write
also.
