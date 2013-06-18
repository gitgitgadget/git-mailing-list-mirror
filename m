From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 16:05:47 +0200
Message-ID: <CACuz9s0zRoqnZEzxSbcCe74n+TubGBwcMqbuU+PP1-t4TKXeZA@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <20130618140120.GD4676@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 16:06:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UowYK-0001j3-KF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 16:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871Ab3FROG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 10:06:28 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:56978 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822Ab3FROG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 10:06:28 -0400
Received: by mail-qc0-f175.google.com with SMTP id k14so2293007qcv.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=DC1CfdNjuMNQLoMt8XUSMOhWTBWjteJUAuIAAzS2XqU=;
        b=PKf3/YocoJzNtshewBL1sgWxHIHfomqZmhxBel/NRwW8sFEJSwxeMe+KzzRGwkOtuq
         8w+G3wXq+gX3SsDpNwWfVgSxtCrptGU6WIF9uFvThqFj1tXZjRsqRj8zcEGcAqALVi+C
         O16q6gEVyXcnlKEMOT2368OD44e78XvfKo83HtPSXridmCDc2ZYeYn/Jy1nHaQrBit9V
         fk98cNZnjYg7mxc9YynqAjzsZSczfRp8HMuyU3lrqJsIaUbUfl3SZVgBh+bI0nFHr2Sq
         suLf2rErcJBg3s1UpF0iOdN/raiTsvZlcfidSm7zoB2/glbip713DRULZN72fh7OtDR1
         WIXg==
X-Received: by 10.224.38.74 with SMTP id a10mr22906264qae.42.1371564387195;
 Tue, 18 Jun 2013 07:06:27 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 07:05:47 -0700 (PDT)
In-Reply-To: <20130618140120.GD4676@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228234>

Git reset --keep is not an option as it will abort the operation if
there are local changes,
which is exactly what I want to do: replace files with local changes
but leave file
permissions as they are.
